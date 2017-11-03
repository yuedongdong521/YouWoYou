//
//  Comment_listData.m
//  YouWoYou
//
//  Created by dlios on 15-3-26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "Comment_listData.h"

@implementation Comment_listData
- (instancetype)initWithDictiony:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (id)valueForUndefinedKey:(NSString *)key
{
    return key;
}
- (void)dealloc
{
    [_star release];
    [_comment release];
    [_datetime release];
    [_username release];
    [_avatar release];
    [super dealloc];
}

@end

