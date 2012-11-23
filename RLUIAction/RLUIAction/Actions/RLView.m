//
//  RLView.m
//  rlterm3
//
//  Created by houfeng on 12-10-31.
//  Copyright (c) 2012年 houfeng. All rights reserved.
//

#import "RLView.h"
#import "RLUIActionManager.h"
#import <QuartzCore/QuartzCore.h>
@implementation UIImage(RLImage)
+(UIImage *)initFromWithName:(NSString *)name
{
    return [UIImage imageNamed:name];
}
@end

@implementation UIView(RLViewPublic)
-(void)setX:(float)x Y:(float)y
{
    [self setFrame:CGRectMake(x, y, self.frame.size.width, self.frame.size.height)];
}
-(void)setSize:(CGSize)size
{
   [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height)];
}
-(void)setBackgroundImage:(UIImage*)img
{
    [self setBackgroundColor:[UIColor colorWithPatternImage:img]];
}
-(void)setClearBackground
{
    [self setBackgroundColor:[UIColor clearColor]];
}
- (UIImage *)screenshot
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return screenshot;
}

- (UIImage *)screenshotWithOffset:(CGFloat)deltaY
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, 0, deltaY);
    [self.layer renderInContext:ctx];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}


-(CGPoint)getPosition
{
    return self.center;
}
-(void)setPosition:(CGPoint)pos
{
    self.center=pos;
}
-(float)getScaleX
{
    return 1;
}
-(float)getScaleY
{
    return 1;
}
-(void)setScaleX:(float)x Y:(float)y
{   
    self.transform =  CGAffineTransformMakeScale(x, y);
}
-(RLUIAction *)runAction:(RLUIAction *)action
{
    [[RLUIActionManager shareManager] addAction:action target:self paused:YES];
    return action;
}
@end

@implementation RLView
@synthesize rotationX=rotationX_,rotationY=rotationY_;
@synthesize scaleX=scaleX_,scaleY=scaleY_;
@synthesize position=position_;

-(id)init{
    self=[super init];
    if (self) {
        
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        scaleX_=1.0f;
        scaleY_=1.0f;
    }
    return self;
}
-(void)setPosition:(CGPoint)position
{
    position_=position;
    self.center=position;
}
-(void)setScaleX:(float)scaleX
{
    scaleX_=scaleX;
    self.transform =CGAffineTransformMakeScale(scaleX_, scaleY_);
}
-(void)setScaleY:(float)scaleY
{
    scaleY_=scaleY;
    self.transform = CGAffineTransformMakeScale(scaleX_, scaleY_);
}
-(void)setScaleX:(float)x Y:(float)y
{
    scaleX_=x;
    scaleY_=y;
    self.transform =  CGAffineTransformMakeScale(x, y);
}
@end















