//
//  ZJIExtraNewsManage.m
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/30.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "ZJIExtraNewsManage.h"

static ZJIExtraNewsManage *manager = nil;
@implementation ZJIExtraNewsManage
+(id)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
        
    });
    return manager;
}

- (void)fetchDataWithEveryDayID:(NSInteger)id Succeeded:(ExtraNewsHandle)succeedBlock error:(ErrorHandle)errorBlock{
    NSString *urlString = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story-extra/%ld",id];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data && (error == nil)){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            ZJIExtraNewsModel *model = [[ZJIExtraNewsModel alloc]initWithDictionary:dict error:nil];
            succeedBlock(model);
            
        }
        else{
            errorBlock(error);
        }
    }];
    [dataTask resume];
}
@end
