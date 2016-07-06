//
//  ReadDetailViewController.m
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/2.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "ReadDetailViewController.h"

@interface ReadDetailViewController ()

@end

@implementation ReadDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtnWithImage:@"icon_back@2x.png"];

    [self creatWebView];
    
    // Do any additional setup after loading the view.
}

- (void)creatWebView
{
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, NAVHEIGHT, WIDTH, 0.5)];
    line.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:line];
    
    UIWebView *wv = [[UIWebView alloc]initWithFrame:CGRectMake(0, NAVHEIGHT+0.5, WIDTH,HEIGHT-NAVHEIGHT)];
    NSLog(@"navheight %lf",NAVHEIGHT);
    [DownloadManager GET:self.url success:^(NSData *data) {
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        str = [str stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        [wv loadHTMLString:str baseURL:nil];
    }];

    [self.view addSubview:wv];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
