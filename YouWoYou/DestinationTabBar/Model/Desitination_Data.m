//
//  Desitination_Data.m
//  YouWoYou
//
//  Created by dllo on 15/3/23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "Desitination_Data.h"

@implementation Desitination_Data

- (void)dealloc
{
    [_country_id release];
    [_cnname release];
    [_enname release];
    [_hot_country release];
    [_photo release];
    [_country release];
    [_label release];
    [_count release];
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
        self.country_id = [NSString stringWithFormat:@"%@", value];
    }
    if ([key isEqualToString:@"flag"]) {
        self.flag = [value integerValue];
    }
    
}

@end
