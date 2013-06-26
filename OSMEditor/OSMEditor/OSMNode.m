//
//  OSMNode.m
//  OSMParsingTest
//
//  Created by Patrick Steiner on 31.05.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import "OSMNode.h"

@implementation OSMNode

- (id)init
{
    self = [super init];
    if (self) {
        _tags = [[NSMutableDictionary alloc] init];
    }
    return self;
}

@end
