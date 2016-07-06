//
//  AudioSmallModel.h
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/9.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "JSONModel.h"
#import "RadioModel.h"
@protocol AudioSmallModel

@end

@interface AudioSmallModel : JSONModel
@property (nonatomic,copy)NSString <Optional> *tname;
@property (nonatomic,copy)NSString <Optional> *tid;
@property (nonatomic,strong) RadioModel *radio;
@end

