//
//  videoModel.m
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/3.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"description":@"des"}];
}
@end
