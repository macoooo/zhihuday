//
//  ZJILittleFunctionView.h
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/4.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface ZJILittleFunctionView : UIView
@property (nonatomic, strong)UIButton *imageButton;
@property (nonatomic, strong)UILabel *functionLabel;
@end
