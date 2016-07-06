//
//  AudioBigCell.m
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/9.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "AudioBigCell.h"
#import "AudioBtn.h"
@implementation AudioBigCell
{
    UIImageView *_icon;
    UILabel *_name;
    UIView *_content;
    NSMutableArray *_btnArray;
}
- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier    ])
    {
        [self creatUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

- (void)creatUI
{
    _icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    [self addSubview:_icon];
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_icon.frame)+10, 10, 100, 30)];
    _name.font = [UIFont systemFontOfSize:17];
    [self addSubview:_name];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_name.frame)+5, WIDTH, 0.5)];
    line.backgroundColor = LIGHTCOLOR;
    [self addSubview:line];
    
    _content = [[UIView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(line.frame), WIDTH-10, 200)];
    [self addSubview:_content];
    //内容
    _btnArray = [NSMutableArray array];
    for (int i=0; i<3; i++) {
        AudioBtn *btn = [[AudioBtn alloc]initWithFrame:CGRectMake(i*(WIDTH-10)/3, 0, (WIDTH-10)/3, (WIDTH-10)/3)];
        [_content addSubview:btn];
        [_btnArray addObject:btn];
    }
    //分隔
    UIView *partition = [[UIView alloc]initWithFrame:CGRectMake(0.0, CGRectGetMaxY(_content.frame), WIDTH, 5)];
    partition.backgroundColor = LIGHTCOLOR;
    [self addSubview:partition];
}
-(void)setModel:(AudioBigModel *)model
{
    _model = model;
   
    NSURL *iconUrl = [NSURL URLWithString:[NSString stringWithFormat:API_AUDIOICON,model.cid]];
    //重新设置图片时会出问题
    [_icon setImage:[UIImage imageNamed:@"contentview_image_default"]];
//    [_icon sd_setImageWithURL:[NSURL URLWithString:iconUrl]];
    [_icon sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"contentview_image_default"] options:EMSDWebImageProgressiveDownload ];

    _name.text = model.cname;
    
    for (int i=0; i<3; i++) {
        AudioBtn *btn = _btnArray[i];
        btn.model = model.tList[i];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
