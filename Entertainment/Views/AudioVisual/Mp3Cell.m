//
//  Mp3Cell.m
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/10.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "Mp3Cell.h"

@implementation Mp3Cell
{
    UILabel *_titleLabel;
    UILabel *_dateLabel;
    UILabel *_sizeLabel;
}
- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self creatUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)creatUI
{

    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, WIDTH-75, 40)];
    [self addSubview:_titleLabel];
    
    _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_titleLabel.frame)+5, 80, 20)];
    _dateLabel.textColor = [UIColor darkGrayColor];
    _dateLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_dateLabel];
    
    _sizeLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, CGRectGetMinY(_dateLabel.frame), 50, 20)];
    _sizeLabel.textColor = [UIColor darkGrayColor];
    _sizeLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_sizeLabel];
    
    //下载按钮
    UIButton *dlBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-50, 0, 40, 40)];
    [dlBtn setImage:[UIImage imageNamed:@"night_audionews_indexheader_download"] forState:UIControlStateNormal];
    [self addSubview:dlBtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 80-0.5, WIDTH, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    
}
-(void)setModel:(Mp3ListModel *)model
{
    _titleLabel.text = model.title;
    NSArray *array = [model.ptime componentsSeparatedByString:@" "];
    _dateLabel.text = array[0];
    _sizeLabel.text = model.size;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if(selected == YES){
        _titleLabel.textColor = [UIColor redColor];
    }
    else{
        _titleLabel.textColor = [UIColor blackColor];
    }
}

@end
