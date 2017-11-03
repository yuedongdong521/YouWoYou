//
//  SearchData.h
//  YouWoYou
//
//  Created by dllo on 15/3/28.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchData : NSObject


@property (nonatomic, retain)NSString *number_id; // NSNumber
@property (nonatomic, retain)NSString *cnname;
@property (nonatomic, retain)NSString *enname;
@property (nonatomic, retain)NSString *photo;

@property (nonatomic, retain)NSString *label;
@property (nonatomic, retain)NSString *parentid; // NSNumber
@property (nonatomic, retain)NSString *parentname;
@property (nonatomic, retain)NSString *parent_parentname;
@property (nonatomic, retain)NSString *beennumber;
@property (nonatomic, retain)NSString *beenstr;
@property (nonatomic, retain)NSString *has_mguide;
@property (nonatomic, retain)NSString *gradeN; // NSNumber
@property (nonatomic, retain)NSString *type; // NSNumber

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
