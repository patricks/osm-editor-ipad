//
//  OSMWay.m
//  OSMEditor
//
//  Created by Patrick Steiner on 23.06.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import "OSMWay.h"

@implementation OSMWay

- (id)init
{
    self = [super init];
    if (self) {
        _nodes = [[NSMutableArray alloc] init];
    }
    return self;
}

@end