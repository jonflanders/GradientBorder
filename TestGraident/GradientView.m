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
        _offset = CGPointMake(0.0, 0.0);
    }
    return self;
}


- (void)drawLineInContext:(CGContextRef)ctx
                     from:(CGPoint)startPoint
                       to:(CGPoint)endPoint
            usingGradient:(CGGradientRef)gradient
{
    CGContextSaveGState(ctx);
	CGContextMoveToPoint(ctx, startPoint.x, startPoint.y);
	
    CGContextAddLineToPoint(ctx, endPoint.x, endPoint.y);
	
    CGContextSetLineWidth(ctx, self.lineWidth);
	
    CGFloat angle = atan2f(endPoint.y - startPoint.y, endPoint.x - startPoint.x);
    CGPoint start = CGPointMake(startPoint.x - sinf(angle) * self.lineWidth / 2.0 + self.offset.x,
                                startPoint.y - cosf(angle) * self.lineWidth / 2.0 + self.offset.y);
    CGPoint end   = CGPointMake(startPoint.x + sinf(angle) * self.lineWidth / 2.0 + self.offset.x,
                                startPoint.y + cosf(angle) * self.lineWidth / 2.0 + self.offset.y);
	
    CGContextReplacePathWithStrokedPath(ctx);
    CGContextClip(ctx);
    CGContextDrawLinearGradient(ctx, gradient, start, end, kCGGradientDrawsAfterEndLocation | kCGGradientDrawsBeforeStartLocation);
	
    CGContextRestoreGState(ctx);
}
- (void)drawTriangle:(CGContextRef)ctx withGradient:(CGGradientRef)gradient
{
	CGContextSaveGState(ctx);
	CGPoint startPoint = CGPointMake(0, 0);
	CGPoint endPoint = CGPointMake(0, self.lineWidth);
	CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, 0, 0);  // top left
    CGContextAddLineToPoint(ctx,self.lineWidth, 0);  // mid right
    CGContextAddLineToPoint(ctx, self.lineWidth	, self.lineWidth);  // bottom left
    CGContextClosePath(ctx);
    CGContextClip(ctx);
	CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
	CGContextRestoreGState(ctx);
	CGContextDrawPath(ctx, kCGPathStroke);
	CGContextSaveGState(ctx);
	startPoint = CGPointMake(0, self.lineWidth);
	endPoint = CGPointMake(self.lineWidth, self.lineWidth);
	CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, 0, 0);  // top left
    CGContextAddLineToPoint(ctx,0,self.lineWidth);  // mid right
    CGContextAddLineToPoint(ctx, self.lineWidth	, self.lineWidth);  // bottom left
    CGContextClosePath(ctx);
    CGContextClip(ctx);
	CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
	CGContextRestoreGState(ctx);
	CGContextDrawPath(ctx, kCGPathStroke);
	
}

