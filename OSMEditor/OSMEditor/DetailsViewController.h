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
@property (strong, nonatomic) IBOutlet UILabel *lblOsmNodeID;
@property (strong, nonatomic) IBOutlet UILabel *lblOsmNodeLocation;

// TODO: generate a dynamic table view
@property (strong, nonatomic) IBOutlet UILabel *lblProp1;
@property (strong, nonatomic) IBOutlet UILabel *lblProp2;
@property (strong, nonatomic) IBOutlet UILabel *lblProp3;
@property (strong, nonatomic) IBOutlet UILabel *lblProp4;
@property (strong, nonatomic) IBOutlet UILabel *lblProp5;
@property (strong, nonatomic) IBOutlet UILabel *lblProp6;
@property (strong, nonatomic) IBOutlet UILabel *lblProp7;
@property (strong, nonatomic) IBOutlet UILabel *lblProp8;
@property (strong, nonatomic) IBOutlet UILabel *lblProp9;
@property (strong, nonatomic) IBOutlet UILabel *lblProp10;
@end
