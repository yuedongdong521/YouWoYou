//
//  KitsModel.h
//  YouWoYou
//
//  Created by dlios on 15-3-24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KitsModel : NSObject

@property (nonatomic, retain) NSString *photo;
@property (nonatomic, retain) NSString *titleL;
@property (nonatomic, retain) NSString *avatar;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *descriptionN;
@property (nonatomic, retain) NSString *countN;
@property (nonatomic, retain) NSArray *pois;

- (instancetype)initWithDictionary:(NSDictionary *)dic;


@end
