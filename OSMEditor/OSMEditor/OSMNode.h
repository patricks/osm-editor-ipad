//
//  OSMNode.h
//  OSMParsingTest
//
//  Created by Patrick Steiner on 31.05.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface OSMNode : NSObject

@property (readwrite, assign) CLLocationCoordinate2D location;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *identifier;

@end
