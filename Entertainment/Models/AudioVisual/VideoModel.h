//
//  videoModel.h
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/3.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "JSONModel.h"

@interface VideoModel : JSONModel
@property (nonatomic,copy)NSString <Optional>*title;
@property (nonatomic,copy)NSString <Optional>*des;
@property (nonatomic,copy)NSString <Optional>*cover;
@property (nonatomic,assign)NSInteger length;//时间长度
@property (nonatomic,assign)NSInteger playCount;//播放次数
@property (nonatomic,assign)NSInteger replyCount;//回复次数

@property (nonatomic,copy)NSString *m3u8_url;
@property (nonatomic,copy)NSString *mp4_url;


@end
