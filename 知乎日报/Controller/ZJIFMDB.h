//
//  ZJIFMDB.h
//  知乎日报
//
//  Created by 强淑婷 on 2018/12/16.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>

@interface ZJIFMDB : NSObject

@property (nonatomic, copy)NSString *pathString;
//查找数据库
+ (void)querySQLWithPath:(NSString *)pathString;
//创建表
+ (void)creatTableWithSQLName:(NSString *)sqlName andResultBlock:(void (^)(BOOL))block;
//增
+  (void)insertSQLWithName:(NSString *)sqlName andResultBlock:(void (^)(BOOL))block;

//删
+ (void)deleteSQLWithName:(NSString *)sqlName andResultBlock:(void (^)(BOOL))block;

//更新
+(void)updateSQLWithName:(NSString *)sqlName andResultBlock:(void (^)(BOOL))block;
//搜索一条数据
+ (void)searchOneDataWithSQL:(NSString *)sqlName andResultBlock:(void(^)(BOOL result, NSDictionary *dict))block;
//搜索所有数据
+ (void)searchAllDataWithSQL:(NSString *)sqlName andResultBlock:(void (^)(BOOL success, NSMutableArray *goodList))block;


@end
