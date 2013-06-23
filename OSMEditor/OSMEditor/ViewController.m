//
//  ViewController.m
//  OSMEditor
//
//  Created by Patrick Steiner on 21.06.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import "ViewController.h"
#import "OSMNode.h"

@interface ViewController ()

@property (nonatomic, retain) RMMapView *mapView;;
@property (nonatomic, retain) PSEditingView *editingView;
@property (nonatomic, retain) PSEditingTool *editingTool;
@property (nonatomic, retain) OSMServerParser *parser;

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
    _mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:tileSource];
    _mapView.showLogoBug = NO;
    
    CLLocationCoordinate2D homeCoordinate;
    homeCoordinate.latitude =48.36861;
    homeCoordinate.longitude = 14.51277;
    
    [_mapView setCenterCoordinate:homeCoordinate];
    
    // Editing View
    BOOL enableEditView = NO;
    if (enableEditView) {
        [_mapView setUserInteractionEnabled:NO];
        [_mapView setHidden:YES forTileSource:tileSource];
        
        _editingView = [[PSEditingView alloc] initWithFrame:self.view.bounds];
        _editingView.backgroundColor = [UIColor blueColor];
        
        _editingTool = [[PSEditingTool alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
        _editingTool.scale = 2;
        _editingTool.delegate = self;
        
        _editingView.editingTool = _editingTool;
        
        
        [_editingView addSubview:_mapView];
        
        [self.view addSubview:_editingView];
    } else {
        [self.view addSubview:_mapView];
    }
}

- (IBAction)downloadOSMClicked:(id)sender
{
    RMSphericalTrapezium currentBounds = [_mapView latitudeLongitudeBoundingBox];
    [_parser requestDataFromServerWithBoundsOfSouthWest:currentBounds.southWest andNorthEast:currentBounds.northEast];
}


#pragma MapBox stuff

- (void)addPOIToMap:(CGPoint)point
{
    CLLocationCoordinate2D newCoordinate;
    newCoordinate.latitude = [_mapView pixelToCoordinate:point].latitude;
    newCoordinate.longitude = [_mapView pixelToCoordinate:point].longitude;
    
    RMPointAnnotation *newAnnotation = [[RMPointAnnotation alloc] initWithMapView:_mapView
                                                                    coordinate:newCoordinate
                                                                      andTitle:@"Node"];
    
    [_mapView addAnnotation:newAnnotation];
    [_editingTool setNeedsDisplay];
}

#pragma OpenStreetMap stuff

- (void)setupOSMParser
{
    _parser = [[OSMServerParser alloc] init];
    _parser.delegate = self;
}

#pragma PSEditingTool delegate methods

- (void)addPOIButtonClicked
{
    CGPoint current = [_editingView currentPosition];
    [self addPOIToMap:current];
}

#pragma OSMServerParser delegate methods

-(void)didFinishedParsingWithLocations:(NSArray*)locations
{
    NSLog(@"DBG: DOWNLOAD IS FINISHED with %i items", [locations count]);
    
    for (OSMNode *node in locations) {
        RMPointAnnotation *newAnnotation = [[RMPointAnnotation alloc] initWithMapView:_mapView coordinate:node.location andTitle:node.name];
        
        [_mapView addAnnotation:newAnnotation];
    }
}
@end
