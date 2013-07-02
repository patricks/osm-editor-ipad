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

/** This class parses the OpenStreetMap data from the server via the RESTful API.
 *
 * Currently verion 0.6 of the API is used.
 */
@interface OSMServerParser : NSObject <NSXMLParserDelegate>

/** All requested and found nodes from the OpenStreetMap Server */
@property (nonatomic, retain) NSMutableArray *nodes;

/** All requested and found ways from the OpenStreetMap Server */
@property (nonatomic, retain) NSMutableArray *ways;

/** Delegate property */
@property (nonatomic, strong) id <OSMServerParserDelegate> delegate;

/** Init the class with a specific server url.
 *
 * If no server url is given the standard OpenStreetMap server is used.
 */
- (id)initWithURL:(NSString *)serverURL;

/** Request data from the OpenStreetMap server by giving a boundigbox.
 * @param southWest The lower-left corner of the bounding box as CLLocationCoordinate2D
 * @param southWest The upper-right corner of the bounding box as CLLocationCoordinate2D
 */
- (void)requestDataFromServerWithBoundsOfSouthWest:(CLLocationCoordinate2D)southWest andNorthEast:(CLLocationCoordinate2D)northEast;

@end

/** This delegate informs the receiver about the parsing status. */
@protocol OSMServerParserDelegate

/** If the parsing is finished this method informs the receiver.
 * @param nodes all requested nodes in a NSArray.
 * @param ways all requested ways in a NSArray.
 */
-(void)didFinishedParsingWithNodes:(NSArray*)nodes andWays:(NSArray*)ways;

@end
