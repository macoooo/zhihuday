//
//  ZJIHomeModel.h
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/5.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "JSONModel.h"
@protocol StoriesModel
@end

@protocol TopStoriesModel
@end

@interface StoriesModel: JSONModel
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *ga_prefix;
@property (nonatomic, copy)NSArray *images;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, assign)NSInteger sdID;
@end

@interface TopStoriesModel: JSONModel
@property (nonatomic, copy)NSString *sdImage;
@property (nonatomic, copy)NSString *sdType;
@property (nonatomic, copy)NSString *orderID;
@property (nonatomic, copy)NSString *gaprefix;
@property (nonatomic, copy)NSString *sdTitle;
@end

@interface ZJIHomeModel : JSONModel
@property (nonatomic, copy)NSString *date;
@property (nonatomic, copy)NSArray<StoriesModel> *stories;
@property (nonatomic, copy)NSArray<TopStoriesModel> *top_stories;
@end
