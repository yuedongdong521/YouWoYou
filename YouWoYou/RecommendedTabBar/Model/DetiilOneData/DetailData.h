//
//  DetailData.h
//  YouWoYou
//
//  Created by dlios on 15-3-25.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailData : NSObject

// 传到下个页面
@property (nonatomic, retain) NSString *cateid;
@property (nonatomic, retain) NSString *cate_name;
@property (nonatomic, retain) NSString *lat;
@property (nonatomic, retain) NSString *lng;
@property (nonatomic, retain) NSString *idNumber;


@property (nonatomic, retain) NSString *planto;
@property (nonatomic, retain) NSString *beento;
@property (nonatomic, retain) NSString *firstname;
@property (nonatomic, retain) NSString *secnodname;
@property (nonatomic, retain) NSString *chinesename;
@property (nonatomic, retain) NSString *englishname;
@property (nonatomic, retain) NSString *localname;
@property (nonatomic, retain) NSString *beentocounts;
@property (nonatomic, retain) NSString *introduction;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *site;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *wayto;
@property (nonatomic, retain) NSString *opentime;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *tips;
@property (nonatomic, retain) NSString *updatetime;
@property (nonatomic, retain) NSString *duration;
@property (nonatomic, retain) NSString *img_count;
@property (nonatomic, retain) NSString *photo;
@property (nonatomic, retain) NSString *commentcounts;

@property (nonatomic, retain) NSString *recommendstr;
@property (nonatomic, retain) NSString *recommendscoresN;
@property (nonatomic, retain) NSArray *comment_list;

// NSNumber;
//@property (nonatomic, retain) NSString *mapstatus;
@property (nonatomic, retain) NSString *gradeN;
@property (nonatomic, retain) NSString *recommendnumberN;

- (instancetype)initWithDictionary:(NSDictionary *)dic;




@end
