//
//  ZJIHomeViewController.h
//  知乎日报
//
//  Created by 强淑婷 on 2018/10/22.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJIHomeManager.h"
#import "ZJIHomeModel.h"
#import "ZJIEveryPageModel.h"
#import "EveryPageViewController.h"
#import "ZJIHomeDataBaseHandle.h"


@interface ZJIHomeViewController : UIViewController
@property (nonatomic, strong)ZJIHomeModel *homeModel;
@property (nonatomic, assign)NSInteger days;
@property (nonatomic, strong)UIRefreshControl *refreshControl;
@property (nonatomic, strong)UITapGestureRecognizer *tapToHideSideMenu;
@property (nonatomic, strong)ZJIEveryPageModel *everyPageModel;
@property (nonatomic, strong)NSMutableArray *everyPageMutableArray;
@property (nonatomic, assign)int flag;
@property (nonatomic, strong)NSMutableArray *everyDayMutableArray;
- (void)updateLatestNews;
- (void)updateEveryNews;
- (void)updateEveryPageNews:(NSInteger)id;
+ (UIImage *)createImageWithColor:(UIColor *)color;
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image;
@end
