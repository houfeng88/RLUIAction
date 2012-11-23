//
//  RLUIActionInterval.m
//  rlterm3
//
//  Created by houfeng on 12-11-22.
//  Copyright (c) 2012年 houfeng. All rights reserved.
//

#import "RLUIActionInterval.h"
#import "RLView.h"
@implementation RLUIActionInterval
@synthesize elapsed=elapsed_;
+(id)actionWithDuration:(rlTime)d
{
    return [[[self alloc] initWithDuration:d] autorelease];
}
-(id)initWithDuration:(rlTime)d
{
    if(self=[super init]){
        duration_=d;
        if(duration_ == 0)
            duration_ =FLT_EPSILON;
        elapsed_ =0;
        firstTick_=YES;
    }
    return self;
}
-(id)copyWithZone:(NSZone *)zone
{
    RLUIAction *copy = [[[self class] allocWithZone:zone] initWithDuration:[self duration]];
    return copy;
}
-(BOOL)isDone
{
    return (elapsed_ >= duration_);
}
-(void)step:(rlTime)dt
{
    if(firstTick_){
        firstTick_=NO;
        elapsed_=0;
    }else
        elapsed_+=dt;
    
    [self update:MAX(0, MIN(1, elapsed_/MAX(duration_, FLT_EPSILON)))];
}

-(void)startWithTarget:(id)target
{
    [super startWithTarget:target];
    elapsed_=0.0f;
    firstTick_=YES;
}
-(RLUIActionInterval*)reverse
{
    return nil;
}

@end

@implementation RLUIMoveTo
+(id)actionWithDuration:(rlTime)d position:(CGPoint)position
{
    return [[[self alloc] initWithDuration:d position:position] autorelease];
}
-(id)initWithDuration:(rlTime)d position:(CGPoint)position
{
    if(self=[super initWithDuration:d])
        endPosition_=position;
    return self;
}
-(id)copyWithZone:(NSZone *)zone
{
    RLUIAction *copy = [[[self class] allocWithZone:zone] initWithDuration:[self duration] position:endPosition_];
    return copy;
}
-(void)startWithTarget:(UIView *)target{
    [super startWithTarget:target];
    startPosition_ = [target getPosition];
    delta_ =rlpSub(endPosition_, startPosition_);
    target.center=startPosition_;
    
//    [UIView  beginAnimations:@"test" context:nil];
//    [UIView setAnimationDuration:duration_];
//    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//    target.center=rlpAdd(startPosition_,delta_);
//    [UIView commitAnimations];
    
}
-(void)update:(rlTime)time
{
    [target_ setPosition:rlp(startPosition_.x+delta_.x*time, startPosition_.y+delta_.y*time) ];
}
@end

@implementation RLUIMoveBy
+(id)actionWithDuration:(rlTime)d position:(CGPoint)position
{
    return [[[self alloc] initWithDuration:d position:position] autorelease];
}
-(id)initWithDuration:(rlTime)d position:(CGPoint)position
{
    if(self=[super initWithDuration:d])
         delta_=position;
    return self;
}
-(id)copyWithZone:(NSZone *)zone
{
    RLUIAction *copy = [[[self class] allocWithZone:zone] initWithDuration:[self duration] position:endPosition_];
    return copy;
}
-(void)startWithTarget:(id)target
{
    startPosition_=[target getPosition];
    endPosition_=rlpAdd(startPosition_, delta_);
    [super startWithTarget:target];
    
}
@end



@implementation RLUIJumpBy

+(id)actionWithFuration:(rlTime)duration position:(CGPoint)position height:(rlTime)height jumps:(NSUInteger)jumps
{
    return [[[self alloc] initWithDuration:duration position:position height:height jumps:jumps] autorelease];
}
-(id)initWithDuration:(rlTime)duration position:(CGPoint)position height:(rlTime)height jumps:(NSUInteger)jumps
{
    if(self =[super initWithDuration:duration]){
        delta_=position;
        height_ =height;
        jumps_=jumps;
    }
    return self;
}
-(id)copyWithZone:(NSZone *)zone
{
    RLUIAction *copy = [[[self class] allocWithZone:zone] initWithDuration:[self duration] position:delta_ height:height_ jumps:jumps_];
    return  copy;
}

-(void)startWithTarget:(id)target{
    [super startWithTarget:target];
    startPosition_=[(UIView*)target_ getPosition];
    
}
-(void)update:(rlTime)time
{
    
//    rlTime y = height_ * fabsf( sinf(time * (CGFloat)M_PI * jumps_ ) );
//    y += delta_.y * time;
//    rlTime x = delta_.x * time;
//    [target setPosition: ccp( startPosition.x + x, startPosition.y + y )];
    
    rlTime frac = fmodf( time* jumps_, 1.0f);
    rlTime y = height_ *4 *frac*(1-frac);
    y+=delta_.y*time;
    rlTime x = delta_.x*time;
    [target_ setPosition:rlp(startPosition_.x+x, startPosition_.y+y)];
    
}
@end

@implementation RLUIJumpTo

-(void)startWithTarget:(UIView *)target
{
    [super startWithTarget:target];
    delta_ = rlp(delta_.x-startPosition_.x, delta_.y-startPosition_.y);
}
@end


@implementation RLUIScaleTo

+(id)actionWithDuration:(rlTime)duration scale:(float)s
{
    return [[[self alloc] initWithDuration:duration scale:s] autorelease];
}

-(id)initWithDuration:(rlTime)duration scale:(float)s
{
    if(self =[super initWithDuration:duration]){
        endScaleX_=s;
        endScaleY_=s;
    }
    
    return self;
}
+(id) actionWithDuration: (rlTime)duration scaleX:(float) sx scaleY:(float)sy
{
    return [[[self alloc] initWithDuration:duration scaleX:sx scaleY:sy] autorelease];
}
-(id) initWithDuration: (rlTime)duration scaleX:(float) sx scaleY:(float)sy
{
    if(self = [super initWithDuration:duration]){
        endScaleX_ = sx;
        endScaleY_ = sy;
    }
    return self;
}
-(id)copyWithZone:(NSZone *)zone
{
    RLUIAction *copy =[[[self class] allocWithZone:zone] initWithDuration:[self duration] scaleX:endScaleX_ scaleY:endScaleY_ ];
    return copy;
}

-(void)startWithTarget:(RLView*)target{
    [super startWithTarget:target];
    startScaleX_ = [target_ scaleX];
    startScaleY_ = [target_ scaleY];
    deltaX_ = endScaleX_ - startScaleX_;
    deltaY_ = endScaleY_ - startScaleY_;
}
-(void)update:(rlTime)time
{
    [target_ setScaleX:(startScaleX_ +deltaX_ * time) Y:startScaleY_ +deltaY_ *time];
    //[target_ setScaleX:startScaleX_+deltaX_*time];
    //[target_ setScaleY:startScaleY_+deltaY_*time];
}
@end

@implementation RLUIScaleBy
-(void)startWithTarget:(RLView *)target
{
    [super startWithTarget:target];
    deltaX_ = startScaleX_ * endScaleX_-startScaleX_;
    deltaY_ = startScaleY_ * endScaleY_-startScaleY_;
}
-(RLUIActionInterval *)reverse
{
    return  [[self class] actionWithDuration:duration_ scaleX:1/endScaleX_ scaleY:1/endScaleY_];
}
@end











