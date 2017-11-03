 //
//  DiscountModel.h
//  YouWoYou
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscountModel : NSObject

@property (nonatomic, retain) NSString *idNumber;
@property (nonatomic, retain) NSString *photo;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *end_date;
@property (nonatomic, retain) NSString *priceoff;
@property (nonatomic, retain) NSString *title;
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
