//
//  PSEditingTool.h
//  MagnifyingGlassTest
//
//  Created by Patrick Steiner on 21.06.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PSEditingToolDelegate;

/** This editing tool is designed for high precision input of cad/gis data. */
@interface PSEditingTool : UIView

/** Scale of the editing tool */
@property (nonatomic, assign) CGFloat scale;

/** Define if it should be scaled at the touched point. */
@property (nonatomic, assign) BOOL scaleAtTouchPoint;

/** View to edit. */
@property (nonatomic, strong) UIView *viewToEdit;

/** Current touched point (display position) */
@property (nonatomic, assign) CGPoint touchPoint;


/** Delegate property */
@property (nonatomic, strong) id <PSEditingToolDelegate> delegate;

@end

/** This delegate informs the receiver about the tool changes like button clicks. */
@protocol PSEditingToolDelegate

/** If the POI button is clicked this method informs the receiver. */
- (void)addPOIButtonClicked;

/** If the line button is clicked this method informs the receiver. */
- (void)addLineButtonClicked;

@end
