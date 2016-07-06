//
//  Mp3Player.h
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/11.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mp3PlayerTool : NSObject
+(id)sharedMp3PlayerTool;
-(void)startToPlayMusic:(NSString *)urlStr;
-(void)continueToPlay;
-(void)pause;
@end
