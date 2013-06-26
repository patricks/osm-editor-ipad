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
#import "OSMWay.h"

@interface OSMServerParser ()
{
    BOOL wayItemOpen;
    BOOL nodeItemOpen;
}

@property (nonatomic, strong) OSMWay *way;
@property (nonatomic, strong) OSMNode *node;
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
    
    NSLog(@"DBG: parsing url: %@", requestURL);
    
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
        nodeItemOpen = YES;
        _node = [[OSMNode alloc] init];
        _node.location = CLLocationCoordinate2DMake([attributeDict[@"lat"] doubleValue], [attributeDict[@"lon"] doubleValue]);
        _node.identifier = [NSNumber numberWithDouble:[attributeDict[@"id"] doubleValue]];
    } else if ([elementName isEqualToString:@"way"]) {
        wayItemOpen = YES;
        _way = [[OSMWay alloc] init];
        _way.identifier = [NSNumber numberWithDouble:[attributeDict[@"id"] doubleValue]];
    } else if ([elementName isEqualToString:@"nd"]) {
        if (wayItemOpen) {
            [_way.nodes addObject:[NSNumber numberWithDouble:[attributeDict[@"ref"] doubleValue]]];
        }
    } else if ([elementName isEqualToString:@"tag"]) {
        if (nodeItemOpen) {
            [_node.tags setObject:attributeDict[@"v"] forKey:attributeDict[@"k"]];
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //NSLog(@"Stop parsing: %@", elementName);
    if ([elementName isEqualToString:@"node"]) {
        nodeItemOpen = NO;
        [_nodes addObject:_node];
    } else if ([elementName isEqualToString:@"way"]) {
        wayItemOpen = NO;
        [_ways addObject:_way];
    }
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"Start parsing document");
    // INFO if you init in the constructor old _nodes / _ways are saved
    _nodes = [[NSMutableArray alloc] init];
    _ways = [[NSMutableArray alloc] init];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"Stop parsing document");
    [_delegate didFinishedParsingWithNodes:[NSArray arrayWithArray:_nodes] andWays:[NSArray arrayWithArray:_ways]];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"Parsing error");
}

@end
