//
//  ZJIBaseTableViewCell.h
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/25.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJICommentsModel.h"
@interface ZJIBaseTableViewCell : UITableViewCell

+ (CGFloat)getCellHeight:(NSString *)content;

+ (CGFloat)getHeight:(NSString *)content;

- (void)reloadCellWithData:(ZJICommentsModel *)data;

@end
