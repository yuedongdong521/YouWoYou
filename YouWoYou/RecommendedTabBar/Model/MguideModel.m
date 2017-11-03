//
//  MguideModel.m
//  YouWoYou
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "MguideModel.h"

@implementation MguideModel

- (instancetype)initWithDictonary:(NSDictionary *)dic
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
        self.descriptionW = value;
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
    [_photo release];
    [_title release];
    [_user_id release];
    [_username release];
    [_avatar release];
    [_count release];
    [_descriptionW release];
    [super dealloc];

}



@end
