//
//  RLUIActionManager.h
//  rlterm3
//
//  Created by houfeng on 12-11-22.
//  Copyright (c) 2012年 houfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/CADisplayLink.h>
#import "RLUIAction.h"
#import "RLArray.h"


typedef struct _hashElement
{
    struct rlArray *actions;
}tHashElement;

@interface RLUIActionManager : NSObject
{
    CADisplayLink *m_displayLink;
    rlTime m_timestamp;
}
+(RLUIActionManager *)shareManager;
-(void)addAction:(RLUIAction *)action target:(id)target paused:(BOOL)paused;
-(void)setFPS:(float)fps;
@end
