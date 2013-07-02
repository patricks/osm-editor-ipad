//
//  OSMNode.h
//  OSMParsingTest
//
//  Created by Patrick Steiner on 31.05.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/** Representation of a OpenStreetMap node. */
@interface OSMNode : NSObject

/** Location of the node. */
@property (readwrite, assign) CLLocationCoordinate2D location;

/** ID of the node. */
@property (nonatomic, retain) NSNumber *identifier;

/** Tags of the node. */
@property (nonatomic, retain) NSMutableDictionary *tags;


/** Returns the icon image of the node.
 * @return The icon as UIImage.
 */
- (UIImage *)getNodeIcon;

@end
