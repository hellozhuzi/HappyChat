//
//  VisualSidButton.m
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/3.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "VisualSidButton.h"

@implementation VisualSidButton
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
}
-(instancetype)initWithIndex:(NSInteger)index
{
    if(self = [super init]){
        CGPoint center =  CGPointMake(WIDTH/8+index*WIDTH/4, WIDTH/8);
//        NSLog(@"x=%f",center.x);
        self.frame = CGRectMake(0, 0, WIDTH/4, WIDTH/4);
        self.center = center;
        [self.layer setMasksToBounds:YES];
        [self.layer setBorderWidth:0.1];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 217/255.0, 217/255.0, 217/255.0, 1 });
        [self.layer setBorderColor:colorref];
        [self.layer setBorderWidth:2];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
        _imageView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2-10);

        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)/2+15, WIDTH/4, 30)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:FONTMINSIZE];
        [self addSubview:_titleLabel];
    }
    return self;
}

-(void)setModel:(VisualSidModel *)model
{
    _model = model;
    [_imageView  sd_setImageWithURL:[NSURL URLWithString:self.model.imgsrc]];
    _titleLabel.text = model.title;
    
}
@end
