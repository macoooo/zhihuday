//
//  ZJILittleFunctionView.m
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/4.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "ZJILittleFunctionView.h"
#import <Masonry.h>

@implementation ZJILittleFunctionView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_imageButton];
        
        self.functionLabel = [[UILabel alloc]init];
        [self addSubview:_functionLabel];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(2.0/440.0 * kWidth);
        make.top.equalTo(self).offset(2.0/784 * kHeight);
        make.width.mas_equalTo(70.0/440.0 * kWidth);
        make.height.mas_equalTo(60.0/784 * kHeight);
    }];
    [self.functionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5.0/440.0 * kWidth);
        make.top.equalTo(self).offset(55.0/784 * kHeight);
        make.width.mas_equalTo(70.0/440.0 * kWidth);
        make.height.mas_equalTo(30.0/784 * kHeight);
    }];
    self.functionLabel.textColor = [UIColor lightGrayColor];
    self.functionLabel.textAlignment = NSTextAlignmentCenter;
    self.functionLabel.font = [UIFont systemFontOfSize:15];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
