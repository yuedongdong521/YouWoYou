//
//  TravelData.h
//  YouWoYou
//
//  Created by dllo on 15/3/31.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelData : NSObject

@property (nonatomic, retain)NSString *travel_id;
@property (nonatomic, retain)NSString *subject;
@property (nonatomic, retain)NSString *photo;
@property (nonatomic, retain)NSString *day;
@property (nonatomic, retain)NSString *route;
@property (nonatomic, retain)NSString *uid;
@property (nonatomic, retain)NSString *username;
@property (nonatomic, retain)NSString *avatar;
@property (nonatomic, retain)NSString *updatetime;
@property (nonatomic, retain)NSString *view_url;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
