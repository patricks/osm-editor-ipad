//
//  OSMServerParser.h
//  OSMParsingTest
//
//  Created by Patrick Steiner on 31.05.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol OSMServerParserDelegate;

@interface OSMServerParser : NSObject <NSXMLParserDelegate>

@property (nonatomic, retain) NSMutableArray *nodes;
@property (nonatomic, retain) NSMutableArray *ways;
@property (nonatomic, strong) id <OSMServerParserDelegate> delegate;

- (id)initWithURL:(NSString *)serverURL;
- (void)requestDataFromServerWithBoundsOfSouthWest:(CLLocationCoordinate2D)southWest andNorthEast:(CLLocationCoordinate2D)northEast;

@end

@protocol OSMServerParserDelegate

-(void)didFinishedParsingWithLocations:(NSArray*)locations;

@end
