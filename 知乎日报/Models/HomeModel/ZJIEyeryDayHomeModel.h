//
//  ZJIEyeryDayHomeModel.h
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/12.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "JSONModel.h"

@protocol StoryModel
@end

@interface StoryModel: JSONModel
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *ga_prefix;
@property (nonatomic, copy)NSArray *images;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *id;
@end

@interface ZJIEyeryDayHomeModel : JSONModel
@property (nonatomic, copy)NSString *date;
@property (nonatomic, copy)NSArray<StoryModel> *stories;
@end
