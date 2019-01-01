//
//  ZJIHomeDataBaseHandle.h
//  
//
//  Created by 强淑婷 on 2018/12/20.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>
#import <FMDB.h>
#import "ZJIHomeModel.h"


@interface ZJIHomeDataBaseHandle : NSObject
+(ZJIHomeDataBaseHandle *)shareInstance;
- (void)createTable;
//缓存图片
- (void)creatScrollerViewImageTable;
- (void)insertIntoDataBase:(NSDictionary *)homeDictionary;
- (void)deleteDataFromDataBase:(NSDictionary *)homeDictionary;
- (void)updateFromDataBase:(NSDictionary *)homeDictionary;
- (NSDictionary *)selectAllDataFromDataBase;
- (NSMutableArray *)selectImageDataFromDataBase;
@end
