//
//  ZJIExtraNewsManage.h
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/30.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJIExtraNewsModel.h"

typedef void (^ExtraNewsHandle)(ZJIExtraNewsModel *extraNewsModel);
typedef void (^ErrorHandle)(NSError *error);
@interface ZJIExtraNewsManage : NSObject
+(instancetype)sharedManager;

- (void)fetchDataWithEveryDayID:(NSInteger)id Succeeded:(ExtraNewsHandle)succeedBlock error:(ErrorHandle)errorBlock;
@end
