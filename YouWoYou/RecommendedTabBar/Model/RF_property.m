//
//  RF_property.m
//  YouWoYou
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "RF_property.h"

@implementation RF_property
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.id_list = value;
    }else if([key isEqualToString:@"description"])
    {
        self.desc = value;
        
    }
    
}

- (instancetype)initinitWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
      [self setValuesForKeysWithDictionary:dic];
    }
     return self;
}

- (void)dealloc
{
    [_opentime release];
    [_type release];
    [_traffic release];
    [_telephone release];
    [_address release];
    [_ptags release];
    [_ext release];
    [_impress release];
    [_pic release];
    [_issue release];
    [_id_list release];
    [_title release];
    [_code release];
    [_mtid release];
    [_name release];
    [_img release];
    [_desc release];
    [super dealloc];
    
}
@end
