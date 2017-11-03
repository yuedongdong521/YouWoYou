//
//  NetWorkHandle.h
//  YouWoYou
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NetWorkHandle : NSObject


+ (void)getDataWithUrl:(NSString *)str completion:(void(^)(NSData *data))block;
+ (void)postDataWithUrl:(NSString *)str completion:(void(^)(NSData *data))block;

@end
