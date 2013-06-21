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

@interface OSMServerParser ( ) <NSXMLParserDelegate> {
    NSMutableArray *locations;
}

@property (readwrite, copy) NSURL *serverURL;

@end

@implementation OSMServerParser

- (id)initWithURL:(NSURL *)initServerURL
{
    self = [super init];
    
    if (nil != self) {
        locations = [[NSMutableArray alloc] init];
        [self setServerURL:initServerURL];
        //[self setCache:[[OSPMap alloc] init]];
        //[self setRequestedTiles:[[OSPTileArray alloc] init]];
        //[self setCurrentConnections:[[NSMutableArray alloc] initWithCapacity:OSPMapServerMaxSimultaneousConnections]];
        //[self setConnectionQueue:[NSMutableArray array]];
    }
    
    return self;
}

- (void)requestDataFromServer
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.openstreetmap.org/api/0.6/map?bbox=14.50969,48.36803,14.51907,48.37329"]];
    AFXMLRequestOperation *operation = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
        XMLParser.delegate = self;
        [XMLParser parse];
    } failure:nil];
    [operation start];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"Start parsing: %@", elementName);
    
    if ([elementName isEqualToString:@"node"]) {
        NSLog(@"Found node: lat: %@ lon: %@", attributeDict[@"lat"], attributeDict[@"lon"]);
        
        OSMNode *node = [[OSMNode alloc] init];
        node.location = CLLocationCoordinate2DMake([attributeDict[@"lat"] doubleValue], [attributeDict[@"lon"] doubleValue]);
        
        [locations addObject:node];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"Stop parsing: %@", elementName);
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"Start parsing document");
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"Stop parsing document");
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"Parsing error");
}

@end
