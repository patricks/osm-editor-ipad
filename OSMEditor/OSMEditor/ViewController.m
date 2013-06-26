//
//  ViewController.m
//  OSMEditor
//
//  Created by Patrick Steiner on 21.06.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import "ViewController.h"
#import "OSMNode.h"
#import "OSMWay.h"
#import "MBProgressHUD.h"

@interface ViewController ()
{
    BOOL enableEditView;
}

@property (nonatomic, strong) RMMapView *mapView;
@property (nonatomic, strong) RMMapBoxSource *tileSource;
@property (nonatomic, strong) PSEditingView *editingView;
@property (nonatomic, strong) PSEditingTool *editingTool;
@property (nonatomic, strong) OSMServerParser *parser;

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
    _tileSource = [[RMMapBoxSource alloc] initWithMapID:@"patricks.map-4jjcq070"];
    _mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:_tileSource];
    _mapView.showLogoBug = NO;
    _mapView.delegate = self;
    
    CLLocationCoordinate2D homeCoordinate;
    homeCoordinate.latitude =48.36861;
    homeCoordinate.longitude = 14.51277;
    
    [_mapView setCenterCoordinate:homeCoordinate];
    
    enableEditView = NO;
    [self enableEditMode:enableEditView];
    
}

- (void)enableEditMode:(BOOL)enable
{
    if (enable) {
        [_mapView setUserInteractionEnabled:NO];
        [_mapView setHidden:YES forTileSource:_tileSource];
        
        _editingView = [[PSEditingView alloc] initWithFrame:self.view.bounds];
        _editingView.backgroundColor = [UIColor blueColor];
        
        _editingTool = [[PSEditingTool alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
        _editingTool.scale = 2;
        _editingTool.delegate = self;
        
        _editingView.editingTool = _editingTool;
        
        
        [_editingView addSubview:_mapView];
        
        [self.view addSubview:_editingView];
    } else {
        [_mapView setUserInteractionEnabled:YES];
        [_mapView setHidden:NO forTileSource:_tileSource];
        [self.view addSubview:_mapView];
    }
}

- (IBAction)downloadOSMClicked:(id)sender
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Downloading";
    
    RMSphericalTrapezium currentBounds = [_mapView latitudeLongitudeBoundingBox];
    [_parser requestDataFromServerWithBoundsOfSouthWest:currentBounds.southWest andNorthEast:currentBounds.northEast];
}

- (IBAction)editModeClicked:(id)sender
{
    if (enableEditView) {
        enableEditView = NO;
    } else {
        enableEditView = YES;
    }
    
    [self enableEditMode:enableEditView];
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

-(void)didFinishedParsingWithNodes:(NSArray*)nodes andWays:(NSArray *)ways
{
    //TODO: create new class
    // hide download hud
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"DBG: Download finished with %i nodes and %i ways", [nodes count], [ways count]);
    
    //MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.labelText = @"Parsing";
    
    
    
    for (OSMWay *way in ways) {
        NSMutableArray *wayLocations = [[NSMutableArray alloc] init];
        for (NSNumber *ref in way.nodes) {
            for (OSMNode *node in nodes) {
                if ([node.identifier doubleValue] == [ref doubleValue]) {
                    [wayLocations addObject:[[CLLocation alloc] initWithLatitude:node.location.latitude longitude:node.location.longitude]];
                }
            }
        }
        
        //NSLog(@"DBG: way locations %i", [wayLocations count]);
        
        
        RMAnnotation *wayAnnotation = [[RMAnnotation alloc] initWithMapView:_mapView
                                                                 coordinate:((CLLocation *)[wayLocations objectAtIndex:0]).coordinate
                                                                   andTitle:@"WAY"];
        
        wayAnnotation.userInfo = wayLocations;
        [wayAnnotation setBoundingBoxFromLocations:wayLocations];
        [_mapView addAnnotation:wayAnnotation];
        
    }
    
    /*
    for (OSMNode *node in nodes) {
        for (id key in node.tags) {
            if ([key isEqualToString:@"natural"]) {
                RMAnnotation *nodeAnnotation = [[RMAnnotation alloc] initWithMapView:_mapView
                                                                          coordinate:node.location
                                                                            andTitle:@"NODE"];
                
                [_mapView addAnnotation:nodeAnnotation];
            }
        }
    }
     */
    
    
    /*
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^(void) {
    
        for (OSMNode *node in nodes) {
            RMPointAnnotation *newAnnotation = [[RMPointAnnotation alloc] initWithMapView:_mapView coordinate:node.location andTitle:node.name];
            
            [_mapView addAnnotation:newAnnotation];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //TODO: is this required?
            sleep(1);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view setNeedsDisplay];
        });
    });
     */
    
    
}

- (RMMapLayer *)mapView:(RMMapView *)mapView layerForAnnotation:(RMAnnotation *)annotation
{
    if (annotation.isUserLocationAnnotation) {
        return nil;
    }
    
    RMShape *shape = [[RMShape alloc] initWithView:mapView];
    
    shape.lineColor = [UIColor orangeColor];
    shape.lineWidth = 3.0;
    
    for (CLLocation *location in (NSArray *)annotation.userInfo) {
        [shape addLineToCoordinate:location.coordinate];
    }
    
    
    return shape;
}

@end
