//
//  ShapeItem.h
//  OSMEditor
//
//  Created by Patrick Steiner on 01.07.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/** Representation of a shape with special properties for the MapBox mapview. */
@interface ShapeItem : NSObject

/** Location of the shape. */
@property (readwrite, assign) CLLocationCoordinate2D location;

/** Color of the shape. */
@property (nonatomic, retain) UIColor *shapeColor;

/** Fill state of the shape. */
@property (nonatomic) BOOL fillShape;

@end
