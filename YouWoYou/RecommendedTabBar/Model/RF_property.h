//
//  RF_property.h
//  YouWoYou
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RF_property : NSObject
//推荐页
@property(nonatomic , retain)NSString *mtid;
@property(nonatomic , retain)NSString *name;
@property(nonatomic , retain)NSString *desc;
@property(nonatomic , retain)NSString *img;
//列表页属性
@property(nonatomic , retain)NSString *id_list;
@property(nonatomic , retain)NSString *title;
@property(nonatomic , retain)NSString *code;
@property(nonatomic , retain)NSString *issue;

//详情页面
@property(nonatomic , retain)NSString *opentime;
@property(nonatomic , retain)NSString *type;
@property(nonatomic , retain)NSString *traffic;
@property(nonatomic , retain)NSString *telephone;
@property(nonatomic , retain)NSString *address;
@property(nonatomic , retain)NSMutableArray *ptags;
@property(nonatomic , retain)NSMutableArray *ext;
@property(nonatomic , retain)NSMutableArray *impress;
@property(nonatomic , retain)NSMutableArray *pic;
- (instancetype)initinitWithDictionary:(NSDictionary *)dic;
@end
