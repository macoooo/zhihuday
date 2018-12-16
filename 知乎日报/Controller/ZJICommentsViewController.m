//
//  ZJICommentsViewController.m
//  tableView的cell高度自适应
//
//  Created by 强淑婷 on 2018/11/23.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "ZJICommentsViewController.h"
#define K_leftmargin 180
#define K_margin 8
#define K_leftMargin 12


@interface ZJICommentsViewController ()

@property (nonatomic, strong) ZJICommentsModel * model;
@property (nonatomic, strong) NSMutableArray * cellHeightArray;
@property (nonatomic,strong)NSMutableArray *cellShortHeightArray;
@property (nonatomic, strong) NSMutableArray * cellHeightOnArray;
@property (nonatomic,strong)NSMutableArray *cellShortHeightOnArray;

@end

@implementation ZJICommentsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    _flag = 0;
    self.isSelected = NO;
    self.isLongSelected = NO;
    
    
     self.navigationItem.title = [NSString stringWithFormat:@"%ld条点评", [self.extraModel comments]];
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    UIImage *clearImage = [ZJIHomeViewController createImageWithColor:[UIColor colorWithRed:0.04f green:0.58f blue:0.95f alpha:1.00f]];
    UIImage *replaceImage = [ZJIHomeViewController imageByApplyingAlpha:1 image:clearImage];
    [self.navigationController.navigationBar setBackgroundImage:replaceImage forBarMetrics:UIBarMetricsDefault];
    
    self.cellHeightArray = [NSMutableArray array];
    self.cellShortHeightArray = [NSMutableArray array];
    self.cellHeightOnArray = [NSMutableArray array];
    self.cellShortHeightOnArray = [NSMutableArray array];
    [self update];
    _customView = [[ZJICommentsView alloc]initWithFrame:self.view.bounds];
    _customView.longCommentModel = [[ZJICommentsModel alloc]init];
    _customView.extraModel = self.extraModel;
    self.customView.tableView.delegate = self;
    [self.view addSubview:self.customView];

    self.customView.commentsViewDelegate = self;
    _twoLinesHeight =[ZJILongCommitTableViewCell getHeight:@"\ndfssdf"];

    // Do any additional setup after loading the view.
}
- (void)calculateHeight:(ZJICommentsModel *)commentsModel{
    for(int i = 0;i < commentsModel.comments.count;i++){
        CommitModel * model = commentsModel.comments[i];
        ReplytoModel *replyModel = [commentsModel.comments[i] replyto];
        NSString *contentString = nil;
        CGFloat contentHeight = 0.0;
        if(replyModel){
            contentString = [NSString stringWithFormat:@"%@\n\n//%@:%@",[model content],[replyModel author], [replyModel content]];
        }else{
            contentString = [NSString stringWithFormat:@"%@",[model content]];
        }
        contentHeight = [ZJILongCommitTableViewCell getCellHeight:contentString];
        NSString *replyStr = [NSString stringWithFormat:@"//%@:%@",[replyModel author],[replyModel content]];
        CGFloat replyHeight = [ZJILongCommitTableViewCell getHeight:replyStr];
        if(replyHeight > _twoLinesHeight){
            contentHeight = _twoLinesHeight * 1.5  + [ZJILongCommitTableViewCell getCellHeight:[model content]] ;
        }
        NSNumber *height = [NSNumber numberWithFloat:contentHeight];
        if([commentsModel isEqual:self.customView.longCommentModel]){
            [_cellHeightArray  addObject:height];
        }
        else{
            [_cellShortHeightArray addObject:height];
        }
    }
}
- (void)calculateOnHeight:(ZJICommentsModel *)commentsModel{
    for(int i = 0;i < commentsModel.comments.count;i++){
        CommitModel * model = commentsModel.comments[i];
        ReplytoModel *replyModel = [commentsModel.comments[i] replyto];
        NSString *contentString = nil;
        CGFloat contentHeight = 0.0;
        if(replyModel){
            contentString = [NSString stringWithFormat:@"%@\n\n//%@:%@",[model content],[replyModel author], [replyModel content]];
        }else{
            contentString = [NSString stringWithFormat:@"%@",[model content]];
        }
        contentHeight = [ZJILongCommitTableViewCell getCellHeight:contentString];
        NSNumber *height = [NSNumber numberWithFloat:contentHeight];
        if([commentsModel isEqual:self.customView.longCommentModel]){
            [_cellHeightOnArray  addObject:height];
        }
        else{
            [_cellShortHeightOnArray addObject:height];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 ) {
        ReplytoModel *replyModel = [self.customView.longCommentModel.comments[indexPath.row] replyto];
        if(self.customView.longCommentModel.comments.count == 0){
            return 0.0;
        }else{
            if(replyModel && replyModel.isOpening){
                return [_cellHeightOnArray[indexPath.row] floatValue];
            }
            return [_cellHeightArray[indexPath.row] floatValue];
        }
    }else{
        ReplytoModel *replyModel =  [self.customView.shortCommentModel.comments[indexPath.row] replyto];
        if(replyModel.isShortOpening){
            return [_cellShortHeightOnArray[indexPath.row] floatValue];
        }
        return [_cellShortHeightArray[indexPath.row] floatValue];
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor whiteColor];
        UILabel *headerLabel = [[UILabel alloc]init];
        [headerView addSubview:headerLabel];
        [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView).offset(5.0/440 * kWidth);
            make.top.equalTo(headerView).offset(3.0/784 * kHeight);
            make.width.mas_equalTo(kWidth * 0.5);
            make.height.mas_equalTo(44.0/784 * kHeight);
        }];
        
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        _tap.numberOfTapsRequired = 1;
        [headerView addGestureRecognizer:_tap];
        
        if(section == 0){
            if(self.customView.longCommentModel.comments.count != 0){
                headerLabel.text = [NSString stringWithFormat:@"%ld条长评",self.customView.longCommentModel.comments.count];
            }
            else{
                UIImageView *headNUllImageView = [[UIImageView alloc]init];
                [headerView addSubview:headNUllImageView];
                [headNUllImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(headerView).offset(K_leftmargin);
                    make.top.equalTo(headerView).offset(K_leftmargin);
                    make.width.mas_equalTo(100);
                    make.height.mas_equalTo(100);
                }];
                headNUllImageView.image = [UIImage imageNamed:@"虚位以待"];
            }
        }
        else{
            headerLabel.text = [NSString stringWithFormat:@"%ld条短评",self.customView.shortCommentModel.comments.count];
        }
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section  == 0 && self.customView.longCommentModel.comments.count == 0){
        return kHeight - 50.0/784 * kHeight - 64;
    }
    return 50.0/784 * kHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0;
}
- (void)update{
    NSInteger dayID = _everyDayID;
    [[ZJICommentManage sharedManager]fetchDataWithEveryDayID:dayID Succeeded:^(ZJICommentsModel *model) {
        self.model = model;
        self.customView.longCommentModel = model;
        self->_commentsModel = model;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self calculateHeight:model];
            [self calculateOnHeight:model];
            [self.customView.tableView reloadData];
        });
    } error:^(NSError *error) {
        NSLog(@"更新错误");
    }];
    
    [[ZJICommentManage sharedManager]fetchDataWithEveryDayShortID:dayID Succeeded:^(ZJICommentsModel *model) {
        self.customView.shortCommentModel = model;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self calculateHeight:model];
            [self calculateOnHeight:model];
            [self.customView.tableView reloadData];
        });
    } error:^(NSError *error) {
        NSLog(@"更新错误");
    }];
}
- (void)tapAction{
    if(_flag){
        _flag = 0;
    }
    else{
        _flag = 1;
    }
    _customView.fflag = _flag;
    [self.customView.tableView reloadData];
    if(_flag == 1){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.customView.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}
- (void)clickFoldLabel:(UIButton *)btn{
    ZJILongCommitTableViewCell *cell = (ZJILongCommitTableViewCell *)[[btn superview] superview];
    NSIndexPath *indexPath = [self.customView.tableView indexPathForCell:cell];
    ReplytoModel *reply = [self.customView.longCommentModel.comments[indexPath.row] replyto];
    if(self.isLongSelected){
        self.isLongSelected = NO;
        reply.isOpening = NO;
        
    }else{
        self.isLongSelected = YES;
        reply.isOpening = YES;
    }
    [_customView.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)clickShortFoldLabel:(UIButton *)btn{
    ZJILongCommitTableViewCell *cell = (ZJILongCommitTableViewCell *)[[btn superview] superview];
    NSIndexPath *indexPath = [self.customView.tableView indexPathForCell:cell];
    ReplytoModel *reply = [self.self.customView.shortCommentModel.comments[indexPath.row] replyto];
    if(self.isSelected){
        self.isSelected = NO;
        reply.isShortOpening= NO;
        
    }else{
        self.isSelected = YES;
        reply.isShortOpening = YES;
    }
    [_customView.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
