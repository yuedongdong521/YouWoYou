//
//  CountryData.h
//  YouWoYou
//
//  Created by dllo on 15/3/24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryData : NSObject


@property (nonatomic, retain)NSString *city_id;
@property (nonatomic, retain)NSString *cnname;
@property (nonatomic, retain)NSString *enname;
@property (nonatomic, retain)NSString *photo;



// 国家详情特有属性
@property (nonatomic, retain)NSMutableArray *photos;
@property (nonatomic, retain)NSString *overview_url;
@property (nonatomic, retain)NSMutableArray *hot_city;
@property (nonatomic, retain)NSMutableArray *discount; //与网络数据名不同

// hot_mguide
@property (nonatomic, retain)NSMutableArray *hot_mguide;
@property (nonatomic, retain)NSString *hot_mguideID;
@property (nonatomic, retain)NSString *user_id;
@property (nonatomic, retain)NSString *username;
@property (nonatomic, retain)NSString *avatar;
@property (nonatomic, retain)NSString *country_id;


// discount中字典的key

@property (nonatomic, retain)NSString *title;
@property (nonatomic, retain)NSString *priceStr;
@property (nonatomic, retain)NSString *priceoff;
@property (nonatomic, retain)NSString *expire_date;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
