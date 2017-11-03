//
//  PoisModel.m
//  YouWoYou
//
//  Created by dlios on 15-3-24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "PoisModel.h"

@implementation PoisModel

- (void)dealloc
{
    [_idNumber release];
    [_photo release];
    [_chinesename release];
    [_descriptionN release];
    [_recommandstarN release];
    [_firstname release];
    [_lat release];
    [_lng release];
    [_countryname release];
    [_cityname release];
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
    if ([key isEqualToString:@"description"]) {
        self.descriptionN = value;
    }
    if ([key isEqualToString:@"recommandstar"]) {
        self.recommandstarN = [NSString stringWithFormat:@"%@",value];
    }
}
- (id)valueForUndefinedKey:(NSString *)key
{
    return key;
}

@end
