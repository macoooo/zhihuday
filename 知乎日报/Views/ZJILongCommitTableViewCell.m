//
//  ZJILongCommitTableViewCell.m
//  tableView的cell高度自适应
//
//  Created by 强淑婷 on 2018/11/21.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "ZJILongCommitTableViewCell.h"
#define K_margin 8
#define K_leftMargin 12

@interface ZJILongCommitTableViewCell()

@end

@implementation ZJILongCommitTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.authorLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_authorLabel];
        
        self.contentLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_contentLabel];
        
        self.replyToLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_replyToLabel];
        
        self.likesLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_likesLabel];
        
        self.timeLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_timeLabel];
        
        self.avatarImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_avatarImageView];
        
        self.praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_praiseButton];
        
        self.praiseLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_praiseLabel];
        
        self.openButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_openButton];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(K_leftMargin);
        make.top.equalTo(self.contentView).offset(K_margin);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    self.avatarImageView.layer.cornerRadius = 15;
    self.avatarImageView.layer.masksToBounds = YES;
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_right).offset(K_margin);
        make.top.equalTo(self.contentView).offset(K_margin);
        make.width.mas_equalTo(kWidth - 30 - 2 * K_leftMargin - K_margin);
        make.height.mas_equalTo(17);
    }];
    self.authorLabel.textColor = [UIColor colorWithRed:0.24f green:0.24f blue:0.24f alpha:1.00f];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.authorLabel);
        make.top.equalTo(self.authorLabel.mas_bottom).offset(K_margin);
        make.width.mas_equalTo(kWidth - 30 - 2 * K_leftMargin - K_margin);
    }];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textColor = [UIColor colorWithRed:0.32f green:0.32f blue:0.32f alpha:1.00f];
    self.contentLabel.font = [UIFont systemFontOfSize:17];
    
    [self.replyToLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.authorLabel);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(0);
        make.width.mas_equalTo(kWidth - 30 - 2 * K_leftMargin - K_margin);
    }];
    self.replyToLabel.textColor = [UIColor colorWithRed:0.32f green:0.32f blue:0.32f alpha:1.00f];
    self.replyToLabel.font = [UIFont systemFontOfSize:17];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentLabel);
        make.bottom.equalTo(self.contentView).offset(-K_margin);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(17);
    }];
    self.timeLabel.textColor = [UIColor lightGrayColor];
    
    [self.praiseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-K_leftMargin);
        make.top.equalTo(self.authorLabel);
        make.width.mas_equalTo(25.0);
        make.height.mas_equalTo(17.0);
    }];
    self.praiseLabel.textColor = [UIColor lightGrayColor];
    
    [self.praiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.praiseLabel.mas_left);
        make.top.equalTo(self.praiseLabel);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    [self.praiseButton setImage:[UIImage imageNamed:@"点赞 (1)"] forState:UIControlStateNormal];
    
    [self.openButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-K_leftMargin);
        make.bottom.equalTo(self.contentView).offset(-K_margin);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    self.openButton.backgroundColor = [UIColor colorWithRed:0.85f green:0.89f blue:0.96f alpha:1.00f];
    self.openButton.selected = NO;
}

+ (CGFloat)getCellHeight:(NSString *)content{
    CGRect rect = [content boundingRectWithSize:CGSizeMake(kWidth - 24 - 30 - K_margin, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil];
    CGFloat height= ceilf(rect.size.height);
    return height + 4 * K_margin + 2 * 17 ;
}
+ (CGFloat)getHeight:(NSString *)content{
    CGRect rect = [content boundingRectWithSize:CGSizeMake(kWidth - 24 - 30 - K_margin, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil];
    return rect.size.height;
}
- (void)reloadCellWithData:(id)data{
   CommitModel *commitModel = nil;
    if([data isKindOfClass:CommitModel.class]){
        commitModel = (CommitModel *)data;
    }
    else{
        return;
    }
    self.authorLabel.text = [commitModel author];
    NSString *avatarString = [commitModel avatar];
    NSMutableString *str = [[NSMutableString alloc]initWithString:avatarString];
    [str insertString:@"s" atIndex:4];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:str]];
    ReplytoModel *reply = [commitModel replyto] ;
    if(reply){
        NSString *replyStr = [NSString stringWithFormat:@"\n//%@:%@",[reply author],[reply content]];
        NSMutableAttributedString *replyString = [[NSMutableAttributedString alloc]initWithString:replyStr];
//        NSRange range = [replyStr rangeOfString:[reply author]];
//        [replyString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        CGFloat replyHeight = [ZJILongCommitTableViewCell getHeight:replyStr];
        int line = replyHeight/self.replyToLabel.font.lineHeight;
        if(line > 3){
            self.openButton.hidden = NO;
            if(reply.isOpening || reply.isShortOpening){
                self.replyToLabel.numberOfLines = 0;
                [self.openButton setTitle:@"收起" forState:UIControlStateNormal];
            }else{
                self.replyToLabel.numberOfLines = 3;
                [self.openButton setTitle:@"展开" forState:UIControlStateNormal];
            }
        }
        else{
            self.replyToLabel.numberOfLines = 0;
            self.openButton.hidden = YES;
        }
        self.replyToLabel.attributedText = replyString;
        self.replyToLabel.text = replyStr;
    }else{
        self.openButton.hidden = YES;
        self.replyToLabel.text = @" ";
    }
    self.contentLabel.text = [NSString stringWithFormat:@"%@", [commitModel content]];
    NSTimeInterval timeInterval = [[commitModel time] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSString *dateTime = [formatter stringFromDate:date];
    self.timeLabel.text = dateTime;
    self.praiseLabel.text = [NSString stringWithFormat:@"%ld", [commitModel likes]];
    NSLog(@"ttttt%ld",self.replyToLabel.numberOfLines);
}

@end
