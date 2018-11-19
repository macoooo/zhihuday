//
//  ZJIHomeModel.m
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/5.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "ZJIHomeModel.h"

@implementation ZJIHomeModel
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}
@end
@implementation StoriesModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"sdID":@"id",
                                                            }];
}
@end
@implementation TopStoriesModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"orderID":@"id",
                                                                 @"sdImage":@"image",
                                                                 @"gaprefix":@"ga_prefix",
                                                                  @"sdType":@"type",
                                                                  @"sdTitle":@"title"
                                                                 }];
}
@end
