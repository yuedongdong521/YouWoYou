//
//  Desitination_Data.h
//  YouWoYou
//
//  Created by dllo on 15/3/23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Desitination_Data : NSObject

// 目的地属性
@property (nonatomic, retain)NSString *country_id; //原数据类型为NSNumber
@property (nonatomic, retain)NSString *cnname;
@property (nonatomic, retain)NSString *enname;
@property (nonatomic, retain)NSMutableArray *hot_country;
@property (nonatomic, retain)NSMutableArray *country;
@property (nonatomic, retain)NSString *photo;
@property (nonatomic, retain)NSString *count;
@property (nonatomic, retain)NSString *label;
@property (nonatomic, assign)NSInteger flag; //原数据类型为NSNumber




- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
