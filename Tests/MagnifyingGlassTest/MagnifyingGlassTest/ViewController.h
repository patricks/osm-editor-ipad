//
//  ViewController.h
//  MagnifyingGlassTest
//
//  Created by Patrick Steiner on 21.06.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACMagnifyingView.h"
#import "PSEditingView.h"

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet ACMagnifyingView *magnifyingView;
@property (strong, nonatomic) IBOutlet PSEditingView *editingView;

@end
