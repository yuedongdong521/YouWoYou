//
//  Comment_listData.h
//  YouWoYou
//
//  Created by dlios on 15-3-26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment_listData : NSObject

@property (nonatomic, retain) NSString *star;
@property (nonatomic, retain) NSString *comment;
@property (nonatomic, retain) NSString *datetime;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *avatar;

- (instancetype)initWithDictiony:(NSDictionary *)dic;



@end
