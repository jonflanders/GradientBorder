//
//  GradientView.m
//  TestGraident
//
//  Created by Jon Flanders on 10/25/13.
//The MIT License (MIT)
//
//Copyright (c) 2013 flounderware.
//Permission is hereby granted, free of charge, to any person obtaining a copy of
//this software and associated documentation files (the "Software"), to deal in
//the Software without restriction, including without limitation the rights to
//use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//the Software, and to permit persons to whom the Software is furnished to do so,
//subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#define radians(degrees) (degrees * M_PI/180)


#import "GradientView.h"
#import <QuartzCore/QuartzCore.h>
@interface GradientView()
@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic) CGPoint offset;

@end




@implementation GradientView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _radius = 0.0;
        _lineWidth = 14.0;
        _offset = CGPointMake(0.0, -2.0);
    }
    return self;
}


- (void)drawLineInContext:(CGContextRef)context
                     from:(CGPoint)startPoint
                       to:(CGPoint)endPoint
            usingGradient:(CGGradientRef)gradient
{
    CGContextSaveGState(context);
	CGContextMoveToPoint(context, startPoint.x, startPoint.y);
	
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
	
    CGContextSetLineWidth(context, self.lineWidth);
	
    CGFloat angle = atan2f(endPoint.y - startPoint.y, endPoint.x - startPoint.x);
    CGPoint start = CGPointMake(startPoint.x - sinf(angle) * self.lineWidth / 2.0 + self.offset.x,
                                startPoint.y - cosf(angle) * self.lineWidth / 2.0 + self.offset.y);
    CGPoint end   = CGPointMake(startPoint.x + sinf(angle) * self.lineWidth / 2.0 + self.offset.x,
                                startPoint.y + cosf(angle) * self.lineWidth / 2.0 + self.offset.y);
	
    CGContextReplacePathWithStrokedPath(context);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsAfterEndLocation | kCGGradientDrawsBeforeStartLocation);
	
    CGContextRestoreGState(context);
}

- (void)drawRect:(CGRect)rect
{
    // Create a gradient from black to blue to black
	CGFloat colors[8] = {
		0, 0, 0, .5,
		0.866, 0.866, 0.866,.5
		};
	CGFloat reverse[8]={
		0.866, 0.866, 0.866,.5,
		0, 0, 0, .5
	};
	CGFloat locations[2] = { 0.0, 1.0 };
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, 2);
	CGGradientRef rgradient = CGGradientCreateWithColorComponents(colorSpace, reverse, locations, 2);
    CGColorSpaceRelease(colorSpace);
	
    CGContextRef context = UIGraphicsGetCurrentContext();
	
    CGContextSetAllowsAntialiasing(context, YES);
	
    // top
	
    [self drawLineInContext:context
                       from:CGPointMake(0,
                                        self.lineWidth / 2.0)
                         to:CGPointMake(rect.size.width,
                                        self.lineWidth / 2.0)
              usingGradient:gradient];
	
    // left
	
    [self drawLineInContext:context
                       from:CGPointMake(self.lineWidth / 2.0,
                                        0)
                         to:CGPointMake(self.lineWidth / 2.0,
                                        rect.size.height)
              usingGradient:gradient];
	 // right
	
    [self drawLineInContext:context
                       from:CGPointMake(rect.size.width - self.lineWidth / 2.0,
                                        0)
                         to:CGPointMake(rect.size.width - self.lineWidth / 2.0,
                                        rect.size.height)
              usingGradient:rgradient];
	
  	
    // bottom
	
	
    [self drawLineInContext:context
                       from:CGPointMake(0,
                                        rect.size.height - self.lineWidth / 2.0)
                         to:CGPointMake(rect.size.width,
                                        rect.size.height - self.lineWidth / 2.0)
              usingGradient:rgradient];
	
  
    
}

#pragma mark - setters will redraw

- (void)setRadius:(CGFloat)radius
{
    _radius = radius;
	
    [self setNeedsDisplay];
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
	
    [self setNeedsDisplay];
}

- (void)setOffset:(CGPoint)offset
{
    _offset = offset;
	
    [self setNeedsDisplay];
}

@end


