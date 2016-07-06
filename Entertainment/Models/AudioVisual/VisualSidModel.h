//
//  VisualSidModel.h
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/3.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "JSONModel.h"

@interface VisualSidModel : JSONModel
@property (nonatomic,copy)NSString <Optional>*imgsrc;
@property (nonatomic,copy)NSString <Optional>*sid;
@property (nonatomic,copy)NSString <Optional>*title;
@end
