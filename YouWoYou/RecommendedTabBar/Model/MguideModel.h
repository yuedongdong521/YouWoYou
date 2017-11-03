//
//  MguideModel.h
//  YouWoYou
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MguideModel : NSObject



@property (nonatomic, retain) NSString *idNumber;
@property (nonatomic, retain) NSString *photo;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *user_id;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *avatar;
@property (nonatomic, retain) NSString *count;
@property (nonatomic, retain) NSString *descriptionW;

- (instancetype)initWithDictonary:(NSDictionary *)dic;

@end
