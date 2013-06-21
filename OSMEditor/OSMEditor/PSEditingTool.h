//
//  PSEditingTool.h
//  MagnifyingGlassTest
//
//  Created by Patrick Steiner on 21.06.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSEditingTool : UIView

@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) BOOL scaleAtTouchPoint;
@property (nonatomic, retain) UIView *viewToEdit;
@property (nonatomic, assign) CGPoint touchPoint;

@end
