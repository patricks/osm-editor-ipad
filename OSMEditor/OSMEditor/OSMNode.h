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

/** Location of the Node */
@property (readwrite, assign) CLLocationCoordinate2D location;
@property (nonatomic, retain) NSNumber *identifier;
@property (nonatomic, retain) NSMutableDictionary *tags;

- (UIImage *)getNodeIcon;

@end
