//
//  AllMegideData.m
//  YouWoYou
//
//  Created by dllo on 15/3/27.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "AllMegideData.h"

@implementation AllMegideData

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
    if ([key isEqualToString:@"description"]) {
        self.descrip = value;
    }
    if ([key isEqualToString:@"id"]) {
        self.megideID = value;
    }
}

- (void)dealloc
{
    [_megideID release];
    [_photo release];
    [_title release];
    [_username release];
    [_user_id release];
    [_avatar release];
    [_descrip release];
    [_count release];
    [super dealloc];
}

@end
