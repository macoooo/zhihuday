//
//  ZJICommentsModel.h
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/23.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "JSONModel.h"

@protocol CommitModel
@end

@protocol ReplytoModel
@end

@interface ReplytoModel: JSONModel
@property (nonatomic, copy)NSString *content;
@property (nonatomic, assign)NSInteger status;
@property (nonatomic, assign)NSInteger id;
@property (nonatomic, copy)NSString *author;
@property (nonatomic, assign)BOOL isOpening;
@property (nonatomic, assign)BOOL isShortOpening;
@end

@interface CommitModel: JSONModel
@property (nonatomic, copy)NSString *author;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *avatar;
@property (nonatomic, copy)NSString *time;
@property (nonatomic, assign)NSInteger id;
@property (nonatomic, assign)NSInteger likes;
@property (nonatomic, strong)ReplytoModel *replyto;
@end

@interface ZJICommentsModel : JSONModel
@property (nonatomic, copy)NSArray<CommitModel>*comments;
@end
