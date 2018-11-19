//
//  EveryPageViewController.m
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/18.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "EveryPageViewController.h"

@interface EveryPageViewController ()

@end

@implementation EveryPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _everyPageView = [[ZJIEveryPageView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height - 60.0/784 * kHeight, self.view.bounds.size.width, 60.0/784 * kHeight)];
    _everyPageView.backgroundColor = [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f];
    [self.view addSubview:_everyPageView];
    
    [_everyPageView.returnButton addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self loadWebView];
    // Do any additional setup after loading the view.
}
- (void)loadWebView{
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,  self.view.bounds.size.height - 60.0/784 * kHeight)];
    NSString *idString = [NSString stringWithFormat:@"https://daily.zhihu.com/story/%ld",(long)self.id];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:idString]]];
    [self.view addSubview:webView];
}
-(void)returnClick{
    ZJIHomeViewController *new = [[ZJIHomeViewController alloc]init];
    [self dismissViewControllerAnimated:new completion:nil];
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
