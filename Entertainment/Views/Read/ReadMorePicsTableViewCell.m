//
//  ReadMorePicsTableViewCell.m
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/2.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "ReadMorePicsTableViewCell.h"

@implementation ReadMorePicsTableViewCell
{
    UILabel *_titleLabel;
    UIImageView *_bigImageView;
    UIImageView *_smallImageView1;
    UIImageView *_smallImageView2;
    UILabel *_sourceLabel;
}
- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        [self creatUI];
    }
    return self;
}
- (void)creatUI
{
    float bigHeight = WIDTH/2;
    float bigWidth = bigHeight*1.3;
   
    //背景
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH-10, 200)];
    [self addSubview:bgView];
    //标题
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, WIDTH-20, 20)];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = [UIFont systemFontOfSize:FONTMAXSIZE];
    [bgView addSubview:_titleLabel];
    
    //左边图
    _bigImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame)+5, bigWidth, bigHeight)];
    [bgView addSubview:_bigImageView];
    
    //右边图
    _smallImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_bigImageView.frame)+2,CGRectGetMinY(_bigImageView.frame), (WIDTH-20-bigWidth-2),bigHeight/2-1)];
    [bgView addSubview:_smallImageView1];
    
    _smallImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_bigImageView.frame)+2,CGRectGetMaxY(_smallImageView1.frame)+2, (WIDTH-20-bigWidth-2),bigHeight/2-1)];
    [bgView addSubview:_smallImageView2];
    
    //来源
    _sourceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_bigImageView.frame)+5, WIDTH-20, 20)];
    _sourceLabel.textColor = [UIColor darkGrayColor];
    [_sourceLabel setFont:[UIFont systemFontOfSize:FONTMINSIZE]];
    [bgView addSubview:_sourceLabel];
    //分隔
    UIView *last = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_sourceLabel.frame) , WIDTH, 10)];
    last.backgroundColor =  LIGHTCOLOR;
    [bgView addSubview:last];
    
}
-(void)setModel:(ReadModel *)model
{
    _model = model;
    _titleLabel.text = model.title;
    _sourceLabel.text = model.source;
    [_bigImageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    NSArray *array = model.imgnewextra;
    if(array.count){
        [_smallImageView1 sd_setImageWithURL:[NSURL URLWithString:array[0][@"imgsrc"]]];
        [_smallImageView2 sd_setImageWithURL:[NSURL URLWithString:array[1][@"imgsrc"]]];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
