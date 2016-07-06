//
//  AudioBigModel.h
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/9.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "JSONModel.h"
#import "AudioSmallModel.h"
@interface AudioBigModel : JSONModel
@property (nonatomic,copy)NSString <Optional>*cname;
@property (nonatomic,copy)NSString <Optional>*cid;
@property (nonatomic,strong)NSArray <AudioSmallModel,Optional>*tList;
@end
