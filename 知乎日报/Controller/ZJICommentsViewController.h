//
//  ZJICommentsViewController.h
//  tableView的cell高度自适应
//
//  Created by 强淑婷 on 2018/11/23.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJICommentsModel.h"
#import "ZJICommentManage.h"
#import "ZJICommentsView.h"
#import "ZJILongCommitTableViewCell.h"
#import "EveryPageViewController.h"
#import <Masonry.h>
#import "ZJIExtraNewsModel.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface ZJICommentsViewController : UIViewController<UITableViewDelegate,ZJICommentsViewDelegate>
@property (nonatomic, strong)ZJICommentsView *customView;
@property (nonatomic, assign)NSInteger everyDayID;
@property (nonatomic, strong)NSMutableArray *isExpandArray;
@property (nonatomic, strong)UITapGestureRecognizer *tap;
@property (nonatomic, strong)ZJIExtraNewsModel *extraModel;
@property (nonatomic)int flag;
@property (nonatomic)CGFloat longCommentsHeight;
@property (nonatomic)int viewControllerFlag;
@property (nonatomic)CGFloat twoLinesHeight;
@property (nonatomic, strong)ZJICommentsModel  *commentsModel;
@property (nonatomic)BOOL isSelected;
@property (nonatomic)BOOL isLongSelected;
- (void)update;
@end