- (void)drawTriangle:(CGContextRef)ctx withGradient:(CGGradientRef)gradient withStartPoint:(CGFloat)startX
{
	CGContextSaveGState(ctx);
	CGPoint startPoint = CGPointMake(startX,0);
	CGPoint endPoint = CGPointMake(startX, self.lineWidth);
	CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, startX, 0);  // top left
    CGContextAddLineToPoint(ctx,startX+self.lineWidth, 0);  // mid right
    CGContextAddLineToPoint(ctx, startX, self.lineWidth);  // bottom left
    CGContextClosePath(ctx);
    CGContextClip(ctx);
	CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
	CGContextRestoreGState(ctx);
	CGContextDrawPath(ctx, kCGPathStroke);
	CGContextSaveGState(ctx);
	startPoint = CGPointMake(startX+self.lineWidth,self.lineWidth);
	endPoint = CGPointMake(startX, self.lineWidth);
	CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, startX, self.lineWidth);  // top left
    CGContextAddLineToPoint(ctx,startX+self.lineWidth,0);  // mid right
    CGContextAddLineToPoint(ctx, startX+self.lineWidth, self.lineWidth);  // bottom left
    CGContextClosePath(ctx);
    CGContextClip(ctx);
	CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
	CGContextRestoreGState(ctx);
	CGContextDrawPath(ctx, kCGPathStroke);
}
- (void)drawTriangle:(CGContextRef)ctx withGradient:(CGGradientRef)gradient withY:(CGFloat)y andX:(CGFloat)x
{
	CGContextSaveGState(ctx);
	CGPoint startPoint =  CGPointMake(x, y);
	CGPoint endPoint =CGPointMake(x, y-self.lineWidth);
	CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, x+self.lineWidth, y);  // top left
    CGContextAddLineToPoint(ctx,x, y);  // mid right
    CGContextAddLineToPoint(ctx,x	, y-self.lineWidth);  // bottom left
    CGContextClosePath(ctx);
    CGContextClip(ctx);
	CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
	CGContextRestoreGState(ctx);
	CGContextDrawPath(ctx, kCGPathStroke);
	CGContextSaveGState(ctx);
	 startPoint =CGPointMake(x+self.lineWidth, y-self.lineWidth);
	 endPoint =CGPointMake(x, y-self.lineWidth);
	CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, x, y-self.lineWidth);  // top left
    CGContextAddLineToPoint(ctx,x+self.lineWidth, y);  // mid right
    CGContextAddLineToPoint(ctx,x+self.lineWidth	, y-self.lineWidth);  // bottom left
    CGContextClosePath(ctx);
    CGContextClip(ctx);
	CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
	CGContextRestoreGState(ctx);
	CGContextDrawPath(ctx, kCGPathStroke);
}
- (void)drawTriangle:(CGContextRef)ctx withGradient:(CGGradientRef)gradient withY:(CGFloat)y
{
	CGContextSaveGState(ctx);
	CGPoint startPoint = CGPointMake(self.lineWidth, y);
	CGPoint endPoint = CGPointMake(self.lineWidth, y-self.lineWidth);
	CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, 0, y);  // top left
    CGContextAddLineToPoint(ctx,self.lineWidth, y);  // mid right
    CGContextAddLineToPoint(ctx, self.lineWidth	, y-self.lineWidth);  // bottom left
    CGContextClosePath(ctx);
    CGContextClip(ctx);
	CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
	CGContextRestoreGState(ctx);
	CGContextDrawPath(ctx, kCGPathStroke);
	CGContextSaveGState(ctx);
	 startPoint = CGPointMake(0	, y);
	 endPoint = CGPointMake(self.lineWidth, y);
	CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, self.lineWidth	, y-self.lineWidth);  // top left
    CGContextAddLineToPoint(ctx,0, y-self.lineWidth);  // mid right
    CGContextAddLineToPoint(ctx, 0	, y);  // bottom left
    CGContextClosePath(ctx);
    CGContextClip(ctx);
	CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
	CGContextRestoreGState(ctx);
	CGContextDrawPath(ctx, kCGPathStroke);
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
                       from:CGPointMake(self.lineWidth,
                                        self.lineWidth / 2.0)
                         to:CGPointMake(rect.size.width-self.lineWidth,
                                        self.lineWidth / 2.0)
              usingGradient:gradient];
	[self drawTriangle:context withGradient:gradient];
	// bottom
	[self drawTriangle:context withGradient:gradient withStartPoint:rect.size.width-self.lineWidth];
	
	[self drawTriangle:context withGradient:gradient withY:rect.size.height];
	[self drawTriangle:context withGradient:gradient withY:rect.size.height andX:rect.size.width-self.lineWidth];
    [self drawLineInContext:context
                       from:CGPointMake(self.lineWidth,
                                        rect.size.height - self.lineWidth / 2.0)
                         to:CGPointMake(rect.size.width-self.lineWidth,
                                        rect.size.height - self.lineWidth / 2.0)
              usingGradient:rgradient];

    // left
	
    [self drawLineInContext:context
                       from:CGPointMake(self.lineWidth / 2.0,
                                       self.lineWidth)
                         to:CGPointMake(self.lineWidth / 2.0,
                                        rect.size.height-self.lineWidth)
              usingGradient:gradient];
	 // right
	
    [self drawLineInContext:context
                       from:CGPointMake(rect.size.width - self.lineWidth / 2.0,
                                         self.lineWidth)
                         to:CGPointMake(rect.size.width - self.lineWidth / 2.0,
                                        rect.size.height- self.lineWidth)
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


