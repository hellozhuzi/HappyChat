//
//  Mp3Player.m
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/11.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "Mp3PlayerTool.h"

@implementation Mp3PlayerTool
{
    AVPlayer *_player;
}
+(id)sharedMp3PlayerTool
{
    static Mp3PlayerTool *tool = nil;
    if (tool == nil) {
        tool = [[Mp3PlayerTool alloc]init];
    }
    return tool;
}
-(void)startToPlayMusic:(NSString *)urlStr
{
    _player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:urlStr]];
    [_player play];
}
-(void)continueToPlay
{
    [_player play];
}
-(void)pause
{
    [_player pause];
}
@end


