//
//  ZJIDataUtils.h
//  知乎日报
//
//  Created by 强淑婷 on 2018/10/28.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJIDataUtils : NSObject


+(NSString *)todayDateString;
+(NSString *)dateStringBeforeDays:(NSInteger)days;
+(NSString *)dateSecondStringBeforeDays:(NSInteger)days;

+(NSDate *)dateBeforeDays:(NSInteger)days;
@end
