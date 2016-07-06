//
//  RecommendReadViewController.h
//  网易新闻测试
//
//  Created by zhufengzhu on 16/2/29.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendReadViewController : UIViewController
@property (nonatomic,copy)NSString *url;
@property (nonatomic,weak)UINavigationController *navDelegate;
@property (nonatomic,weak)UIViewController *vcDelegate;
-(void)refreshData;
@end
