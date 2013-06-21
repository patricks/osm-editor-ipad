//
//  PSOSMEditingTool.m
//  MagnifyingGlassTest
//
//  Created by Patrick Steiner on 21.06.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import "PSOSMEditingTool.h"
#import <QuartzCore/QuartzCore.h>

static CGFloat const kDefaultRadius = 64;

@implementation PSOSMEditingTool

- (id)init
{
    self = [super init];
    if (self) {
        self = [self initWithFrame:CGRectMake(0, 0, kDefaultRadius * 2, kDefaultRadius * 2)];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 0;
        
        UIImageView *loupeImageView = [[UIImageView alloc] initWithFrame:CGRectOffset(CGRectInset(self.bounds, -5.0, -5.0), 0, 2)];
        loupeImageView.image = [UIImage imageNamed:@"kb-loupe-hi"];
        loupeImageView.backgroundColor = [UIColor clearColor];
		[self addSubview:loupeImageView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
