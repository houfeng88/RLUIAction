//
//  RLUIActionInterval.h
//  rlterm3
//
//  Created by houfeng on 12-11-22.
//  Copyright (c) 2012年 houfeng. All rights reserved.
//
#import "RLView.h"
#import "RLUIAction.h"

@interface RLUIActionInterval : RLUIFiniteTimeAction
{
    rlTime elapsed_;
    BOOL firstTick_;
}
@property(nonatomic,readonly) rlTime elapsed;
+(id)actionWithDuration:(rlTime)d;
-(id)initWithDuration:(rlTime)d;
-(BOOL)isDone;
-(RLUIActionInterval*)reverse;
@end

@interface RLUIMoveTo:RLUIActionInterval
{
    CGPoint endPosition_;
    CGPoint startPosition_;
    CGPoint delta_;
}
+(id)actionWithDuration:(rlTime)d position:(CGPoint)position;
-(id)initWithDuration:(rlTime)d position:(CGPoint)position;
@end

@interface RLUIMoveBy:RLUIMoveTo<NSCopying>
+(id)actionWithDuration:(rlTime)d position:(CGPoint)position;
-(id)initWithDuration:(rlTime)d position:(CGPoint)position;
@end

@interface RLUIJumpBy:RLUIActionInterval<NSCopying>
{
    CGPoint startPosition_;
    CGPoint delta_;
    rlTime height_;
    NSUInteger jumps_;
}
+(id)actionWithFuration:(rlTime)duration position:(CGPoint)position height:(rlTime)height jumps:(NSUInteger)jumps;
-(id)initWithDuration:(rlTime)duration position:(CGPoint)position height:(rlTime)height jumps:(NSUInteger)jumps;
@end


@interface RLUIJumpTo :RLUIJumpBy<NSCopying>
{
    
}
-(void)startWithTarget:(UIView *)target;
@end

@interface RLUIScaleTo:RLUIActionInterval<NSCopying>
{
    float scaleX_;
    float scaleY_;
    float startScaleX_;
    float endScaleX_;
    float startScaleY_;
    float endScaleY_;
    float deltaX_;
    float deltaY_;
}
+(id)actionWithDuration:(rlTime)duration scale:(float)s;
-(id)initWithDuration:(rlTime)duration scale:(float)s;
+(id) actionWithDuration: (rlTime)duration scaleX:(float) sx scaleY:(float)sy;
-(id) initWithDuration: (rlTime)duration scaleX:(float) sx scaleY:(float)sy;
@end

@interface RLUIScaleBy:RLUIScaleTo<NSCopying>
-(void)startWithTarget:(UIView *)target;
@end



