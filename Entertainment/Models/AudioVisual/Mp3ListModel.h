//
//  Mp3ListModel.h
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/10.
//
//Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "JSONModel.h"

@interface Mp3ListModel : JSONModel
@property (nonatomic,copy)NSString <Optional>*title;
@property (nonatomic,copy)NSString <Optional>*size;
@property (nonatomic,copy)NSString <Optional>*ptime;
@property (nonatomic,copy)NSString <Optional>*docid;
@end
