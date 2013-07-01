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
        _tags = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (UIColor *)getWayColor
{    
    if ([_tags[@"building"] isEqualToString:@"yes"]) { // building
        return [UIColor redColor];
    } else if ([_tags[@"highway"] isEqualToString:@"footway"]) { // footway
        return [UIColor greenColor];
    } else if ([_tags[@"highway"] isEqualToString:@"service"]) { // service
        return [UIColor blueColor];
    } else if ([_tags[@"highway"] isEqualToString:@"unclassified"]) { // unclassified
        return [UIColor orangeColor];
    } else if ([_tags[@"amenity"] isEqualToString:@"parking"]) { // parking
        return [UIColor yellowColor];
    }
    
    return [UIColor grayColor];
}

- (BOOL)fillShape
{
    if ([_tags[@"building"] isEqualToString:@"yes"]) { // building
        return YES;
    }
    
    return NO;
}

@end