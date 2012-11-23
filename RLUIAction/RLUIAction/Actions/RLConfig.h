//
//  RLConfig.h
//  RLUIAction
//
//  Created by houfeng on 12-11-23.
//  Copyright (c) 2012年 houfeng. All rights reserved.
//

#ifndef RLUIAction_RLConfig_h
#define RLUIAction_RLConfig_h
typedef float rlTime;
static inline CGPoint rlp(CGFloat x, CGFloat y)
{
    return CGPointMake(x, y);
}
static inline CGPoint rlpSub(const CGPoint v1,CGPoint v2)
{
    return rlp(v1.x-v2.x, v1.y-v2.y);
}
static inline CGPoint rlpAdd(const CGPoint v1,CGPoint v2)
{
    return rlp(v1.x+v2.x, v1.y+v2.y);
}


#endif
