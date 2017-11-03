//
//  SlideModel.m
//  YouWoYou
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "SlideModel.h"

@implementation SlideModel

- (void)dealloc
{
    [_photo release];
    [super dealloc];
}

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.photo = [dic objectForKey:@"photo"];
 
    }
    return self;
}

@end
