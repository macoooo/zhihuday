//
//  ZJIEveryPageView.m
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/18.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "ZJIEveryPageView.h"

@implementation ZJIEveryPageView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_returnButton];
        
        self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_nextButton];
        
        self.zanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_zanButton];
        
        self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_shareButton];
        
        self.commentButon = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_commentButon];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.returnButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [self.returnButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20.0/440 * kWidth);
        make.top.equalTo(self).offset(5.0/784 * kHeight);
        make.width.mas_equalTo(40.0/440 * kWidth);
        make.height.mas_equalTo(40.0/784 * kHeight);
    }];
    
    [self.nextButton setImage:[UIImage imageNamed:@"下一页"] forState:UIControlStateNormal];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(100.0/440 * kWidth);
        make.top.equalTo(self).offset(5.0/784 * kHeight);
        make.width.mas_equalTo(40.0/440 * kWidth);
        make.height.mas_equalTo(40.0/784 * kHeight);
    }];
    
    [self.zanButton setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
    [self.zanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(180.0/440 * kWidth);
        make.top.equalTo(self).offset(10.0/784 * kHeight);
        make.width.mas_equalTo(60.0/440 * kWidth);
        make.height.mas_equalTo(40.0/784 * kHeight);
    }];
    [self.zanButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 8, 0)];
    [self.zanButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.zanButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    [self.shareButton setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(270.0/440 * kWidth);
        make.top.equalTo(self).offset(5.0/784 * kHeight);
        make.width.mas_equalTo(40.0/440 * kWidth);
        make.height.mas_equalTo(40.0/784 * kHeight);
    }];
    
    [self.commentButon setImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
    [self.commentButon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(350.0/440 * kWidth);
        make.top.equalTo(self).offset(5.0/784 * kHeight);
        make.width.mas_equalTo(40.0/440 * kWidth);
        make.height.mas_equalTo(40.0/784 * kHeight);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
