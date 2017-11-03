//
//  MgideCell.h
//  YouWoYou
//
//  Created by dllo on 15/3/25.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CountryData.h"

@interface MgideCell : UITableViewCell

@property (nonatomic, retain)UIImageView *imageV;

@property (nonatomic, retain)UIImageView *photo;
@property (nonatomic, retain)UILabel *title;
@property (nonatomic, retain)UILabel *username;
@property (nonatomic, retain)UIImageView *avatar;

@property (nonatomic, retain)CountryData *country;

@end
