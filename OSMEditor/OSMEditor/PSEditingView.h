//
//  PSEditingView.h
//  MagnifyingGlassTest
//
//  Created by Patrick Steiner on 21.06.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSEditingTool.h"

@interface PSEditingView : UIView

@property CGPoint currentPosition;
@property (nonatomic, strong) PSEditingTool *editingTool;

@end
