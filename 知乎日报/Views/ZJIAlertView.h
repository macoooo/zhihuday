//
//  ZJIAlertView.h
//  知乎日报
//
//  Created by 强淑婷 on 2018/12/12.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface ZJIAlertView : UIView<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scrollerView;
@property (nonatomic, strong)UIButton *collectionButton;
@property (nonatomic, strong)UIButton *cancelButton;
@property (nonatomic, strong)UIButton *chatButton;
@property (nonatomic, strong)UIButton *qqButton;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, copy)NSString *messageButtonString;

- (instancetype)initWithMessageButon:(NSString *)message;
@end
