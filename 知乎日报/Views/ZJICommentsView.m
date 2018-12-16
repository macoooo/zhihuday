//
//  ZJICommentsView.m
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/23.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "ZJICommentsView.h"
#define CellName @"longCommitCell"
#define CellShortName @"shortCommitCell"
#define K_leftmargin 180

@implementation ZJICommentsView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, self.frame.size.height - 64) style:UITableViewStyleGrouped];
        
        [self.tableView registerClass:[ZJILongCommitTableViewCell class] forCellReuseIdentifier:CellName];
        [self.tableView registerClass:[ZJILongCommitTableViewCell class] forCellReuseIdentifier:CellShortName];
        self.tableView.dataSource = self;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        [self addSubview:_tableView];
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section  == 0 ){
        NSArray *rowCountArray = _longCommentModel.comments;
        return rowCountArray.count;
    }
    else{
        if(_fflag == 1){
            return _shortCommentModel.comments.count;
        }else{
            return 0;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        ZJILongCommitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellName forIndexPath:indexPath];
        if(!cell){
            cell = [[ZJILongCommitTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellName];
        }
       
        [cell reloadCellWithData:self.longCommentModel.comments[indexPath.row]];
        [cell.openButton addTarget:self action:@selector(clickNewsOrNo:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else{
        ZJILongCommitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellShortName forIndexPath:indexPath];
        if(!cell){
            cell = [[ZJILongCommitTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellShortName];
        }
        [cell reloadCellWithData:self.shortCommentModel.comments[indexPath.row]];
        [cell.openButton addTarget:self action:@selector(clickShortNewsOrNo:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}
- (void)clickNewsOrNo:(UIButton *)btn{
    if(self.commentsViewDelegate && [self.commentsViewDelegate respondsToSelector:@selector(clickFoldLabel:)]){
        [self.commentsViewDelegate clickFoldLabel:btn];
    }
}
- (void)clickShortNewsOrNo:(UIButton *)btn{
    if(self.commentsViewDelegate && [self.commentsViewDelegate respondsToSelector:@selector(clickShortFoldLabel:)]){
        [self.commentsViewDelegate clickShortFoldLabel:btn];
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
