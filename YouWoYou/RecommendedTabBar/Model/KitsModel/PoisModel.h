//
//  PoisModel.h
//  YouWoYou
//
//  Created by dlios on 15-3-24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PoisModel : NSObject

@property (nonatomic, retain) NSString *idNumber;
@property (nonatomic, retain) NSString *photo;
@property (nonatomic, retain) NSString *chinesename;
@property (nonatomic, retain) NSString *firstname;
@property (nonatomic, retain) NSString *recommandstarN;
@property (nonatomic, retain) NSString *descriptionN;
@property (nonatomic, retain) NSString *lat;
@property (nonatomic, retain) NSString *lng;
@property (nonatomic, retain) NSString *countryname;
@property (nonatomic, retain) NSString *cityname;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
