//
//  PSEditingTool.m
//  MagnifyingGlassTest
//
//  Created by Patrick Steiner on 21.06.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import "PSEditingTool.h"
#import <QuartzCore/QuartzCore.h>

static CGFloat const kDefaultScale = 1.5;

@implementation PSEditingTool

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupTool:frame];
    }
    return self;
}

- (void)setupTool:(CGRect)frame
{
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.layer.borderWidth = 3;
    //self.layer.cornerRadius = frame.size.width / 2;
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    _scale = kDefaultScale;
    _scaleAtTouchPoint = YES;
    _viewToEdit = nil;
    
    // first button
    UIButton *poiButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    poiButton.frame = CGRectMake(0, frame.size.height - 44, 44, 44);
    [poiButton setTitle:@"POI" forState:UIControlStateNormal];
    [poiButton addTarget:self action:@selector(poiButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:poiButton];
    
    // second button
    UIButton *lineButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    lineButton.frame = CGRectMake(frame.size.width - 44, frame.size.height - 44, 44, 44);
    [lineButton setTitle:@"Line" forState:UIControlStateNormal];
    [lineButton addTarget:self action:@selector(lineButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lineButton];
    
    // crosshair
    UIImage *crossHairImage = [UIImage imageNamed:@"crosshair"];
    
    UIImageView *crossHairImageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width / 2) - crossHairImage.size.width / 2, ((frame.size.height / 2) - crossHairImage.size.height / 2) - 44, 20, 20)];
    crossHairImageView.image = [UIImage imageNamed:@"crosshair"];
    crossHairImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:crossHairImageView];
}

- (void)setFrame:(CGRect)frame
{
	super.frame = frame;
	self.layer.cornerRadius = frame.size.width / 2;
}

- (void)setTouchPoint:(CGPoint)point
{
	_touchPoint = point;
    
    CGPoint viewPosition = _viewToEdit.frame.origin;
    CGPoint center = CGPointMake(point.x + viewPosition.x, point.y + viewPosition.y);
	self.center = center;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, self.frame.size.width / 2, self.frame.size.height / 2);
    // upscale
    CGContextScaleCTM(context, _scale, _scale);
    CGContextTranslateCTM(context, -_touchPoint.x, -_touchPoint.y + (_scaleAtTouchPoint? 0 : self.bounds.size.height / 2));
    
    [_viewToEdit.layer renderInContext:context];
}

#pragma - touch events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_viewToEdit touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_viewToEdit touchesBegan:touches withEvent:event];
}

#pragma - button methods

- (void)poiButtonClicked
{
    NSLog(@"DBG: POI Button clicked.");
    [_delegate addPOIButtonClicked];
}

- (void)lineButtonClicked
{
    NSLog(@"DBG: Line Button clicked.");
}


@end
