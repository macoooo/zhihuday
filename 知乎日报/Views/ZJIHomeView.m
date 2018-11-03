//
//  ZJIHomeView.m
//  知乎日报
//
//  Created by 强淑婷 on 2018/10/28.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "ZJIHomeView.h"
#define kWidth self.bounds.size.width
#define kHeight self.bounds.size.height


@implementation ZJIHomeView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.tableView = [[UITableView alloc]initWithFrame:self.frame style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
        [self addSubview:_tableView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 1;
    }
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell0"];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell0"];
            _scrollerView = [[ZJIScrollerView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300.0/784 * kHeight)];
            _scrollerView.delegate = self;
            _scrollerView.images = @[
                                     [UIImage imageNamed:@"1.jpg"],
                                     [UIImage imageNamed:@"2.jpg"],
                                     [UIImage imageNamed:@"3.jpg"],
                                     [UIImage imageNamed:@"4.jpg"],
                                     [UIImage imageNamed:@"0.jpg"]
                                     ];
            _scrollerView.currentPageColor = [UIColor orangeColor];
            _scrollerView.pageColor = [UIColor grayColor];
            [cell.contentView addSubview:_scrollerView];
        }
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"Left-Demo%ld",indexPath.row];
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
