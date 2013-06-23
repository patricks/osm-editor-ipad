//
//  OSMServerParser.m
//  OSMParsingTest
//
//  Created by Patrick Steiner on 31.05.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import <AFNetworking.h>
#import "OSMServerParser.h"
#import "OSMNode.h"

@interface OSMServerParser ( )

@property (nonatomic, retain) NSString *serverURL;

@end

@implementation OSMServerParser

- (id)init
{
    self = [super init];
    if (self) {
        self = [self initWithURL:@"http://api.openstreetmap.org"];
    }
    return self;
}

- (id)initWithURL:(NSString *)initServerURL
{
    self = [super init];
    
    if (nil != self) {
        _locations = [[NSMutableArray alloc] init];
        _serverURL = initServerURL;
        //[self setCache:[[OSPMap alloc] init]];
        //[self setRequestedTiles:[[OSPTileArray alloc] init]];
        //[self setCurrentConnections:[[NSMutableArray alloc] initWithCapacity:OSPMapServerMaxSimultaneousConnections]];
        //[self setConnectionQueue:[NSMutableArray array]];
    }
    
    return self;
}

- (void)requestDataFromServerWithBoundsOfSouthWest:(CLLocationCoordinate2D)southWest andNorthEast:(CLLocationCoordinate2D)northEast
{
    NSString *apiURL = @"/api/0.6/map?bbox=";
    NSString *bboxURL = [NSString stringWithFormat:@"%f,%f,%f,%f", southWest.longitude, southWest.latitude, northEast.longitude, northEast.latitude];
    NSString *requestURL = [NSString stringWithFormat:@"%@%@%@", _serverURL, apiURL, bboxURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
    AFXMLRequestOperation *operation = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
        XMLParser.delegate = self;
        [XMLParser parse];
    } failure:nil];
    [operation start];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    //NSLog(@"Start parsing: %@", elementName);
    
    if ([elementName isEqualToString:@"node"]) {
        //NSLog(@"Found node: lat: %@ lon: %@", attributeDict[@"lat"], attributeDict[@"lon"]);
        
        OSMNode *node = [[OSMNode alloc] init];
        node.location = CLLocationCoordinate2DMake([attributeDict[@"lat"] doubleValue], [attributeDict[@"lon"] doubleValue]);
        
        [_locations addObject:node];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //NSLog(@"Stop parsing: %@", elementName);
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"Start parsing document");
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"Stop parsing document");
    [_delegate didFinishedParsingWithLocations:[NSArray arrayWithArray:_locations]];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"Parsing error");
}

@end
