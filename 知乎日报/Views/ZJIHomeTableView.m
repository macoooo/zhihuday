//
//  ZJIHomeTableView.m
//  知乎日报
//
//  Created by 强淑婷 on 2018/10/22.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "ZJIHomeTableView.h"
#import "ZJIScrollerView.h"
#define kWidth self.bounds.size.width
#define kHeight self.bounds.size.height

@implementation ZJIHomeTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.tableView = [[UITableView alloc]initWithFrame:self.frame style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
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
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        return 300.0/784 * kHeight;
    }
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0;
    }
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return nil;
    }
    return  [[UIView alloc]init];
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
