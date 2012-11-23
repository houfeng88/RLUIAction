//
//  RLUIActionManager.m
//  rlterm3
//
//  Created by houfeng on 12-11-22.
//  Copyright (c) 2012年 houfeng. All rights reserved.
//

#import "RLUIActionManager.h"




@interface RLUIActionManager()
@property(nonatomic,retain)RLUIAction *m_curAction;
@end

@implementation RLUIActionManager
+(RLUIActionManager *)shareManager
{
    static RLUIActionManager *m_manager;
    @synchronized(self){
        if(m_manager==nil){
            m_manager =[[RLUIActionManager alloc] init];
        }
    }
    return m_manager;
}

-(id)init{
    self=[super init];
    if(self){
        m_displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(runActionLoop:)];
        [m_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        m_displayLink.frameInterval=1;
        m_timestamp=CACurrentMediaTime();
    }
    return  self;
}
-(void)setFPS:(float)fps
{
    if(m_displayLink)
    {
        m_displayLink.frameInterval=60*fps;
    }
}
-(void)addAction:(RLUIAction *)action target:(id)target paused:(BOOL)paused;
{
    if(self.m_curAction)
    {
        self.m_curAction=nil;
    }
    [action startWithTarget:target];
    self.m_curAction=action;
    m_timestamp=CACurrentMediaTime();
}
-(void)runActionLoop:(CADisplayLink *)displayLink
{
    if(displayLink){
        float elapsedTime = displayLink.timestamp-m_timestamp;
        if(self.m_curAction && ![self.m_curAction isDone])
        {
            [self.m_curAction step:elapsedTime];
        }
        m_timestamp=displayLink.timestamp;
        
    }
    
}
@end
