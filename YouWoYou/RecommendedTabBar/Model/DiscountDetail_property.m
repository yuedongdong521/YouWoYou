//
//  DiscountDetail_property.m
//  YouWoYou
//
//  Created by dlios on 15-3-26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "DiscountDetail_property.h"

@implementation DiscountDetail_property
- (void)dealloc
{
    [_list_price release];
    [_pic release];
    [_title release];
    [_detail release];
    [_price release];
    [_end_date release];
    [_use_if release];
    [_deal_info release];
    [super dealloc];
  
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    

}


- (instancetype)initinitWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self ) {
        [self setValuesForKeysWithDictionary:dic];
        NSString *str =   [[dic objectForKey:@"price"] stringByReplacingOccurrencesOfString:@"<em>" withString:@""];
        self.price = [str stringByReplacingOccurrencesOfString:@"</em>" withString:@""];
        if ([[dic objectForKey:@"detail"] isEqualToString:@""]) {
            self.detail = @"暂无介绍";
        }
        
        
    }
    return self;
}
@end
