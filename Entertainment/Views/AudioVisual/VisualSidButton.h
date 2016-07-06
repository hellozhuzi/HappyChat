//
//  VisualSidButton.h
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/3.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisualSidModel.h"
@interface VisualSidButton : UIButton
@property (nonatomic,strong)VisualSidModel *model;
-(instancetype)initWithIndex:(NSInteger)index;
@end
