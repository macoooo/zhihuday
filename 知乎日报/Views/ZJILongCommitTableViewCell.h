//
//  ZJILongCommitTableViewCell.h
//  tableView的cell高度自适应
//
//  Created by 强淑婷 on 2018/11/21.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJICommentsModel.h"
#import <Masonry.h>
#import "ZJIBaseTableViewCell.h"
#import <UIImageView+WebCache.h>


#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height


@interface ZJILongCommitTableViewCell : ZJIBaseTableViewCell
@property (nonatomic, strong)UILabel *authorLabel;
@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong)UILabel *replyToLabel;
@property (nonatomic, strong)UIImageView *avatarImageView;
@property (nonatomic, strong)UILabel *likesLabel;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UIButton *praiseButton;
@property (nonatomic, strong)UILabel *praiseLabel;
@property (nonatomic, strong)UIButton *openButton;
@property (nonatomic, strong)ZJICommentsModel *model;
@property (nonatomic)CGFloat twoLinesHeight;
@property (nonatomic, assign)NSInteger flashIndex;
@end
