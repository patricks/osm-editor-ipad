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
    NSMutableArray *infoSection;
    NSMutableArray *tagsSection;
}

@end

@implementation DetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    infoSection = [[NSMutableArray alloc] init];
    tagsSection = [[NSMutableArray alloc] init];
    
    sections = [[NSArray alloc] initWithObjects: infoSection, tagsSection, nil];
    
    [infoSection addObject:@"info-id"];
    [infoSection addObject:@"info-lat"];
    [infoSection addObject:@"info-lon"];
    
    NSDictionary *tags = _detailsNode.tags;
    
    for (NSString *key in [tags allKeys]) {
        [tagsSection addObject:[NSString stringWithFormat:@"%@ = %@", key, [tags objectForKey:key]]];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [sections[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"InfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // handle static rows in section 0
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"ID: %@", [_detailsNode.identifier stringValue]];
        } else if (indexPath.row == 1) {
            cell.textLabel.text = [NSString stringWithFormat:@"Latitude: %f ", _detailsNode.location.latitude];
        } else if (indexPath.row == 2) {
            cell.textLabel.text = [NSString stringWithFormat:@"Longitude: %f ", _detailsNode.location.longitude];
        }
    } else if (indexPath.section == 1) { // dynamic rows in section 1
        cell.textLabel.text = tagsSection[indexPath.row];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Informations";
    } else if (section == 1) {
        return @"Tags";
    }
    
    return nil;
}

@end
