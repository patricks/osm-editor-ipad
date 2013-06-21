//
//  ViewController.m
//  MagnifyingGlassTest
//
//  Created by Patrick Steiner on 21.06.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import "ViewController.h"
#import "ACMagnifyingGlass.h"
#import "ACLoupe.h"
#import "PSEditingTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


    ACMagnifyingGlass *mag = [[ACMagnifyingGlass alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    mag.scale = 2;
    _magnifyingView.magnifyingGlass = mag;
    
    PSEditingTool *editingTool = [[PSEditingTool alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    editingTool.scale = 2;
    _editingView.editingTool = editingTool;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
