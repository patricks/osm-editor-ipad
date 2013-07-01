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
    
    [infoSection addObject:@"test-info"];
    
    [tagsSection addObject:@"test-tag"];
    [tagsSection addObject:@"test-tag"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"DBG asdf %i", [sections count]);
    return [sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"DBG: sec %i", [sections[section] count]);
    return [sections[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"InfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = @"Foo";
    
    // Configure the cell...
    
    return cell;
}

@end
