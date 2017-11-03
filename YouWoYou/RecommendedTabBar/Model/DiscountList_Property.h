//
//  DiscountList_Property.h
//  YouWoYou
//
//  Created by dlios on 15-3-26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscountList_Property : NSObject
@property(nonatomic , retain)NSString *id_Discount;
@property(nonatomic , retain)NSString *pic;
@property(nonatomic , retain)NSString *title;
@property(nonatomic , retain)NSString *buy_price;
@property(nonatomic , retain)NSString *end_date;
@property(nonatomic , retain)NSString *lastminute_des;
@property(nonatomic , retain)NSString *price;
- (instancetype)initinitWithDictionary:(NSDictionary *)dic;
@end
