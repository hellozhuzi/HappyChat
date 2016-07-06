//
//  RadioModel.h
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/9.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "JSONModel.h"

@interface RadioModel : JSONModel
@property (nonatomic,copy)NSString *tname;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *imgsrc;


@end
