//
//  ZJICommentsView.h
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/23.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJILongCommitTableViewCell.h"
#import "ZJICommentsModel.h"
#import <UIImageView+WebCache.h>
#import "ZJIExtraNewsModel.h"

@class ZJILongCommitTableViewCell;
@protocol ZJICommentsViewDelegate <NSObject>
- (void)clickFoldLabel:(UIButton *)btn;
- (void)clickShortFoldLabel:(UIButton *)btn;
@end

@interface ZJICommentsView : UIView<UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)ZJICommentsModel *longCommentModel;
@property (nonatomic, strong)ZJICommentsModel *shortCommentModel;
@property (nonatomic, strong)ZJIExtraNewsModel *extraModel;
@property (nonatomic)int fflag;
@property (nonatomic)int viewFlag;
//是否折叠数组
@property (nonatomic, strong)NSMutableArray *isExpandMutableArray;

@property (nonatomic, weak)id<ZJICommentsViewDelegate> commentsViewDelegate; 
@end
