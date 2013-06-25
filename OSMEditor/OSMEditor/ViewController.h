//
//  ViewController.h
//  OSMEditor
//
//  Created by Patrick Steiner on 21.06.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSEditingView.h"
#import "MapBox.h"
#import "OSMServerParser.h"


@interface ViewController : UIViewController <PSEditingToolDelegate, OSMServerParserDelegate, RMMapViewDelegate>

- (IBAction)downloadOSMClicked:(id)sender;
- (IBAction)editModeClicked:(id)sender;

@end
