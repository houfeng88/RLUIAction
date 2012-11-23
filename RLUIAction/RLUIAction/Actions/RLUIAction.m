//
//  RLUIAction.m
//  rlterm3
//
//  Created by houfeng on 12-11-22.
//  Copyright (c) 2012年 houfeng. All rights reserved.
//

#import "RLUIAction.h"

//1//
@implementation RLUIAction
@synthesize tag=tag_,target = target_,originalTarget=originalTarget_;
+(id)action
{
    return [[[self alloc] init] autorelease];
}
-(id)init
{
    self =[super init];
    if(self){
        originalTarget_=target_=nil;
        tag_ = kRLActionTagInvalid;
    }
    return self;
}
-(void)dealloc{
    [super dealloc];
}
-(NSString*) description{
   return [NSString stringWithFormat:@"<%@ = %p | Tag = %ld>", [self class], self, (long)tag_];
}
-(id)copyWithZone:(NSZone *)zone{
    RLUIAction *copy = [[[self class] allocWithZone:zone] init];
    copy.tag=tag_;
    return copy;
}
-(BOOL)isDone
{
    return YES;
}
-(void)startWithTarget:(id)aTarget
{
    originalTarget_=target_=aTarget;
}
-(void)stop
{
    target_=nil;
}
-(void)step:(rlTime)dt
{
    
}
-(void)update:(rlTime)time
{
    
}

@end
///2///
@implementation RLUIFiniteTimeAction
-(RLUIFiniteTimeAction*)reverse
{
    return  nil;
}
@end
