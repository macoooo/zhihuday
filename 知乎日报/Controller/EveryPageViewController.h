//
//  EveryPageViewController.h
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/18.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "ZJIEveryPageView.h"
#import "ZJIHomeViewController.h"
#import "ZJICommentsViewController.h"
#import "ZJIExtraNewsManage.h"
#import "ZJIExtraNewsModel.h"
#import "ZJIDataUtils.h"
#import "ZJIHomeModel.h"
#import "ZJIAlertView.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface EveryPageViewController : UIViewController<WKUIDelegate ,UIScrollViewDelegate>
@property (nonatomic, assign)NSInteger everyID;
@property (nonatomic, strong)ZJIEveryPageView *everyPageView;
@property (nonatomic, strong)ZJIExtraNewsModel *extraNewsModel;
@property (nonatomic, assign)NSInteger nextID;
@property (nonatomic, strong)WKWebView *webView;
@property (nonatomic, strong)NSMutableArray *everyPageMutableArray;
@property (nonatomic, assign)NSInteger row;
@property (nonatomic, assign)NSInteger section;
@property (nonatomic, assign)int flagID;
@property (nonatomic, assign)NSInteger nextRow;
@property (nonatomic, strong)ZJIHomeModel *homeModel;
@property (nonatomic, assign)NSInteger days;
@property (nonatomic, assign)NSInteger zanCount;
@property (nonatomic, strong)UILabel *zanLabel;
@property (nonatomic, assign)BOOL isSelectd;
@property (nonatomic, assign)BOOL isLoading;
@property (nonatomic, strong)ZJIAlertView *alertView;      

- (void)loadWebView;
- (void)updateEveryNews;
- (void)updateSinceNowEveryDayNews;
@end
