//
//  ZJIBaseTableViewCell.m
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/25.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "ZJIBaseTableViewCell.h"

@implementation ZJIBaseTableViewCell
+ (CGFloat)getHeight:(NSString *)content{
    return 0;
}

+ (CGFloat)getCellHeight:(NSString *)content{
    return 0;
}
- (void)reloadCellWithData:(id)data{
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
