//
//  DiscountList_Property.m
//  YouWoYou
//
//  Created by dlios on 15-3-26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "DiscountList_Property.h"

@implementation DiscountList_Property
- (void)dealloc{
    [_id_Discount release];
    [_pic release];
    [_title release];
    [_end_date release];
    [_buy_price release];
    [_lastminute_des release];
    [_price release];
    [super dealloc];
   
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.id_Discount = value;
           }}

- (instancetype)initinitWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
       [self setValuesForKeysWithDictionary:dic];
         NSString *str =   [[dic objectForKey:@"price"] stringByReplacingOccurrencesOfString:@"<em>" withString:@""];
        self.price = [str stringByReplacingOccurrencesOfString:@"</em>" withString:@""];
    }
    return self;
}






@end
