//
//  ZJIHomeManager.h
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/7.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJIHomeModel.h"
#import "ZJIEyeryDayHomeModel.h"
#import "ZJIEveryPageModel.h"

typedef void (^ZJIHomeHandle)(ZJIHomeModel *homeModel);

typedef void (^ZJIEveryDayHomeHandle)(ZJIEyeryDayHomeModel *eyeryDayHomeModel);
typedef void (^ZJIEveryPageHandle)(ZJIEveryPageModel *everyPageModel);

typedef void(^ErrorHandle)(NSError *error);

@interface ZJIHomeManager : NSObject

+(instancetype)sharedManager;

- (void)fetchHomeDataWithSucceed:(ZJIHomeHandle)succeedBlock error:(ErrorHandle)errorBlock;

- (void)fetchEveryDataWithDate:(NSString *)date Succeed:(ZJIHomeHandle)succeedBlock error:(ErrorHandle)errorBlock;

- (void)fetchEveryPageWithID:(NSInteger)id Succeed:(ZJIEveryPageHandle)succeedBlock error:(ErrorHandle)errorBlock;
@end
