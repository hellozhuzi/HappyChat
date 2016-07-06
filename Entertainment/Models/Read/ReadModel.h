//
//  ReadModel.h
//  网易新闻测试
//
//  Created by zhufengzhu on 16/2/29.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "JSONModel.h"

@interface ReadModel : JSONModel
@property (nonatomic,copy)NSString <Optional>*boardid;
@property (nonatomic,copy)NSString <Optional>*replyid;
@property (nonatomic,copy)NSString <Optional>*digest;
@property (nonatomic,copy)NSString <Optional>*title;
@property (nonatomic,copy)NSString <Optional>*source;
@property (nonatomic,copy)NSString <Optional>*template;//模板
@property (nonatomic,copy)NSString <Optional>*img;
@property (nonatomic,copy)NSArray <Optional>*imgnewextra;
-(float)cellHeight;
@end
