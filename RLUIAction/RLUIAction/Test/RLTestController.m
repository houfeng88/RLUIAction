//
//  RLTestController.m
//  rlterm3
//
//  Created by houfeng on 12-10-22.
//  Copyright (c) 2012年 houfeng. All rights reserved.
//

#import "RLTestController.h"
#import "RLConfig.h"
#import "RLTest.h"
#import <QuartzCore/QuartzCore.h>
#define TEST_MENU_WIDTH  250


@interface RLTestDetailView()

@end

@implementation RLTestDetailView

-(void)addStringInfo:(NSString *)str
{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, self.bounds.size.width, self.bounds.size.height-200)];
    [scroll setContentSize:CGSizeMake(self.bounds.size.width*2, self.bounds.size.height)];
    
    [scroll setDelegate:self];
    [scroll showsHorizontalScrollIndicator];
    [scroll showsVerticalScrollIndicator];
    
    
    UITextField *infoTitle  =[[UITextField alloc] initWithFrame:CGRectMake(8, 190, 400, 50)];
    [infoTitle setEnabled:NO];
    [infoTitle setTextColor:[UIColor redColor]];
    [infoTitle setText:@"Detail info"];
    [self addSubview:infoTitle];
    [infoTitle release];
    UITextView  *infoTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 50, 800, 600*2)];
    [infoTextView setBackgroundColor:[UIColor clearColor]];
    [infoTextView setEditable:NO];
    [infoTextView setFont:[UIFont systemFontOfSize:20]];
    [infoTextView setText:str];
    [scroll addSubview:infoTextView];
    [infoTextView release];
    [self addSubview:scroll];
    [scroll release];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

@end
///////////////////////end //RLTestDetailView/////////////////


@interface RLTestItemTableView()
@property(nonatomic,retain)NSArray *items;
@property(nonatomic,retain)UITableView *itemsTable;
@property(nonatomic,copy)NSString *className;
@end

@implementation RLTestItemTableView
-(id)initWithFrame:(CGRect)frame withClassName:(NSString *)atitle withItems:(NSArray *)aitems
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        self.items = aitems;
        self.className = atitle;
        self.itemsTable = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        [self.itemsTable setDataSource:self];
        [self.itemsTable setDelegate:self];
        [self addSubview:self.itemsTable];
        
              
        
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *kCellID = @"cellID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    cell.textLabel.text =  [(NSDictionary *)[self.items objectAtIndex:indexPath.row] objectForKey:@"functitle"];
	return cell;
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if(self.detailview)
    {
        for(UIView *view  in [self.detailview subviews])
        {
            [view removeFromSuperview];
        }
    }
    
    
    
    
    UITextField *title = [[UITextField alloc] initWithFrame:CGRectMake(0, 10, 530, 50)];
    [title setEnabled:NO];
    [title setTextColor:[UIColor redColor]];
    [title setFont:[UIFont systemFontOfSize:20]];
    [title setText:@"Function test"];
    [self.detailview addSubview:title];
    [title release];
    
    NSString *testFunc =  [(NSDictionary *)[self.items objectAtIndex:indexPath.row] objectForKey:@"funcname"];
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 50, 530, 200)];
    [textView setEditable:NO];
    [textView setBackgroundColor:[UIColor clearColor]];
    [textView setFont:[UIFont systemFontOfSize:23]];
    [textView setText:[NSString stringWithFormat:@"test %@ class's  %@ function",self.className,testFunc]];
    [self.detailview addSubview:textView];
    [textView release];
    
//    CATransition *animation = [CATransition animation];
//    
//    animation.delegate=self;
//    animation.duration=0.5f;
//    animation.fillMode=kCAFillModeForwards;
//    animation.type=@"pageCurl";
//    [self.detailview.layer addAnimation:animation forKey:@"animation"];
    id  test =   [[NSClassFromString(self.className) alloc] init];
    if(test && [test respondsToSelector:NSSelectorFromString(testFunc)])
    {
        if([test isKindOfClass:[RLTest class]])
        {
            [(RLTest *)test setTarget:self.detailview];
            
           
        }
        [test performSelector:NSSelectorFromString(testFunc)];
    }

}





