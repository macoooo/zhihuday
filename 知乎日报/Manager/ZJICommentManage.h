//
//  ZJICommentManage.h
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/23.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJICommentsModel.h"

typedef void (^aHandle)(ZJICommentsModel *model);
typedef void(^ErrorHandle)(NSError *error);
@interface ZJICommentManage : NSObject
+(instancetype)sharedManager;

- (void)fetchDataWithEveryDayID:(NSInteger)id Succeeded:(aHandle)succeedBlock error:(ErrorHandle)errorBlock;
- (void)fetchDataWithEveryDayShortID:(NSInteger)id Succeeded:(aHandle)succeedBlock error:(ErrorHandle)errorBlock;


@end
