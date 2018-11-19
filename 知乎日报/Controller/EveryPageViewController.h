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

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface EveryPageViewController : UIViewController
@property (nonatomic, assign)NSInteger id;
@property (nonatomic, strong)ZJIEveryPageView *everyPageView;
- (void)loadWebView;
@end
