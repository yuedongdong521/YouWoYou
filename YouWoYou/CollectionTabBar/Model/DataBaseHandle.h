//
//  DataBaseHandle.h
//  YouWoYou
//
//  Created by dlios on 15-3-30.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//
@class AllCityData;
#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DataBaseHandle : NSObject
{
    sqlite3 *dbPoint;
}

+ (DataBaseHandle *)shareInstanse;
- (void)openDB;
- (void)closeDB;
- (void)createTable;
- (void )inserCity:(AllCityData *)city;
- (void)delCity:(AllCityData *)city;
- (NSMutableArray *)selectAll;
- (BOOL)selectOne:(NSString *)str;
@end
