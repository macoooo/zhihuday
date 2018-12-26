//
//  ZJIHomeDataBaseHandle.m
//  
//
//  Created by 强淑婷 on 2018/12/20.
//

#import "ZJIHomeDataBaseHandle.h"

@implementation ZJIHomeDataBaseHandle

static ZJIHomeDataBaseHandle *homeDataBaseHandle = nil;

+(ZJIHomeDataBaseHandle *)shareInstance{
    @synchronized(self){
        if(!homeDataBaseHandle) {
            homeDataBaseHandle = [[ZJIHomeDataBaseHandle alloc]init];
            [homeDataBaseHandle openDataBase];
            [homeDataBaseHandle createTable];
        }
    }
    return homeDataBaseHandle;
}

#pragma mark - 定义一个 FMDatabase 对象
static FMDatabase * database = nil;

#pragma mark - 获得沙盒文件下Documents路径
- (NSString *)getDocumentsPath{
    
    NSString * documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    return documents;
}

#pragma mark - 打开数据库操作------ databaseWithPath   open
- (void)openDataBase{
    
    if (database) {
        return;
    }
    
    NSString * dataBasePath = [[self getDocumentsPath] stringByAppendingPathComponent:@"latestNews.sqlite"];
    NSLog(@"%@----dataBasePath----",dataBasePath);
    database = [FMDatabase databaseWithPath:dataBasePath];
    if (![database open]) {
        
        NSLog(@"打开数据库失败");
    }
    
    // 为数据库设置缓存,提高查询效率
    database.shouldCacheStatements = YES;
    
    NSLog(@"打开数据库成功");
}

#pragma mark - 关闭数据库操作
- (void)closeDataBase{
    
    if (![database close]) {
        NSLog(@"关闭数据库失败");
        return;
    }
    
    database = nil;
    NSLog(@"关闭数据库成功");
    
}

#pragma mark - 管理创建表的操作
- (void)createTable{
    [self openDataBase];
    if(![database tableExists:@"t_latestNews"]){
       [database executeUpdate:@"CREATE TABLE 't_latestNews' ('id' INTEGER PRIMARY KEY AUTOINCREMENT,'homeLatestNews' text, 'scrollerImageData' BLOB )"];
        NSLog(@"创建表成功");
    }
    
    [self closeDataBase];
}
- (void)creatScrollerViewImageTable{
    
}
-(NSString*)dictionaryToJson:(NSDictionary *)dic{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


#pragma mark - 增加数据操作----- executeUpdate
- (void)insertIntoDataBase:(NSDictionary *)homeDictionary{
    
    NSString *homeJSON = [self dictionaryToJson:homeDictionary];
    [self openDataBase];
    [database executeUpdate:@" DELETE FROM 't_latestNews'"];
    
    [database executeUpdate:@" INSERT INTO 't_latestNews' (homeLatestNews) VALUES (?)",homeJSON];
    NSArray *topStories = [NSArray array];
    topStories = homeDictionary[@"top_stories"];
    for(int i = 0;i < topStories.count;i++){
        NSString *imageString = topStories[i][@"sdImage"];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageString]];
        [database executeUpdate:@" INSERT INTO 't_latestNews' (scrollerImageData) VALUES (?)",imageData];
    }
    
    [self closeDataBase];
}

#pragma mark - 删除数据操作----- executeUpdate
- (void)deleteDataFromDataBase:(NSDictionary *)homeDictionary{
    
    [self openDataBase];
    
    [database executeUpdate:@" DELETE FROM 't_latestNews'"];
    
    [self closeDataBase];
}

#pragma mark - 更新数据操作----- executeUpdate
- (void)updateFromDataBase:(NSDictionary *)homeDictionary{
    NSString *homeJSON = [self dictionaryToJson:homeDictionary];
    
    [self openDataBase];
    
    [database executeUpdate:@" UPDATE 't_latestNews' (homeLatestNews) VALUES (?)",homeJSON];
    
    [self closeDataBase];
}

#pragma mark - 查询数据操作(与其他的都不一样,查询是调用executeQuery,切记切记!!!!!!)

- (NSDictionary *)selectAllDataFromDataBase{
    
    [self openDataBase];
    
    FMResultSet * resultSet = [database executeQuery:@" SELECT * FROM 't_latestNews'"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    while ([resultSet next]) {
        NSString *jsonString = [resultSet stringForColumn:@"homeLatestNews"];
        NSData *imageData = [resultSet dataForColumn:@"scrollerImageData"];
        dic = [self dictionaryWithJsonString:jsonString];
    }
    NSLog(@"%@---dictionaryWithJsonString--", dic);
    [self closeDataBase];
    return dic;
}
-(NSMutableDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                               options:NSJSONReadingMutableContainers
                                                                 error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
