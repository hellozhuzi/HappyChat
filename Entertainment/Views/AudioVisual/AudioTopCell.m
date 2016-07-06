//
//  AudioTopCell.m
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/8.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "AudioTopCell.h"

@implementation AudioTopCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self creatUI];
//        self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
       
    }
    return  self;
}
-(void)creatUI
{
    float width = WIDTH/2;
    NSArray *imageArray = @[@"feedlist_ad_download@2x.png",@"video_list_cell_time@2x.png"];
    NSArray *nameArray = @[@"我的下载",@"最近播放"];
    for (int i=0;i<2;i++ ) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*width, 0.0, width, 40)];
        [self addSubview:btn];
        UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageArray[i]]];
        imgV.frame = CGRectMake(width/4, 10+2, 16, 16) ;
        [btn addSubview:imgV];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(width/2.5, 10, 80, 20)];
        label.text = nameArray[i];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:12];
        [btn addSubview:label];
        
        [btn.layer setMasksToBounds:YES];
        [btn.layer setBorderWidth:0.1];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 217/255.0, 217/255.0, 217/255.0, 1 });
        [btn.layer setBorderColor:colorref];
        [btn.layer setBorderWidth:0.5];
    }
    UIView *partition = [[UIView alloc]initWithFrame:CGRectMake(0.0, 40, WIDTH, 5)];
    partition.backgroundColor = LIGHTCOLOR;
    [self addSubview:partition];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
