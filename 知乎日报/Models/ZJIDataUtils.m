//
//  ZJIDataUtils.m
//  知乎日报
//
//  Created by 强淑婷 on 2018/10/28.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "ZJIDataUtils.h"

@implementation ZJIDataUtils

+(NSString *)todayDateString{
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    return [formatter stringFromDate:today];
}
+(NSString *)dateStringBeforeDays:(NSInteger)days{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *before = [NSDate dateWithTimeIntervalSinceNow:days*60*60*24];
    return [formatter stringFromDate:before];
}
@end
