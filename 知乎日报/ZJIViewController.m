//
//  ZJIViewController.m
//  知乎日报
//
//  Created by 强淑婷 on 2018/10/22.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "ZJIViewController.h"

@interface ZJIViewController ()

@end

@implementation ZJIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.07f green:0.51f blue:0.85f alpha:1.00f];
    self.navigationController.navigationItem.title = @"今日新闻";
    // Do any additional setup after loading the view.
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
