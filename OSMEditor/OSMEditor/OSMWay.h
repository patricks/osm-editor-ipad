//
//  OSMWay.h
//  OSMEditor
//
//  Created by Patrick Steiner on 23.06.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSMWay : NSObject

@property (nonatomic, retain) NSNumber *identifier;
@property (nonatomic, retain) NSMutableArray *nodes;
@property (nonatomic, retain) NSMutableDictionary *tags;

- (UIColor *)getWayColor;
- (BOOL)fillShape;

@end
