//
//  ShapeItem.h
//  OSMEditor
//
//  Created by Patrick Steiner on 01.07.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ShapeItem : NSObject

@property (readwrite, assign) CLLocationCoordinate2D location;
@property (nonatomic, retain) UIColor *shapeColor;
@property (nonatomic) BOOL fillShape;

@end