@end






//////////RLTestItemTableView///////////////

@interface RLTestController ()
@property(nonatomic,retain)NSArray *testMenus;
@property(nonatomic,retain)UITableView *testMenusTable;
@property(nonatomic,assign)RLTestItemTableView *curItemTableView;
@property(nonatomic,retain)RLTestDetailView *detailview;
@property(atomic)BOOL lock;
@end

@implementation RLTestController
-(id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return  self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, RL_SCREEN_WIDTH, RL_SCREEN_HEIGHT)];
        self.view = aview;
        [aview release];
        self.view.backgroundColor = [UIColor colorWithRed:204/255.0 green:208/255.0 blue:219/255.0 alpha:1.0];;
        // Custom initialization
        self.testMenus = [NSArray arrayWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"RLTestItems.plist"]];
        self.testMenusTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, TEST_MENU_WIDTH, self.view.bounds.size.height) style:UITableViewStyleGrouped];
        [self.testMenusTable setDelegate:self];
        [self.testMenusTable setDataSource:self];
        [self.view addSubview:self.testMenusTable];
        
     
        self.detailview = [[RLTestDetailView alloc] initWithFrame:CGRectMake(500, 0, 530, 768)];
        [self.detailview setBackgroundColor:[UIColor colorWithRed:204/255.0 green:208/255.0 blue:219/255.0 alpha:1.0]];
        [self.view addSubview:self.detailview];

    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden=NO;
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(lockTable) name:NOTIFICATION_TEST_TABLE_LOCK object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unlockTable) name:NOTIFICATION_TEST_TABLE_UNLOCK object:nil];
    [self.testMenusTable setUserInteractionEnabled:YES];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
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


-(void)lockTable
{
    [self.testMenusTable setUserInteractionEnabled:NO];
    self.lock = YES;
}


-(void)unlockTable
{
    [self.testMenusTable setUserInteractionEnabled:YES];

    self.lock = NO;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.testMenus count];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *kCellID = @"cellID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	cell.textLabel.text =[(NSDictionary *)[self.testMenus  objectAtIndex:indexPath.row] objectForKey:@"title"];
	return cell;
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if(self.detailview.isloading)
    {
        return;
    }
    
    {
        if(self.detailview )
        {
            for(UIView *view  in [self.detailview subviews])
            {
                [view removeFromSuperview];
            }

        }
        

        if(self.curItemTableView)
        {
            [self.curItemTableView removeFromSuperview];
            self.curItemTableView=nil;
        }
        NSArray * items = [(NSDictionary *)[self.testMenus objectAtIndex:indexPath.row ] objectForKey:@"testitems"];
        NSString *className = [(NSDictionary *)[self.testMenus objectAtIndex:indexPath.row ] objectForKey:@"classname"];
        RLTestItemTableView *itemTable = [[RLTestItemTableView alloc] initWithFrame:CGRectMake(TEST_MENU_WIDTH/2.0f, self.testMenusTable.frame.origin.y, TEST_MENU_WIDTH, self.view.bounds.size.height) withClassName:className withItems:items];
       
        [self.view addSubview:itemTable];
        self.curItemTableView= itemTable;
//        CATransition *animation = [CATransition animation];
//        animation.delegate=self;
//        animation.duration=0.8f;
//        animation.fillMode=kCAFillModeForwards;
//        animation.type=UIViewAnimationCurveEaseInOut;
//        [self.view.layer addAnimation:animation forKey:@"animation"];
        [self.curItemTableView setDetailview:self.detailview];
        [itemTable release];
        
//        [self.view setNeedsDisplay];

    }
    
}





@end
