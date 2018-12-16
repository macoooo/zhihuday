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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self updateEveryNews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _flagID = 0;
    self.isSelectd = YES;
    self.isLoading = NO;
    
    _everyPageView = [[ZJIEveryPageView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height - 60.0/784 * kHeight, self.view.bounds.size.width, 60.0/784 * kHeight)];
    _everyPageView.backgroundColor = [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f];
    [self.view addSubview:_everyPageView];
    
    [_everyPageView.returnButton addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_everyPageView.nextButton addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_everyPageView.commentButon addTarget:self action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_everyPageView.zanButton addTarget:self  action:@selector(zanClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_everyPageView.shareButton addTarget:self action:@selector(collectionClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _alertView = [[ZJIAlertView alloc]initWithMessageButon:@"收藏"];
    [_alertView.cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    
    _everyPageView.extraModel = [[ZJIExtraNewsModel alloc]init];
    [self loadWebView];
    
    _zanLabel = [[UILabel alloc]initWithFrame:CGRectMake(170, self.view.bounds.size.height - 90.0/784 * kHeight, 50, 20)];
    _zanLabel.backgroundColor = [UIColor colorWithRed:0.44f green:0.81f blue:0.99f alpha:1.00f];
    _zanLabel.textAlignment = NSTextAlignmentCenter;
    _zanLabel.textColor = [UIColor whiteColor];
    

    // Do any additional setup after loading the view.
}
- (void)updateSinceNowEveryDayNews{
    [[ZJIHomeManager sharedManager] fetchEveryDataWithDate:[ZJIDataUtils dateSecondStringBeforeDays:self.days] Succeed:^(ZJIHomeModel *everyDayHomeModel) {
        [self.everyPageMutableArray addObject:everyDayHomeModel];
        self.isLoading = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    } error:^(NSError *error) {
        NSLog(@"更新错误");
    }];
}
- (void)updateEveryNews{
    [[ZJIExtraNewsManage sharedManager]fetchDataWithEveryDayID:self.everyID Succeeded:^(ZJIExtraNewsModel *extraNewsModel) {
        self.extraNewsModel = extraNewsModel;
        self.everyPageView.extraModel = self->_extraNewsModel;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.zanCount = self.extraNewsModel.popularity;
            [self->_everyPageView.zanButton setTitle:[NSString stringWithFormat:@"%ld",self.extraNewsModel.popularity] forState:UIControlStateNormal];
        });
    } error:^(NSError *error) {
        NSLog(@"错误");
    }];
}
- (void)loadWebView{
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,  self.view.bounds.size.height - 60.0/784 * kHeight)];
    _webView.scrollView.delegate = self;
    NSString *idString = [NSString stringWithFormat:@"https://daily.zhihu.com/story/%ld",(long)self.everyID];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:idString]]];
    [self.view addSubview:_webView];
}
- (void)collectionClick:(UIButton *)btn{
    if(btn.selected){
        btn.selected = NO;
    }else{
        btn.selected = YES;
        [self.view addSubview:_alertView];
        [_alertView setFrame:CGRectMake(0,kHeight - 60, kWidth, kHeight * 0.5)];
        [UIView animateWithDuration:0.2 animations:^{
            [self->_alertView setFrame:CGRectMake(0, kHeight * 0.5, kWidth, kHeight * 0.5)];
        }];
    }
}
- (void)cancelClick{
    [UIView animateWithDuration:0.2 animations:^{
        [self->_alertView setFrame:CGRectMake(0, 60, kWidth, kHeight * 0.5)];
    }];
    [self->_alertView removeFromSuperview];
}
- (void)nextClick{
    [UIView animateWithDuration:0.3 animations:^{
        self.webView.scrollView.contentOffset = CGPointMake(0, kHeight);
    }];
    
    _homeModel = self.everyPageMutableArray[self.section];
    NSInteger rowTempID = 0;
    NSLog(@"%ld---self.section---",self.section);
    if ((self.row + 1 == _homeModel.stories.count && self.section == self.everyPageMutableArray.count - 2)||self.section >= self.everyPageMutableArray.count - 2) {
        self.days--;
        [self updateSinceNowEveryDayNews];
    }
    if (self.row + 1 == _homeModel.stories.count){
        _homeModel = self.everyPageMutableArray[++self.section];
        self.row = 0;
        NSLog(@"%ld---self.section--change-", self.section);
    } else {
        ++self.row;
        NSLog(@"%ld----self.row----", (long)self.row);
    }
    rowTempID = [_homeModel.stories[self.row] sdID];
    NSString *idString = [NSString stringWithFormat:@"https://daily.zhihu.com/story/%ld", (long)rowTempID];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:idString]]];
    self.everyID = rowTempID;
    _flagID = 1;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (fabs(scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y) < scrollView.contentSize.height * 0.01) {
        [self nextClick];
    }
}
-(void)returnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)commentClick
{
    ZJICommentsViewController *new = [[ZJICommentsViewController alloc]init];
    new.everyDayID = self.everyID;
    new.extraModel = self.extraNewsModel;
    [self.navigationController pushViewController:new animated:YES];
}
- (void)zanClick{
    if(self.isSelectd){
        self.isSelectd = NO;
        [self.view addSubview:_zanLabel];
        [_zanLabel setFrame:CGRectMake(170, self.view.bounds.size.height - 60.0/784 * kHeight, 60, 20)];
        [UIView animateWithDuration:0.3 animations:^{
            self.zanLabel.alpha = 1.0;
            self->_zanLabel.frame = CGRectMake(170, self.view.bounds.size.height - 90.0/784 * kHeight, 60, 20);
        } completion:nil];
        _zanLabel.text = [NSString stringWithFormat:@"%ld",++self.zanCount];
    }else{
        self.isSelectd = YES;
        [_zanLabel setFrame:CGRectMake(170, self.view.bounds.size.height - 90.0/784 * kHeight, 60, 20)];
        [UIView animateWithDuration:0.3 animations:^{
            self.zanLabel.alpha = 0.0;
            [self->_zanLabel setFrame:CGRectMake(170, self.view.bounds.size.height - 60.0/784 * kHeight, 60, 20)];
        } completion:^(BOOL finished) {
            [self->_zanLabel removeFromSuperview];
        }];
    }

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
