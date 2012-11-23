//
//  RLUIAction.h
//  rlterm3
//
//  Created by houfeng on 12-11-22.
//  Copyright (c) 2012年 houfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RLConfig.h"
enum{
    kRLActionTagInvalid=-1,
};
/*1*/
@interface RLUIAction : NSObject<NSCopying>
{
    id originalTarget_;
    id target_;
    NSInteger tag_;
}
@property(nonatomic,readonly,assign)id originalTarget;
@property(nonatomic,readonly,assign)id target;
@property(nonatomic,readwrite,assign)NSInteger tag;
+(id)action;
-(id)init;
-(id)copyWithZone:(NSZone *)zone;
-(BOOL)isDone;
-(void)startWithTarget:(id)target;
-(void)stop;
-(void)step:(rlTime)dt;
-(void)update:(rlTime)time;

@end
/*2*/
@interface RLUIFiniteTimeAction:RLUIAction<NSCopying>
{
    rlTime  duration_;
}
@property(nonatomic,readwrite)rlTime duration;
-(RLUIFiniteTimeAction*)reverse;
@end

@interface RLUIFollowAction:RLUIAction
@end

@interface RLUISpeedAction:RLUIAction
@end




