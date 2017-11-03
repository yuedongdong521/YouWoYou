//
//  DetailData.m
//  YouWoYou
//
//  Created by dlios on 15-3-25.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "DetailData.h"

@implementation DetailData


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
    if ([key isEqualToString:@"grade"]) {
        self.gradeN = [NSString stringWithFormat:@"%@", value];
    }
    if ([key isEqualToString:@"recommendnumber"]) {
        self.recommendnumberN = [NSString stringWithFormat:@"%@", value];
    }
    if ([key isEqualToString:@"recommendscores"]) {
        self.recommendscoresN = [NSString stringWithFormat:@"%@", value];
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
    [_cateid release];
    [_cate_name release];
    [_lat release];
    [_lng release];
    [_idNumber release];
    [_planto release];
    [_beento release];
    [_firstname release];
    [_secnodname release];
    [_chinesename release];
    [_englishname release];
    [_localname release];
    [_beentocounts release];
    [_introduction release];
    [_address release];
    [_site release];
    [_phone release];
    [_wayto release];
    [_opentime release];
    [_price release];
    [_tips release];
    [_updatetime release];
    [_duration release];
    [_img_count release];
    [_photo release];
    [_commentcounts release];
    [_recommendstr release];
    [_recommendscoresN release];
    [_comment_list release];
    
    // NSNumber;
    //@property (nonatomic, retain) NSString *mapstatus;
    [_gradeN release];
    [_recommendnumberN release];
    [super dealloc];
}

@end
