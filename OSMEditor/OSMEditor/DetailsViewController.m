//
//  DetailsViewController.m
//  OSMEditor
//
//  Created by Patrick Steiner on 01.07.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController () {
    NSArray *sections;
}

@end

@implementation DetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    sections = [[NSArray alloc] initWithObjects:@"Infos", @"Tags", nil];
    
    _lblOsmNodeID.text = [NSString stringWithFormat:@"ID: %@", [_detailsNode.identifier stringValue]];
    _lblOsmNodeLocation.text = [NSString stringWithFormat:@"Latitude: %f Longitude: %f", _detailsNode.location.latitude, _detailsNode.location.longitude];
    
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    
    for (id key in _detailsNode.tags) {
        id value = [_detailsNode.tags valueForKey:key];
        [tmpArray addObject:[NSString stringWithFormat:@"%@ = %@",key, value]];
    }
    
    NSArray *propArray = [[NSArray alloc] initWithObjects:_lblProp1, _lblProp2, _lblProp3, _lblProp4, _lblProp5, _lblProp6, _lblProp7, _lblProp8, _lblProp9, _lblProp10, nil];
    

    NSUInteger i = 0;
    for (UILabel *label in propArray) {
        if (i < [tmpArray count]) {
            label.text = tmpArray[i];
        } else {
            label.text = @"";
        }
        
        i++;
    }
}

@end
