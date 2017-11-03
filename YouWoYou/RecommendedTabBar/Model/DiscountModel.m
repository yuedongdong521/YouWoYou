//
//  DiscountModel.m
//  YouWoYou
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "DiscountModel.h"

@implementation DiscountModel

- (void)dealloc
{

    [_idNumber release];
    [_photo release];
    [_price release];
    [_end_date release];
    [_priceoff release];
    [_title release];
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
    if ([key isEqualToString:@"id"]) {
        self.idNumber = value;
    }
    
}
- (id)valueForUndefinedKey:(NSString *)key
{
    return  key;
}

@end
