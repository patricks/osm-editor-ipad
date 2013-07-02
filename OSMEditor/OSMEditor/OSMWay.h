//
//  OSMWay.h
//  OSMEditor
//
//  Created by Patrick Steiner on 23.06.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Representation of a OpenStreetMap way. */
@interface OSMWay : NSObject

/** ID of the way. */
@property (nonatomic, retain) NSNumber *identifier;

/** Nodes of the way. */
@property (nonatomic, retain) NSMutableArray *nodes;

/** Tags of the way. */
@property (nonatomic, retain) NSMutableDictionary *tags;


/** Returns the color of the way.
 * @return The color as UIImage.
 */
- (UIColor *)getWayColor;

/** Returns YES if the ways should be filled, else it returns NO.
 *
 * Example If the way has a tag like building=yes the way should be filled.
 * @return YES or NO.
 */
- (BOOL)fillShape;

@end
