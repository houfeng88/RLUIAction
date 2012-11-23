//
//  RLUIActionIntervalTest.m
//  RLUIAction
//
//  Created by houfeng on 12-11-23.
//  Copyright (c) 2012年 houfeng. All rights reserved.
//

#import "RLUIActionIntervalTest.h"

@implementation RLUIActionIntervalTest
-(void)testMoveTo
{
    RLView *aView =[[RLView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    aView.backgroundColor=[UIColor redColor];
    RLUIMoveTo *moveTo = [RLUIMoveTo actionWithDuration:4.5 position:CGPointMake(500 , 600)];
    [aView runAction:moveTo];
    [self addTestView:aView];
    [aView release];

    
}
-(void)testMoveBy
{
    RLView *aView =[[RLView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    aView.backgroundColor=[UIColor redColor];
    RLUIMoveBy *moveBy = [RLUIMoveBy actionWithDuration:4.5 position:CGPointMake(0 , 600)];
    [aView runAction:moveBy];
    [self addTestView:aView];
    [aView release];
}
-(void)testJumpTo
{
    RLView *aView =[[RLView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    aView.backgroundColor=[UIColor redColor];
    RLUIJumpTo *jumpTo = [RLUIJumpTo actionWithFuration:5.0f position:rlp(500, 600) height:50 jumps:5];
    [aView runAction:jumpTo];
    [self addTestView:aView];
    [aView release];
}
-(void)testJumpBy
{
    RLView *aView =[[RLView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    aView.backgroundColor=[UIColor redColor];
    RLUIJumpBy *jumpBy = [RLUIJumpBy actionWithFuration:5.0f position:rlp(0,150) height:50 jumps:3];
    [aView runAction:jumpBy];
    [self addTestView:aView];
    [aView release];
}
-(void)testScaleTo
{
    RLView *aView =[[RLView alloc] initWithFrame:CGRectMake(200, 200, 30, 30)];
    aView.backgroundColor=[UIColor redColor];
    RLUIScaleTo *scaleTo = [RLUIScaleTo actionWithDuration:1.0f scale:4.0f];
    [aView runAction:scaleTo];
    [self addTestView:aView];
    [aView release];
    
    
//    RLView *aView1 =[[RLView alloc] initWithFrame:CGRectMake(200, 400, 30, 30)];
//    aView1.backgroundColor=[UIColor redColor];
//    RLUIScaleTo *scaleTo1 = [RLUIScaleTo actionWithDuration:1.0f scaleX:2 scaleY:4];
//    [aView1 runAction:scaleTo1];
//    [self addTestView:aView1];
//    [aView1 release];
}
-(void)testScaleBy
{
    
    RLView *aView =[[RLView alloc] initWithFrame:CGRectMake(200, 200, 30, 30)];
    aView.backgroundColor=[UIColor redColor];
    RLUIScaleBy *scaleBy = [RLUIScaleBy actionWithDuration:1.0f scale:4.0f];
    [aView runAction:scaleBy];
    [self addTestView:aView];
    [aView release];

}
@end
