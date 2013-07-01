//
//  DetailsViewController.h
//  OSMEditor
//
//  Created by Patrick Steiner on 01.07.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSMNode.h"

@interface DetailsViewController : UITableViewController

@property (nonatomic, strong) OSMNode *detailsNode;

@end
