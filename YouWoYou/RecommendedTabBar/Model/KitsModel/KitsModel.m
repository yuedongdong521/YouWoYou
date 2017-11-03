//
//  KitsModel.m
//  YouWoYou
//
//  Created by dlios on 15-3-24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "KitsModel.h"

@implementation KitsModel

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
    if ([key isEqualToString:@"title"]) {
        self.titleL = value;
    }
    
    if ([key isEqualToString:@"count"]) {
        self.countN = [NSString stringWithFormat:@"%@", value];
    }
    if ([key isEqualToString:@"description"]) {
        self.descriptionN = value;
    }
}
- (id)valueForUndefinedKey:(NSString *)key
{
    return key;
}

- (void)dealloc
{
    [_titleL release];
    [_avatar release];
    [_descriptionN release];
    [_countN release];
    [_pois release];
    [_username release];
    [_photo release];
    [super dealloc];
}

@end
