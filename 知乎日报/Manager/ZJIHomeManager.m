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
- (void)fetchHomeDataWithSucceed:(ZJIHomeHandle)succeedBlock error:(ErrorSaveHandle)errorBlock{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    NSString *urlString = @"https://news-at.zhihu.com/api/4/news/latest";
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data && (error == nil)){
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSError *err;
            ZJIHomeModel *homeModel = [[ZJIHomeModel alloc]initWithDictionary:dict error:&err];
            succeedBlock(homeModel);
            
            [[ZJIHomeDataBaseHandle shareInstance] createTable] ;
            [[ZJIHomeDataBaseHandle shareInstance] insertIntoDataBase:dict] ;
            
            dispatch_semaphore_signal(sema);
        }
        else{
            NSDictionary *dict = [[ZJIHomeDataBaseHandle shareInstance] selectAllDataFromDataBase];
            ZJIHomeModel *latestNewsModel = [[ZJIHomeModel alloc]initWithDictionary:dict error:nil];
            NSLog(@"%@---latestNewsModel-----",latestNewsModel);
            errorBlock(error, latestNewsModel);
            
            dispatch_semaphore_signal(sema);
        }
    }];
    [dataTask resume];
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
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
            NSError *err;
            ZJIHomeModel *everyDayHomeModel = [[ZJIHomeModel alloc]initWithDictionary:dict error:&err];
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
