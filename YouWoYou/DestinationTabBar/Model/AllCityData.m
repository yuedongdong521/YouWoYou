//
//  AllCityData.m
//  YouWoYou
//
//  Created by dllo on 15/3/26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "AllCityData.h"

@implementation AllCityData

- (void)dealloc
{
    [_city_id release];
    [_catename release];
    [_catename_en release];
    [_photo release];
    [_lat release];
    [_lng release];
    [_beennumber release];
    [_beenstr release];
    [_represen release];
    [super dealloc];
}

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"representative"]) {
        self.represen = [@"代表景点 : " stringByAppendingString:value];
    }
    
    if ([key isEqualToString:@"id"]) {
        self.city_id = value;
    }
    
}
@end
