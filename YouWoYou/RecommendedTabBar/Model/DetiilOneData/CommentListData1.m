//
//  CommentListData1.m
//  YouWoYou
//
//  Created by dlios on 15-3-26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "CommentListData1.h"

@implementation CommentListData1

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
    if ([key isEqualToString:@"user"]) {
        self.username = [value valueForKey:@"username"];
        self.avatar = [value valueForKey:@"avatar"];
    }
    if ([key isEqualToString:@"id"]) {
        self.idNumber = value;
    }
}
- (id)valueForUndefinedKey:(NSString *)key
{
    return key;
}

- (void)dealloc
{
    [_idNumber release];
    [_avatar release];
    [_username release];
    [_star release];
    [_comment release];
    [_datetime release];
    [super dealloc];
}

@end
