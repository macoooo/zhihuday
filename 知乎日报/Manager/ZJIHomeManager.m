//
//  ZJIHomeManager.m
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/7.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "ZJIHomeManager.h"

@implementation ZJIHomeManager

static ZJIHomeManager *manager = nil;

+(id)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
        
    });
    return manager;
}
- (void)fetchHomeDataWithSucceed:(ZJIHomeHandle)succeedBlock error:(ErrorHandle)errorBlock{
    NSString *urlString = @"https://news-at.zhihu.com/api/4/news/latest";
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data && (error == nil)){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            //NSLog(@"1111mmm%@",dict);
            NSError *err;
            ZJIHomeModel *homeModel = [[ZJIHomeModel alloc]initWithDictionary:dict error:&err];
            //NSLog(@"1111tttt%@   %@",homeModel, err);
            succeedBlock(homeModel);
            
        }
        else{
            errorBlock(error);
        }
    }];
    [dataTask resume];
}
- (void)fetchEveryDataWithDate:(NSString *)date Succeed:(ZJIHomeHandle)succeedBlock error:(ErrorHandle)errorBlock{
    NSString *urlString = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/news/before/%@",date];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data && (error == nil)){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            //NSLog(@"2222%@",dict);
            NSError *err;
            ZJIHomeModel *everyDayHomeModel = [[ZJIHomeModel alloc]initWithDictionary:dict error:&err];
            //NSLog(@"2222tttt%@   %@",everyDayHomeModel, err);
            succeedBlock(everyDayHomeModel);
        }
        else{
            errorBlock(error);
        }
    }];
    [dataTask resume];
}
- (void)fetchEveryPageWithID:(NSInteger)id Succeed:(ZJIEveryPageHandle)succeedBlock error:(ErrorHandle)errorBlock{
    NSString *urlString = [NSString stringWithFormat:@"https://daily.zhihu.com/story/%ld",(long)id];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data && (error == nil)){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            ZJIEveryPageModel *everyPageModel = [[ZJIEveryPageModel alloc] initWithDictionary:dict error:nil];
            succeedBlock(everyPageModel);
        }
        else{
            errorBlock(error);
        }
    }];
    [dataTask resume];
}
@end
