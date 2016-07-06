//
//  ReadTableViewCell.m
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/1.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "ReadTableViewCell.h"

@implementation ReadTableViewCell
{
    UIView *_bgImageView;
    UIImageView *_iconImageView;
    UILabel *_titleLabel;
    UILabel *_sourceLabel;
}
- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self creatUI];
    }
    return  self;
}
-(void)creatUI
{
    self.backgroundColor = [UIColor clearColor];
    //创建背景
    _bgImageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 120)];
    [_bgImageView setUserInteractionEnabled:YES];

    [self.contentView addSubview:_bgImageView];
    //背景上加图片
    _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_bgImageView.frame)+10, CGRectGetMinY(_bgImageView.frame)+5, 140, 100)];
    [_bgImageView addSubview:_iconImageView];
    //标题
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame)+10, CGRectGetMinY(_iconImageView.frame), CGRectGetWidth(_bgImageView.frame)-170, CGRectGetHeight(_iconImageView.frame)-20)];
    [_titleLabel setFont:[UIFont systemFontOfSize:FONTMAXSIZE]];
    [_titleLabel setTextAlignment:NSTextAlignmentLeft];
    [_titleLabel setNumberOfLines:0];
    [_bgImageView addSubview:_titleLabel];
    
    
    //来源
    _sourceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame), CGRectGetWidth(_titleLabel.frame), 20)];
    [_sourceLabel setFont:[UIFont systemFontOfSize:FONTMINSIZE]];
    [_sourceLabel setTextColor:[UIColor darkGrayColor]];
    [_bgImageView addSubview:_sourceLabel];
    
    
    //分隔线
    self.separatorInset = UIEdgeInsetsZero;
    UIView *last = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_iconImageView.frame)+5, WIDTH, 10)];
    last.backgroundColor = LIGHTCOLOR;
    [_bgImageView addSubview:last];
    
}
- (void)setModel:(ReadModel *)model
{
    _model = model;
    _titleLabel.text = model.title;
    _sourceLabel.text = model.source;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
