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
#import "RLConfig.h"
#import "RLUIAction.h"
#import "RLUIActionInterval.h"
#import "RLUIActionManager.h"
@interface UIImage(RLImage)
+(UIImage *)initFromWithName:(NSString *)name;
@end

@interface UIView(RLViewPublic)
-(void)setSize:(CGSize)size;
-(void)setBackgroundImage:(UIImage*)img;
-(void)setClearBackground;
- (UIImage *)screenshotWithOffset:(CGFloat)deltaY;
- (UIImage *)screenshot;
-(CGPoint)getPosition;
-(void)setPosition:(CGPoint)pos;
-(RLUIAction  *)runAction:(RLUIAction *)action;
@end

enum{
    kRLUIActionViewInvalid=-1,
};
@class RLUICamera;
@class RLUIGridBase;
@class RLArray;
@class RLGLProgram;
@interface RLView:UIView
{
    // rotation angle
    float rotationX_,rotationY_;
    //scaling factors
    float scaleX_,scaleY_;
    float vertexZ_;
    CGPoint position_;
    float skewX_,skewY_;
    CGPoint anchorPointInPoints_;
    CGPoint anchorPoint_;
    CGSize  contentSize_;
    CGAffineTransform transform_,inverse_;
    RLUICamera *camera_;
    RLUIGridBase *grid_;
    NSInteger zOrder_;
    RLArray *children_;
    RLView *parent_;
    NSInteger tag_;
    void *userData_;
    id userObject_;
    RLGLProgram *shaderProgram_;
    //....
    
    RLUIActionManager *actionManager_;
    BOOL isRunning_;
    BOOL isTransformDirty_;
    BOOL isInverseDirty_;
    BOOL visible_;
    BOOL ignoreAnchorPointForPosition_;
    BOOL isReorderChildDirty_;
}
@property(nonatomic,assign)NSInteger zOrder;
@property(nonatomic,readwrite) float vertexZ;
@property(nonatomic,readwrite,assign)float skewX;
@property(nonatomic,readwrite,assign)float skewY;
@property(nonatomic,readwrite,assign)float rotation;
@property(nonatomic,readwrite,assign)float rotationX;
@property(nonatomic,readwrite,assign)float rotationY;
@property(nonatomic,readwrite,assign)float scale;
@property(nonatomic,readwrite,assign)float scaleX;
@property(nonatomic,readwrite,assign)float scaleY;
@property(nonatomic,readwrite,assign)CGPoint position;

-(void)setScaleX:(float)x Y:(float)y;
@end




