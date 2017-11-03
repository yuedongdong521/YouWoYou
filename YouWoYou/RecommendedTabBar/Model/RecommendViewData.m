//
//  RecommendViewData.m
//  YouWoYou
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "RecommendViewData.h"

@implementation RecommendViewData



- (void)dealloc
{
    [_mguide release];
    [_slide release];
    [_s release];
    [_discount release];
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
    if ([key isEqualToString:@"search"]) {
        self.s = value;
    }
    
}
- (id)valueForUndefinedKey:(NSString *)key
{
    return key;
}

@end
