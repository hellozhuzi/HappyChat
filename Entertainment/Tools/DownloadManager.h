//
//  DownloadManager.h
//  网易新闻测试
//
//  Created by zhufengzhu on 16/2/29.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^myblock) (id obj);
@interface DownloadManager : NSObject
+(void)GET:(NSString *)urlStr success:(myblock)block;
@end
