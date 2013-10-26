//
//  ViewController.m
//  TestGraident
//
//  Created by Jon Flanders on 10/25/13.
//  Copyright (c) 2013 flounderware. All rights reserved.
//

#import "ViewController.h"
#import "GradientView.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *posView;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	CGFloat margin = 0.0;
    CGRect frame = self.posView.bounds;
	
    GradientView *boxWithGradientView = [[GradientView alloc] initWithFrame:frame];
    boxWithGradientView.backgroundColor = [UIColor clearColor];
    [self.posView addSubview:boxWithGradientView];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIImage *)radialGradientImage:(CGSize)size start:(UIColor*)start end:(UIColor*)end centre:(CGPoint)centre radius:(float)radius {
	// Render a radial background
	// http://developer.apple.com/library/ios/#documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_shadings/dq_shadings.html
	
	// Initialise
	UIGraphicsBeginImageContextWithOptions(size, 0, 1);
	
	// Create the gradient's colours
	size_t num_locations = 2;
	CGFloat locations[2] = { 0.0, 1.0 };
	CGFloat components[8] = { 0,0,0,0,  // Start color
		0,0,0,0 }; // End color
	[start getRed:&components[0] green:&components[1] blue:&components[2] alpha:&components[3]];
	[end getRed:&components[4] green:&components[5] blue:&components[6] alpha:&components[7]];
	
	CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef myGradient = CGGradientCreateWithColorComponents (myColorspace, components, locations, num_locations);
	
	// Normalise the 0-1 ranged inputs to the width of the image
	CGPoint myCentrePoint = CGPointMake(centre.x * size.width, centre.y * size.height);
	float myRadius = MIN(size.width, size.height) * radius;
	
	// Draw it!
	CGContextDrawRadialGradient (UIGraphicsGetCurrentContext(), myGradient, myCentrePoint,
								 0, myCentrePoint, myRadius,
								 kCGGradientDrawsAfterEndLocation);
	
	// Grab it as an autoreleased image
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	
	// Clean up
	CGColorSpaceRelease(myColorspace); // Necessary?
	CGGradientRelease(myGradient); // Necessary?
	UIGraphicsEndImageContext(); // Clean up
	return image;
}

@end
