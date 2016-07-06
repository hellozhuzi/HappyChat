//
//  MyReadViewController.h
//  网易新闻测试
//
//  Created by zhufengzhu on 16/2/29.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyReadViewController : UIViewController
@property (nonatomic,copy)NSString *url;
-(void)refreshData;
@end
