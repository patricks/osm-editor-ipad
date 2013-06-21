//
//  ViewController.m
//  MapBoxTest
//
//  Created by Patrick Steiner on 28.03.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import "ViewController.h"
#import "MapBox.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    [self.view addSubview:mapView];
}

@end
