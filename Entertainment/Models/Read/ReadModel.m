//
//  ReadModel.m
//  网易新闻测试
//
//  Created by zhufengzhu on 16/2/29.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "ReadModel.h"

@implementation ReadModel
-(float)cellHeight
{
    if([self.template containsString:@"pic3"]){
        return 65+WIDTH/2;

    }
    else{
        return 120;
    }
 
}
@end
