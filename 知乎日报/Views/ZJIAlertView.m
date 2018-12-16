//
//  ZJIAlertView.m
//  知乎日报
//
//  Created by 强淑婷 on 2018/12/12.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "ZJIAlertView.h"
#define kMargin 5

@implementation ZJIAlertView
- (instancetype)initWithMessageButon:(NSString *)message{
    if(self = [super init]){
        self.messageButtonString = message;
        [self setUpView];
    }
    return self;
}
- (void)setUpView{
    self.frame = CGRectMake(0, kHeight * 0.5, kWidth, kHeight * 0.5);
    self.backgroundColor = [UIColor colorWithRed:0.91f green:0.91f blue:0.91f alpha:1.00f];
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
    }];
    
    _titleLabel = [[UILabel alloc]init];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self).offset(kMargin);
        make.width.mas_equalTo(kWidth);
        make.height.mas_equalTo(4 * kMargin);
    }];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"分享这篇内容";
    
    _scrollerView = [[UIScrollView alloc]init];
    _scrollerView.contentSize = CGSizeMake(kWidth * 2, kHeight * 0.25);
    _scrollerView.scrollEnabled = YES;
    _scrollerView.pagingEnabled = YES;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.alwaysBounceHorizontal = NO;
    _scrollerView.delegate = self;
    [self addSubview:_scrollerView];
    [_scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.width.equalTo(self);
        make.height.mas_equalTo(kHeight * 0.25);
    }];
    for(int i = 0; i < 2; i++) {
        if(i == 0) {
            _qqButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_qqButton setTitle:@"QQ" forState:UIControlStateNormal];
            [_qqButton setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
            [_scrollerView addSubview:_qqButton];
            [_qqButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(kMargin);
                make.top.equalTo(self.titleLabel.mas_bottom).offset(kMargin);
                make.width.mas_equalTo(40);
                make.height.mas_equalTo(40);
            }];
        }
        else {
            _chatButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_chatButton setTitle:@"微信" forState:UIControlStateNormal];
            [_chatButton setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
            [_scrollerView addSubview:_chatButton];
            [_chatButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(kMargin + kWidth);
                make.top.equalTo(self.titleLabel.mas_bottom).offset(kMargin);
                make.width.mas_equalTo(40);
                make.height.mas_equalTo(40);
            }];
        }
    }
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.frame = CGRectMake(kWidth * 0.5 - kMargin, kHeight * 0.25 - 2 * kMargin, 20, 10);
    _pageControl.numberOfPages = 2;
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:_pageControl];
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.backgroundColor = [UIColor whiteColor];
    [self addSubview:_cancelButton];
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kMargin * 2);
        make.bottom.equalTo(self).offset(-kMargin * 3);
        make.width.mas_equalTo(kWidth - kMargin * 4);
        make.height.mas_equalTo(40);
    }];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor colorWithRed:0.73f green:0.73f blue:0.73f alpha:1.00f] forState:UIControlStateNormal];

    _collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _collectionButton.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionButton];
    [_collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kMargin * 2);
        make.bottom.equalTo(self.cancelButton.mas_top).offset(-3 * kMargin);
        make.width.mas_equalTo(kWidth - kMargin * 4);
        make.height.mas_equalTo(40);
    }];
    [_collectionButton setTitle:self.messageButtonString forState:UIControlStateNormal];
    [_collectionButton setTitleColor:[UIColor colorWithRed:0.73f green:0.73f blue:0.73f alpha:1.00f] forState:UIControlStateNormal];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x/scrollView.frame.size.width;
    _pageControl.currentPage = page;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
