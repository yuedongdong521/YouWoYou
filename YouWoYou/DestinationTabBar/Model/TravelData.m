//
//  TravelData.m
//  YouWoYou
//
//  Created by dllo on 15/3/31.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "TravelData.h"

@implementation TravelData


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
    if ([key isEqualToString:@"id"]) {
        self.travel_id = value;
    }
    if ([key isEqualToString:@"day_count"]) {
        self.day = [value stringByAppendingString:@"天  "];
    }
}

- (void)dealloc
{
    [_travel_id release];
    [_subject release];
    [_photo release];
    [_day release];
    [_route release];
    [_uid release];
    [_username release];
    [_avatar release];
    [_updatetime release];
    [_view_url release];
    [super dealloc];
}

@end
