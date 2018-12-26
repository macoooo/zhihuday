//
//  ZJIFMDB.m
//  知乎日报
//
//  Created by 强淑婷 on 2018/12/16.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "ZJIFMDB.h"

static FMDatabase *database = nil;
@implementation ZJIFMDB

- (void)setPathString:(NSString *)pathString{
    self.pathString = pathString;
}

+ (void)querySQLWithPath:(NSString *)pathString
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:pathString];
    
    //FMDB 创建数据库文件
    database = [FMDatabase databaseWithPath:path];
    NSLog(@"db--path==%@",path);
}
+ (void)creatTableWithSQLName:(NSString *)sqlName andResultBlock:(void (^)(BOOL))block{
   
    BOOL jh;            　
    if([database open]){
        if([database executeUpdate:sqlName]) {
            jh = YES;
        }else {
            jh = NO;
        }
        block(jh);
    } else {
        NSLog(@"打开数据库失败");
    }
}

+(void)insertSQLWithName:(NSString *)sqlName andResultBlock:(void (^)(BOOL))block{
    BOOL jh;
    if([database open]){
        if([database executeUpdate:sqlName]) {
            jh = YES;
        }else {
            jh = NO;
        }
        block(jh);
    }else {
        NSLog(@"打开数据库失败");
    }
}

+ (void)deleteSQLWithName:(NSString *)sqlName andResultBlock:(void (^)(BOOL))block{
    BOOL jh;
    if([database open]){
        if([database executeUpdate:sqlName]) {
            jh = YES;
        } else {
            jh = NO;
        }
        block(jh);
    }else {
        NSLog(@"打开数据库失败");
    }
}

+(void)updateSQLWithName:(NSString *)sqlName andResultBlocck:(void (^)(BOOL result))block
{
    BOOL jh;
    if ([database open]) {
        
        if ([database executeUpdate:sqlName]) {
            jh = YES;
        }else{
            jh = NO;
        }
        
        block(jh);
        
    }else {
        NSLog(@"打开数据库失败");
    }
}
//搜素一条数据
+ (void)searchOneDataWithSQL:(NSString *)sqlName andResultBlock:(void (^)(BOOL, NSDictionary *))block{
    
}

//搜索所有数据
+ (void)searchAllDataWithSQL:(NSString *)sqlName andResultBlock:(void (^)(BOOL, NSMutableArray *))block{
    
}
@end
