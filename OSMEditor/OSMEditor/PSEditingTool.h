//
//  PSEditingTool.h
//  MagnifyingGlassTest
//
//  Created by Patrick Steiner on 21.06.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PSEditingToolDelegate;

@interface PSEditingTool : UIView

@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) BOOL scaleAtTouchPoint;
@property (nonatomic, strong) UIView *viewToEdit;
@property (nonatomic, assign) CGPoint touchPoint;

@property (nonatomic, strong) id <PSEditingToolDelegate> delegate;

@end

@protocol PSEditingToolDelegate
- (void)addPOIButtonClicked;
@end
