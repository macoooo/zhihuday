//
//  ZJIHomeView.h
//  知乎日报
//
//  Created by 强淑婷 on 2018/10/28.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJIScrollerView.h"

@interface ZJIHomeView : UIView<UITableViewDelegate, UITableViewDataSource,ZJIScrollerViewDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)ZJIScrollerView *scrollerView;
@end
