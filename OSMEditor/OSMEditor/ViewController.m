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
#import "DetailsViewController.h"
#import "ShapeItem.h"

@interface ViewController ()
{
    BOOL enableEditView;
}

@property (nonatomic, strong) RMMapView *mapView;
@property (nonatomic, strong) RMMapboxSource *tileSource;
@property (nonatomic, strong) PSEditingView *editingView;
@property (nonatomic, strong) PSEditingTool *editingTool;
@property (nonatomic, strong) OSMServerParser *parser;

@end

@implementation ViewController

/** MapID from the MapBox server. */
static NSString *kMapID = @"patricks.map-4jjcq070";

/** OpenStreetMap node type. */
static NSString *kAnnotationTypeNode = @"OSMNODE";

/** OpenStreetMap way type. */
static NSString *kAnnotationTypeWay = @"OSMWAY";

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
    _tileSource = [[RMMapboxSource alloc] initWithMapID:kMapID];
    _mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:_tileSource];
    _mapView.showLogoBug = NO;
    _mapView.delegate = self;
    
    // set center coordintes to hagenberg
    CLLocationCoordinate2D homeCoordinate;
    homeCoordinate.latitude =48.36861;
    homeCoordinate.longitude = 14.51277;
    
    [_mapView setCenterCoordinate:homeCoordinate];
    
    enableEditView = NO;
    [self enableEditMode:enableEditView];
}

/** Enable or disable edit mode.
 * @param enable YES if the edit mode should be enabled, else NO.
 */
- (void)enableEditMode:(BOOL)enable
{
    if (enable) {
        // disable interaction with the mapbox view
        [_mapView setUserInteractionEnabled:NO];
        
        // disable tile view from mapbox
        [_mapView setHidden:YES forTileSource:_tileSource];
        
        _editingView = [[PSEditingView alloc] initWithFrame:self.view.bounds];
        _editingView.backgroundColor = [UIColor blueColor];
        
        // size of the editing tool
        _editingTool = [[PSEditingTool alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
        
        // scale of the editing tool
        _editingTool.scale = 2;
        
        // set delegate
        _editingTool.delegate = self;
        
        // connect editingTool with editingView
        _editingView.editingTool = _editingTool;
        
        // add another view to the editing view
        [_editingView addSubview:_mapView];
        
        [self.view addSubview:_editingView];
    } else {
        // enable interaction with the mapbox view
        [_mapView setUserInteractionEnabled:YES];
        
        // enable tile view from mapbox
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

- (IBAction)aboutClicked:(id)sender {
    [self performSegueWithIdentifier:@"showAboutView" sender:self];
}


#pragma MapBox stuff

- (void)addPOIToMap:(CGPoint)point
{
    CLLocationCoordinate2D newCoordinate;
    newCoordinate.latitude = [_mapView pixelToCoordinate:point].latitude;
    newCoordinate.longitude = [_mapView pixelToCoordinate:point].longitude;
    
    RMPointAnnotation *newAnnotation = [[RMPointAnnotation alloc] initWithMapView:_mapView
                                                                    coordinate:newCoordinate
                                                                      andTitle:@"CUSTOMNODE"];
    
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

- (void)addLineButtonClicked
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

    // handle ways
    for (OSMWay *way in ways) {
        NSMutableArray *wayLocations = [[NSMutableArray alloc] init];
        NSMutableArray *shapes = [[NSMutableArray alloc] init];
        for (NSNumber *ref in way.nodes) {
            for (OSMNode *node in nodes) {
                if ([node.identifier doubleValue] == [ref doubleValue]) {
                    [wayLocations addObject:[[CLLocation alloc] initWithLatitude:node.location.latitude longitude:node.location.longitude]];
                    
                    ShapeItem *shapeItem = [[ShapeItem alloc] init];
                    shapeItem.location = node.location;
                    shapeItem.shapeColor = [way getWayColor];
                    shapeItem.fillShape = [way fillShape];
                    
                    [shapes addObject:shapeItem];
                }
            }
        }
        
        RMAnnotation *wayAnnotation = [[RMAnnotation alloc] initWithMapView:_mapView
                                                                 coordinate:((CLLocation *)wayLocations[0]).coordinate
                                                                   andTitle:[way.identifier stringValue]];
        
        //wayAnnotation.userInfo = wayLocations;
        wayAnnotation.userInfo = [NSArray arrayWithArray:shapes];
        wayAnnotation.annotationType = kAnnotationTypeWay;
        [wayAnnotation setBoundingBoxFromLocations:wayLocations];
        [_mapView addAnnotation:wayAnnotation];
        
    }
    
    // handle nodes
    for (OSMNode *node in nodes) {
        for (id key in node.tags) {
            // filter nodes
            if ([key isEqualToString:@"natural"] || [key isEqualToString:@"amenity"]) {
                RMAnnotation *nodeAnnotation = [[RMAnnotation alloc] initWithMapView:_mapView
                                                                          coordinate:node.location
                                                                            andTitle:[node.identifier stringValue]];
                
                nodeAnnotation.annotationType = kAnnotationTypeNode;
                nodeAnnotation.userInfo = node;
                
                [_mapView addAnnotation:nodeAnnotation];
            }
        }
    }
    
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
    
    // handle nodes
    if (annotation.annotationType == kAnnotationTypeNode) {
        OSMNode *node = annotation.userInfo;

        RMMarker *marker = [[RMMarker alloc] initWithUIImage:node.getNodeIcon];
        marker.canShowCallout = YES;
        marker.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        return marker;
        
    // handle ways
    } else if (annotation.annotationType == kAnnotationTypeWay) {
        RMShape *shape = [[RMShape alloc] initWithView:mapView];
        ShapeItem *firstItem = annotation.userInfo[0];
        
        shape.lineColor = firstItem.shapeColor;
        
        if (firstItem.fillShape) {
            shape.fillColor = firstItem.shapeColor;
        }
        
        shape.lineWidth = 3.0;
        
        for (ShapeItem *item in (NSArray *)annotation.userInfo) {
            [shape addLineToCoordinate:item.location];
        }
        
        return shape;
    }
    
    return nil;
}

- (void)tapOnCalloutAccessoryControl:(UIControl *)control forAnnotation:(RMAnnotation *)annotation onMap:(RMMapView *)map
{
    [self performSegueWithIdentifier:@"showDetailsView" sender:annotation];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RMAnnotation *detailsAnnotation = sender;
    
    if ([[segue identifier] isEqualToString:@"showDetailsView"]) {
        DetailsViewController *detailsViewController = segue.destinationViewController;
        detailsViewController.detailsNode = detailsAnnotation.userInfo;
    }
}

@end
