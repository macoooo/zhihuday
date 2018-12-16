//
//  ZJIExtraNewsModel.h
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/30.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "JSONModel.h"

@interface ZJIExtraNewsModel : JSONModel
@property (nonatomic, assign)NSInteger long_comments;
@property (nonatomic, assign)NSInteger popularity;
@property (nonatomic, assign)NSInteger short_comments;
@property (nonatomic, assign)NSInteger comments;

@end
