//
//  DiscountDetail_property.h
//  YouWoYou
//
//  Created by dlios on 15-3-26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscountDetail_property : NSObject
@property(nonatomic , retain)NSString *pic;
@property(nonatomic , retain)NSString *title;
@property(nonatomic , retain)NSString *detail;
@property(nonatomic , retain)NSString *price;
@property(nonatomic , retain)NSString *end_date;
@property(nonatomic , retain)NSString *use_if;
@property(nonatomic , retain)NSString *deal_info;
@property(nonatomic , retain)NSString *list_price;
- (instancetype)initinitWithDictionary:(NSDictionary *)dic;
@end
