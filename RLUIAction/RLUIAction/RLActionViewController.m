//
//  RLActionViewController.m
//  RLUIAction
//
//  Created by houfeng on 12-11-23.
//  Copyright (c) 2012年 houfeng. All rights reserved.
//

#import "RLActionViewController.h"

@interface RLActionViewController ()
{
    UIView *m_testView;
}
@end

@implementation RLActionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *aView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view=aView;
    [aView release];
    
    UIView *testView =[[UIView alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    testView.backgroundColor=[UIColor redColor];
    [self.view addSubview:testView];
     m_testView=testView;
    [testView release];
    
    
    
    UIButton *test =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    test.frame=CGRectMake(20, 30, 100, 50);
    [test addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:test];
    
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(10, 10, 40, 40);
    [btn addTarget:self action:@selector(testBtn) forControlEvents:UIControlEventTouchUpInside];
    [m_testView addSubview:btn];
   
    
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape( interfaceOrientation );
}

// For ios6, use supportedInterfaceOrientations & shouldAutorotate instead
- (NSUInteger) supportedInterfaceOrientations{
#ifdef __IPHONE_6_0
    return UIInterfaceOrientationMaskLandscape;
#endif
}

- (BOOL) shouldAutorotate {
    return YES;
}


-(void)test{
    
    if(m_testView)
    {
        RLUIMoveTo *moveTo = [RLUIMoveTo actionWithDuration:4.5 position:CGPointMake(self.view.center.x, 200)];
        RLUIMoveBy *moveBy = [RLUIMoveBy actionWithDuration:3.5 position:CGPointMake(0, 100)];
        RLUIJumpBy *jumpBy = [RLUIJumpBy actionWithFuration:4.0 position:rlp(0, 350) height:100 jumps:3];
        RLUIJumpTo *jumpTo = [RLUIJumpTo actionWithFuration:14.0 position:rlp(1000, 400) height:100 jumps:8];
        
        RLUIScaleTo *scaleTo =[RLUIScaleTo actionWithDuration:1.0 scale:0.5f];
        [m_testView runAction:scaleTo];
    }
    
}

-(void)testBtn
{
    NSLog(@"I can touch");
}

@end
