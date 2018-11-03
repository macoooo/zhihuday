//
//  ZJILeftView.m
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/2.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "ZJILeftView.h"
#define kWidth self.bounds.size.width
#define kHeight self.bounds.size.height

@implementation ZJILeftView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth/2, self.bounds.size.height) style:UITableViewStyleGrouped];
        self.tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor colorWithRed:0.14f green:0.16f blue:0.19f alpha:1.00f];
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0 || section == 1){
        return 1;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(indexPath.section == 0 || indexPath.section == 1){
        UITableViewCell *headCell = [tableView dequeueReusableCellWithIdentifier:@"headCell"];
        if(!headCell){
            headCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"headCell"];
            headCell.backgroundColor = [UIColor colorWithRed:0.14f green:0.16f blue:0.19f alpha:1.00f];
            _headPictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _headPictureButton.frame = CGRectMake(5, 20, 40, 40);
            _headPictureButton.imageView.image = [UIImage imageNamed:@"1.jpg"];
            _headPictureButton.layer.cornerRadius = 10;
            _headPictureButton.layer.masksToBounds = YES;
            
            _nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _nameButton.frame = CGRectMake(50, 40, 100, 50);
            _nameButton.titleLabel.textColor = [UIColor lightGrayColor];
        }
         _nameButton.titleLabel.text = @"阡陌";
        [headCell.contentView addSubview:_headPictureButton];
        [headCell.contentView addSubview:_nameButton];
        return headCell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.backgroundColor = [UIColor colorWithRed:0.14f green:0.16f blue:0.19f alpha:1.00f];
        }
        cell.textLabel.text = @"首页";
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.imageView.image = [UIImage imageNamed:@"shouye-blue"];
        return cell;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
