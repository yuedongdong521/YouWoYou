//
//  SlideModel.h
//  YouWoYou
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SlideModel : NSObject

@property (nonatomic, retain) NSString * photo;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
