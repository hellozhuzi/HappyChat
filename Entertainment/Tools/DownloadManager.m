//
//  DownloadManager.m
//  网易新闻测试
//
//  Created by zhufengzhu on 16/2/29.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "DownloadManager.h"
#import "AFHTTPRequestOperation.h"

@implementation DownloadManager

+(void)GET:(NSString *)urlStr success:(myblock)block
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败:%@",error);
    }];
    
}
@end
