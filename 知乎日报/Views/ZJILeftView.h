//
//  ZJILeftView.h
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/2.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>

@interface ZJILeftView : UIView<UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIImageView *headPictureImageView;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UIButton *headPictureButton;
@property (nonatomic, strong)UIButton *nameButton;
@end
