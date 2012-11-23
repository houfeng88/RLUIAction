//
//  RLView.h
//  rlterm3
//
//  Created by houfeng on 12-10-31.
//  Copyright (c) 2012年 houfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CADisplayLink.h>
#import "RLUIAction.h"
#import "RLUIActionInterval.h"
#import "RLUIActionManager.h"
@interface UIImage(RLImage)
+(UIImage *)initFromWithName:(NSString *)name;
@end

@interface UIView(RLView)
-(void)setX:(float)x Y:(float)y;
-(void)setSize:(CGSize)size;
-(void)setBackgroundImage:(UIImage*)img;
-(void)setClearBackground;
- (UIImage *)screenshotWithOffset:(CGFloat)deltaY;
- (UIImage *)screenshot;
-(CGPoint)getPosition;
-(void)setPosition:(CGPoint)pos;
-(float)getScaleX;
-(float)getScaleY;
-(void)setScaleX:(float)x Y:(float)y;
-(RLUIAction  *)runAction:(RLUIAction *)action;
@end

@interface RLActionView:UIView
@end




