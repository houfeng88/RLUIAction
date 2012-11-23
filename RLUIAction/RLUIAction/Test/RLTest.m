//
//  RLTest.m
//  rlterm3
//
//  Created by houfeng on 12-10-22.
//  Copyright (c) 2012年 houfeng. All rights reserved.
//

#import "RLTest.h"
#import "RLConfig.h"
#import "RLTestController.h"
@implementation RLTest
-(void)sendTestMessage:(NSString *)message
{
    if([self.target isKindOfClass:[RLTestDetailView class]])
    {
        [(RLTestDetailView*)self.target addStringInfo:message];
    }

}
-(void)addTestView:(UIView *)aView
{
    if([self.target isKindOfClass:[RLTestDetailView class]])
    {
        [self.target addSubview:aView];
    }
}
-(void)lock
{
    [[NSNotificationCenter defaultCenter ] postNotificationName:NOTIFICATION_TEST_TABLE_LOCK object:nil];
}
-(void)unlock
{
    [[NSNotificationCenter defaultCenter ] postNotificationName:NOTIFICATION_TEST_TABLE_UNLOCK object:nil];
}


@end
