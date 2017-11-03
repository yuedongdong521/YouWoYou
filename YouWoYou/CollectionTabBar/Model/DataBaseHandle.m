//
//  DataBaseHandle.m
//  YouWoYou
//
//  Created by dlios on 15-3-30.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "DataBaseHandle.h"
#import "AllCityData.h"
@implementation DataBaseHandle
+ (DataBaseHandle *)shareInstanse
{
    static DataBaseHandle *dbHander = nil;
    if (dbHander == nil) {
       dbHander = [[DataBaseHandle alloc]init];
   }
    return dbHander;
    
}
- (void)openDB
{
    NSString*docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *dbPath  = [docPath stringByAppendingPathComponent:@"movie.pp"];
    NSLog(@"dbPath%@",dbPath);
    int result =  sqlite3_open([dbPath UTF8String], &dbPoint);
    [self judgeResult:result type:@"打开数据库"];
    
}
- (void)closeDB
{
    int result =  sqlite3_close(dbPoint);
    if (result == SQLITE_OK) {
        NSLog(@"关闭数据库成功");
    }else
    {
        NSLog(@"关闭数据库失败,失败编码 : %d" , result);
    }
    
}
- (void)judgeResult:(int)result type:(NSString *)type
{
    if(result == SQLITE_OK)
    {
        NSLog(@"%@成功",type);
   }
    else{
        NSLog(@"%@失败,失败编号:%d",type, result);
   }
}

- (void)createTable
{
    NSString *sqlStr = @"create table city (catename text , photo text, id_city text primary key)";
    int result =   sqlite3_exec(dbPoint,[sqlStr UTF8String], NULL, NULL, NULL);
   [self judgeResult:result type:@"创建表"];
}

- (void)inserCity:(AllCityData *)city
{
    NSString *sqlStr = [NSString stringWithFormat: @"insert into city values('%@', '%@' , '%@')",city.catename ,city.photo , city.city_id ];
    int result =   sqlite3_exec(dbPoint,[sqlStr UTF8String], NULL, NULL, NULL);
    [self judgeResult:result type:@"插入数据"];
}
- (void)delCity:(AllCityData *)city
{
        NSString *sqlStr = [NSString stringWithFormat: @"delete from city where id_city = '%@'",city.city_id];
        int result =   sqlite3_exec(dbPoint,[sqlStr UTF8String], NULL, NULL, NULL);
         [self judgeResult:result type:@"删除数据"];
}

- (NSMutableArray *)selectAll
{
    NSString *sqlStr = @"select * from city";
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare(dbPoint, [sqlStr UTF8String], -1, &stmt, NULL);
    NSMutableArray *cityArr = [NSMutableArray array];
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            AllCityData *city = [[AllCityData alloc]init];
            const unsigned char *catenameChar = sqlite3_column_text(stmt, 0);
            NSString *catename =[NSString stringWithUTF8String:(const char *) catenameChar];
            city.catename = catename;
            
            
            const unsigned char *photoChar = sqlite3_column_text(stmt, 1);
            NSString *photo =[NSString stringWithUTF8String:(const char *) photoChar];
            city.photo = photo;
            
            
            const unsigned char *id_cityChar = sqlite3_column_text(stmt, 2);
            NSString *id_city =[NSString stringWithUTF8String:(const char *) id_cityChar];
            city.city_id = id_city;
            
            [cityArr addObject:city];
            [city release];
           
        }
    }
    sqlite3_finalize(stmt);
    return cityArr;
}

- (BOOL)selectOne:(NSString *)str
{
    NSString *sqlStr = @"select * from city";
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare(dbPoint, [sqlStr UTF8String], -1, &stmt, NULL);
    NSMutableArray *cityArr = [NSMutableArray array];
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            AllCityData *city = [[AllCityData alloc]init];
            const unsigned char *catenameChar = sqlite3_column_text(stmt, 0);
            NSString *catename =[NSString stringWithUTF8String:(const char *) catenameChar];
            city.catename = catename;
            
            
            const unsigned char *photoChar = sqlite3_column_text(stmt, 1);
            NSString *photo =[NSString stringWithUTF8String:(const char *) photoChar];
            city.photo = photo;
            
            
            const unsigned char *id_cityChar = sqlite3_column_text(stmt, 2);
            NSString *id_city =[NSString stringWithUTF8String:(const char *) id_cityChar];
            city.city_id = id_city;
            
            [cityArr addObject:city];
            [city release];
            
        }
    }
    sqlite3_finalize(stmt);
    NSInteger I = 0;
    for (AllCityData *city in cityArr) {
        if ([city.city_id isEqualToString:str]) {
            I = 1;
        }
        
    }
    
    if (I == 1) {
        return YES;
    } else {
        return NO;
    }
    
}



@end
