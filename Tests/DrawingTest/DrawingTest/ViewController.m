//
//  ViewController.m
//  DrawingTest
//
//  Created by Patrick Steiner on 09.04.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    NSLog(@"Controller: Screen touched x: %f y: %f", currentPoint.x, currentPoint.y);
    
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.mainImageView.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    UIImage *touchImage = [[UIImage alloc] initWithContentsOfFile:@"tradi.png"];
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(currentPoint.x, currentPoint.y, 20, 20), touchImage.CGImage);
    
    UIGraphicsEndImageContext();
}

@end
