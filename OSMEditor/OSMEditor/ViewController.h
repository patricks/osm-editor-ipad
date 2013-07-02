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

/** The main view controller of the app.
 *
 * This main view controller shows the main mapview.
 */
@interface ViewController : UIViewController <PSEditingToolDelegate, OSMServerParserDelegate, RMMapViewDelegate>

/** Gets called if the download buttons gets clicked. */
- (IBAction)downloadOSMClicked:(id)sender;

/** Gets called if the edit mode button gets clicked. */
- (IBAction)editModeClicked:(id)sender;

/** Gets called if the about button gets clicked. */
- (IBAction)aboutClicked:(id)sender;

@end
