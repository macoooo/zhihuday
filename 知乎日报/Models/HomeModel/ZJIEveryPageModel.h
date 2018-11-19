//
//  ZJIEveryPageModel.h
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/17.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "JSONModel.h"

@interface ZJIEveryPageModel : JSONModel
@property (nonatomic, copy)NSString *body;
@property (nonatomic, copy)NSString *image_source;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *image;
@property (nonatomic, copy)NSString *share_url;
@property (nonatomic, copy)NSArray *js;
@property (nonatomic, copy)NSString *ga_prefix;
@property (nonatomic, copy)NSArray *images;
@property (nonatomic, assign)NSInteger type;
@property (nonatomic, assign)NSInteger id;
@property (nonatomic, copy)NSArray *css;
@end
