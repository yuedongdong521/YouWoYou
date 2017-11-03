//
//  CountryData.m
//  YouWoYou
//
//  Created by dllo on 15/3/24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "CountryData.h"

@implementation CountryData

- (void)dealloc
{
    [_city_id release];
    [_cnname release];
    [_enname release];
    [_photo release];
    [_photos release];
    [_overview_url release];
    [_hot_city release];
    [_discount release];
    
    [_title release];
    [_priceStr release];
    [_priceoff release];
    [_expire_date release];
    
    [_hot_mguide release];
    [_hot_mguideID release];
    [_user_id release];
    [_username release];
    [_avatar release];
    [_country_id release];
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
    if ([key isEqualToString:@"new_discount"]) {
        self.discount = value;
    }
    
    if ([key isEqualToString:@"id"] && [value isKindOfClass:[NSString class]]) {
        self.city_id = value;
    } else if ([key isEqualToString:@"id"]){
        self.city_id = [NSString stringWithFormat:@"%@", value];
    }
    
    if ([key isEqualToString:@"user_id"]) {
        self.user_id = [NSString stringWithFormat:@"%@", value];
    }
    
    if ([key isEqualToString:@"price"]) {
        NSString *strV = [NSString string];
        for (NSInteger i = 4; i < [value length]; i++) {
            NSRange range = NSMakeRange(i, 1);
            NSString *str = [value substringWithRange:range];
            
            if ([str isEqualToString:@"<"] ) {
                break;
            }
            strV = [strV stringByAppendingString:str];
        }
           self.priceStr = [strV stringByAppendingString:@"元起"];
    }
    
}

@end
