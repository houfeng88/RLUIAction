//
//  RLTest.h
//  rlterm3
//
//  Created by houfeng on 12-10-22.
//  Copyright (c) 2012年 houfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NOTIFICATION_TEST_TABLE_LOCK @" NOTIFICATION_TEST_TABLE_LOCK"
#define NOTIFICATION_TEST_TABLE_UNLOCK @" NOTIFICATION_TEST_TABLE_UNLOCK"
@interface RLTest : NSObject
@property(nonatomic,assign)id target;
-(void)sendTestMessage:(NSString *)message;
-(void)addTestView:(UIView *)aView;
-(void)lock;
-(void)unlock;
@end
