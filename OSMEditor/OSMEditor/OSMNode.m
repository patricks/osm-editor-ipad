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

- (UIImage *)getNodeIcon
{
    if ([_tags[@"natural"] isEqualToString:@"tree"]) { // tree
        return [UIImage imageNamed:@"osm_tree"];
    } else if ([_tags[@"amenity"] isEqualToString:@"restaurant"]) { // restaurant
        return [UIImage imageNamed:@"osm_restaurant"];
    }
    
    return [UIImage imageNamed:@"osm_point"];
}

@end
