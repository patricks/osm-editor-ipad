//
//  ViewController.m
//  OSMEditor
//
//  Created by Patrick Steiner on 21.06.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import "ViewController.h"
#import "OSMServerParser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupMapBoxView];
    [self setupOSMParser];
}

#pragma setup views

- (void)setupMapBoxView
{
    // MapBox View
    RMMapBoxSource *tileSource = [[RMMapBoxSource alloc] initWithMapID:@"patricks.map-4jjcq070"];
    RMMapView *mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:tileSource];
    
    CLLocationCoordinate2D homeCoordinate;
    homeCoordinate.latitude =48.36861;
    homeCoordinate.longitude = 14.51277;
    
    [mapView setCenterCoordinate:homeCoordinate];
    
    RMPointAnnotation *annotation = [[RMPointAnnotation alloc] initWithMapView:mapView
                                                                    coordinate:mapView.centerCoordinate
                                                                      andTitle:@"Node"];
    [mapView addAnnotation:annotation];
    
    
    // Editing View
    PSEditingView *editingView = [[PSEditingView alloc] initWithFrame:self.view.bounds];
    editingView.backgroundColor = [UIColor blueColor];
    
    PSEditingTool *editingTool = [[PSEditingTool alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    editingTool.scale = 2;
    editingView.editingTool = editingTool;
    
    
    //[editingView addSubview:mapView];
    //[mapView addSubview:_editingView];
    
    [self.view addSubview:editingView];
    //[self.view addSubview:mapView];
}

#pragma OpenStreetMap stuff

- (void)setupOSMParser
{
    OSMServerParser *parser = [[OSMServerParser alloc] initWithURL:nil];
    
    //[parser requestDataFromServer];
}

@end
