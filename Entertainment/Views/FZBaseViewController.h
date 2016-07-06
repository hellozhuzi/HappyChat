//
//  BaseViewController.h
//  网易新闻测试
//
//  Created by zhufengzhu on 16/2/22.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FZBaseViewController : UIViewController
@property(nonatomic,strong)NSMutableArray *vcArray;


-(void)creatMuduleSegmentWithArray:(NSArray *)modelsArray;
@end
