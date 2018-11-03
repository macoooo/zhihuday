//
//  ZJILeftViewController.m
//  知乎日报
//
//  Created by 强淑婷 on 2018/10/23.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "ZJILeftViewController.h"
#define kWidth self.view.bounds.size.width
#define kHeight self.view.bounds.size.height

@interface ZJILeftViewController ()<UITableViewDelegate>

@end

@implementation ZJILeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"fsgfgfdhgdfhdgdfgfdg";
    self.view.backgroundColor = [UIColor colorWithRed:0.14f green:0.16f blue:0.19f alpha:1.00f];
    
    self.leftView = [[ZJILeftView alloc]initWithFrame:CGRectMake(-kWidth/2, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.leftView];
    self.leftView.tableView.delegate =self;
    // Do any additional setup after loading the view.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 || indexPath.section == 1){
        return 100;
    }
    return 50;
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
