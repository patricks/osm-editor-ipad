//
//  PSEditingView.m
//  MagnifyingGlassTest
//
//  Created by Patrick Steiner on 21.06.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import "PSEditingView.h"

@implementation PSEditingView

- (void)addEditingTool:(CGPoint)point
{
    if (!_editingTool) {
        _editingTool = [[PSEditingTool alloc] init];
    }
    
    if (!_editingTool.viewToEdit) {
        _editingTool.viewToEdit = self;
    }
    
    _editingTool.touchPoint = point;
    [self.superview addSubview:_editingTool];
    [_editingTool setNeedsDisplay];
}

- (void)updateEditingTool:(CGPoint)point
{
    _editingTool.touchPoint = point;
    [_editingTool setNeedsDisplay];
}

- (void)removeEditingTool
{
    [_editingTool removeFromSuperview];
}

#pragma - touch events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    [self addEditingTool:[touch locationInView:self]];
    _currentPosition = [touch locationInView:self];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    [self updateEditingTool:[touch locationInView:self]];
    _currentPosition = [touch locationInView:self];
}

@end
