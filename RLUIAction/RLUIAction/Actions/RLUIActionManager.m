//
//  RLUIActionManager.m
//  rlterm3
//
//  Created by houfeng on 12-11-22.
//  Copyright (c) 2012年 houfeng. All rights reserved.
//

#import "RLUIActionManager.h"


@implementation RLUIActionElement
-(id)init{
    self =[super init];
    if(self)
    {
        m_actions=nil;
    }
    return self;
}
-(void)addAction:(RLUIAction *)action
{
    if(m_actions == nil){
        m_actions =[[NSMutableArray alloc] initWithCapacity:5];
    }
    [m_actions addObject:action];
}
-(void)runActions:(rlTime)t
{
    if(m_actions){
        for(RLUIAction * action in m_actions){
            if(![action isDone])
            {
                 [action step:t];
            }
           
        }
    }
    
}
@end


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
        m_targets=[[NSMutableDictionary alloc] initWithCapacity:10];
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
    RLUIActionElement *element =nil;
    
    element = [m_targets objectForKey:NSStringFromClass([target class]) ];
    if(element == nil){
        element = [[RLUIActionElement alloc] init] ;
        [m_targets setObject:element forKey:NSStringFromClass([target class])];
    }
    [element addAction:action];
    [action startWithTarget:target];
    m_timestamp=CACurrentMediaTime();
}
-(void)runActionLoop:(CADisplayLink *)displayLink
{
    if(displayLink){
        float elapsedTime = displayLink.timestamp-m_timestamp;
        for(RLUIActionElement *element  in [m_targets allValues])
        {
            [element runActions:elapsedTime];
        }
        m_timestamp=displayLink.timestamp;
        
    }
    
}
@end
