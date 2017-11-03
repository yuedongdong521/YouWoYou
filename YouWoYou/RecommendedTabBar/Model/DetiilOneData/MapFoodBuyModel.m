//
//  MapFoodBuyModel.m
//  YouWoYou
//
//  Created by dlios on 15-3-26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "MapFoodBuyModel.h"

@implementation MapFoodBuyModel


- (void)dealloc
{
    
    
    [_englishname release];
    [_beenstr release];
    [_idNumber release];
    [_firstname release];
    [_lat release];
    [_lon release];
    [_gradeN release];
    [_photo release];
    [super dealloc];
}

- (instancetype)initWithDiction:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"grade"]) {
        self.gradeN = [NSString stringWithFormat:@"%@", value];
    }
    if ([key isEqualToString:@"id"]) {
        self.idNumber = value;
    }
    
}
- (id)valueForUndefinedKey:(NSString *)key
{
    return key;
}

@end
