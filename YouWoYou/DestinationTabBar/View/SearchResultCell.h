//
//  SearchResultCell.h
//  YouWoYou
//
//  Created by dllo on 15/3/28.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchData.h"
#import "StarView.h"
@interface SearchResultCell : UITableViewCell

@property (nonatomic, retain)UIImageView *photo;
@property (nonatomic, retain)UILabel *cnname;
@property (nonatomic, retain)UILabel *enname;
@property (nonatomic, retain)StarView *star;
@property (nonatomic, retain)UILabel *beenstr;
@property (nonatomic, retain)UILabel *label;

@property (nonatomic, retain)SearchData *searchData;

@end
