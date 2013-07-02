//
//  DetailsViewController.h
//  OSMEditor
//
//  Created by Patrick Steiner on 01.07.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSMNode.h"

/** The detail view controller showes detailed infos about a selected node.
 *
 * In future versions of this controller there will be also support for ways.
 */
@interface DetailsViewController : UITableViewController

/** The selected node to show.
 *
 * This node have to be set from the parent view controller.
 */
@property (nonatomic, strong) OSMNode *detailsNode;

@end
