//
//  VisualSidCell.m
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/3.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "VisualSidCell.h"
#import "VisualSidModel.h"
#import "VisualSidButton.h"
@implementation VisualSidCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
    }
    return self;
}
-(void)setModelArray:(NSArray *)modelArray
{
    _modelArray = modelArray;
    [self creatUI];
}
-(void)creatUI
{
    //背景
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH/4+10)];
    bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:bgView];
    //按钮
    NSInteger count = _modelArray.count;
    for (int i=0; i<count; i++) {
        VisualSidModel *model = _modelArray[i];
        //按钮
        VisualSidButton *btn = [[VisualSidButton alloc]initWithIndex:i];
        btn.model = model;
        [bgView addSubview:btn];
    }
    
//    self.separatorInset = UIEdgeInsetsZero;
    UIView *last = [[UIView alloc]initWithFrame:CGRectMake(0, WIDTH/4, WIDTH, 5)];
    last.backgroundColor = LIGHTCOLOR;
    [bgView addSubview:last];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
