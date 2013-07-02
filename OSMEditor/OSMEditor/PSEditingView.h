//
//  PSEditingView.h
//  MagnifyingGlassTest
//
//  Created by Patrick Steiner on 21.06.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSEditingTool.h"

/** The related view for the PSEditingTool. */
@interface PSEditingView : UIView

/** Current position of the view. */
@property CGPoint currentPosition;

/** The connected PSEditingTool. */
@property (nonatomic, strong) PSEditingTool *editingTool;

@end
