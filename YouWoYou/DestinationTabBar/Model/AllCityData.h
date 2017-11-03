//
//  AllCityData.h
//  YouWoYou
//
//  Created by dllo on 15/3/26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllCityData : NSObject

@property (nonatomic, retain)NSString *city_id;
@property (nonatomic, retain)NSString *catename;
@property (nonatomic, retain)NSString *catename_en;
@property (nonatomic, retain)NSString *photo;
@property (nonatomic, retain)NSString *lat;
@property (nonatomic, retain)NSString *lng;
@property (nonatomic, retain)NSString *beennumber;
@property (nonatomic, retain)NSString *beenstr;
@property (nonatomic, retain)NSString *represen;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
