//
//  ZJIHomeView.h
//  知乎日报
//
//  Created by 强淑婷 on 2018/10/28.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJIScrollerView.h"
#import "ZJIHomeModel.h"
#import "ZJIEyeryDayHomeModel.h"
#import <UIImageView+WebCache.h>

@interface ZJIHomeView : UIView<UITableViewDataSource,ZJIScrollerViewDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)ZJIScrollerView *scrollerView;

@property (nonatomic, strong)ZJIHomeModel *homeModel;
@property (nonatomic, strong)NSMutableArray *homeModelMutableArray;
@property (nonatomic, strong)ZJIHomeModel *eyeryDayHomeModel;
@property (nonatomic, strong)ZJIHomeModel *latestNewsCacheModel;
- (void)fuzhiScrollerImage;
@end
