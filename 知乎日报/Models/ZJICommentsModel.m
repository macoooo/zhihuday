//
//  ZJICommentsModel.m
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/23.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "ZJICommentsModel.h"

@implementation ZJICommentsModel
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}
@end
@implementation CommitModel
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"replyto":@"reply_to"
                                                                  
                                                                  }];
}
@end
@implementation ReplytoModel
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}
@end

