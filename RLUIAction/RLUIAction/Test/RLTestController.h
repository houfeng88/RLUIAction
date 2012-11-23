//
//  RLTestController.h
//  rlterm3
//
//  Created by houfeng on 12-10-22.
//  Copyright (c) 2012年 houfeng. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RLTestItemDelegate<NSObject>
@optional

@end

@interface RLTestDetailView:UIView<UIScrollViewDelegate>
-(void)addStringInfo:(NSString *)str;
@property(atomic)BOOL isloading;
@end

@interface RLTestItemTableView:UIView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign)RLTestDetailView *detailview;
@property(nonatomic,assign)id<RLTestItemDelegate> delegate;
-(id)initWithFrame:(CGRect)frame withClassName:(NSString *)atitle withItems:(NSArray *)aitems;
@end




@interface RLTestController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@end
