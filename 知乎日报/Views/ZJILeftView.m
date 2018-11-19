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
    if(indexPath.section == 0){
        UITableViewCell *headCell = [tableView dequeueReusableCellWithIdentifier:@"headCell"];
        if(!headCell){
            headCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"headCell"];
            headCell.backgroundColor = [UIColor colorWithRed:0.14f green:0.16f blue:0.19f alpha:1.00f];
            _headPictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _headPictureButton.frame = CGRectMake(5, 20, 40, 40);
            [_headPictureButton setImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
            _headPictureButton.layer.cornerRadius = 20;
            _headPictureButton.layer.masksToBounds = YES;
            
            _nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [headCell.contentView addSubview:_headPictureButton];
            [headCell.contentView addSubview:_nameButton];
            [_nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(headCell.contentView).offset(50.0/440 * kWidth);
                make.top.equalTo(headCell.contentView).offset(20.0/784 * kHeight);
                make.width.mas_equalTo(100.0/440 * kWidth);
                make.height.mas_equalTo(50.0/784 * kHeight);
            }];
            [_nameButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
        [_nameButton setTitle:@"阡陌" forState:UIControlStateNormal];
        return headCell;
    }if(indexPath.section == 1){
        UITableViewCell  *functionCell = [tableView dequeueReusableCellWithIdentifier:@"functionCell"];
        if(!functionCell){
            functionCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"functionCell"];
            functionCell.backgroundColor = [UIColor colorWithRed:0.14f green:0.16f blue:0.19f alpha:1.00f];
            for(int i = 0;i < 3;i++){
                _littleView = [[ZJILittleFunctionView alloc]initWithFrame:CGRectMake(80/440.0 * kWidth * i, 0, 80/440.0 * kWidth, 100/784.0 * kHeight)];
                NSArray *array = [NSArray array];
                array = [NSArray arrayWithObjects:@"收藏",@"消息", @"设置",nil];
                _littleView.functionLabel.text = array[i];
                [_littleView.imageButton setImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
                [functionCell.contentView addSubview:_littleView];
            }
        }
        return functionCell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.backgroundColor = [UIColor colorWithRed:0.14f green:0.16f blue:0.19f alpha:1.00f];
        }
        cell.textLabel.text = @"首页";
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.imageView.image = [UIImage imageNamed:@"shouye-blue"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
