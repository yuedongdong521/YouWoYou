//
//  AllMegideData.h
//  YouWoYou
//
//  Created by dllo on 15/3/27.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllMegideData : NSObject

@property (nonatomic, retain)NSString *megideID;
@property (nonatomic, retain)NSString *photo;
@property (nonatomic, retain)NSString *title;
@property (nonatomic, retain)NSString *user_id;
@property (nonatomic, retain)NSString *username;
@property (nonatomic, retain)NSString *avatar;
@property (nonatomic, retain)NSString *descrip;
@property (nonatomic, retain)NSString *count;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
