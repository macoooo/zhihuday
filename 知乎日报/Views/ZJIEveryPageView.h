//
//  ZJIEveryPageView.h
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/18.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface ZJIEveryPageView : UIView

@property (nonatomic, strong)UIButton *returnButton;
@property (nonatomic, strong)UIButton *nextButton;
@property (nonatomic, strong)UIButton *zanButton;
@property (nonatomic, strong)UIButton *shareButton;
@property (nonatomic, strong)UIButton *commentButon;

@end
