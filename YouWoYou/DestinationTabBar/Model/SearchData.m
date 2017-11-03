//
//  SearchData.m
//  YouWoYou
//
//  Created by dllo on 15/3/28.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "SearchData.h"

@implementation SearchData

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
        self.number_id = value;
    }
    if ( [key isEqualToString:@"grade"]) {
        self.gradeN = [NSString stringWithFormat:@"%@",value];
    }
    
}

- (void)dealloc
{
    [_number_id release];
    [_cnname release];
    [_enname release];
    [_photo release];
    [_label release];
    [_parentid release];
    [_parent_parentname release];
    [_parentname release];
    [_has_mguide release];
    [_beennumber release];
    [_beenstr release];
    [_gradeN release];
    [_type release];
    [super dealloc];
}


@end
