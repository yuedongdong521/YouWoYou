//
//  MapFoodBuyModel.h
//  YouWoYou
//
//  Created by dlios on 15-3-26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapFoodBuyModel : NSObject

@property (nonatomic, retain) NSString *idNumber;
@property (nonatomic, retain) NSString *firstname;
@property (nonatomic, retain) NSString *englishname;

@property (nonatomic, retain) NSString *lat;
@property (nonatomic, retain) NSString *lon;

@property (nonatomic, retain) NSString *photo;
@property (nonatomic, retain) NSString *beenstr;
@property (nonatomic, retain) NSString *gradeN;

- (instancetype)initWithDiction:(NSDictionary *)dic;
@end
