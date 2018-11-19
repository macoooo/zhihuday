//
//  ZJIStoriesTableViewCell.m
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/5.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "ZJIStoriesTableViewCell.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@implementation ZJIStoriesTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.titleLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_titleLabel];
        
        self.storiesImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_storiesImageView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15.0/440 * kWidth);
        make.top.equalTo(self.contentView).offset(10.0/784 * kHeight);
        make.width.mas_equalTo(kWidth * 0.75);
        make.height.mas_equalTo(100.0/784 * kHeight);
    }];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [self.storiesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(10.0/440 * kWidth);
        make.top.equalTo(self.contentView).offset(15.0/784 * kHeight);
        make.width.mas_equalTo(kWidth * 0.17);
        make.height.mas_equalTo(70.0/784 * kHeight);
    }];
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
