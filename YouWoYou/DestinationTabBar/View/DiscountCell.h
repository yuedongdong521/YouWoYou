//
//  DiscountCell.h
//  YouWoYou
//
//  Created by dllo on 15/3/24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CountryData.h"

@interface DiscountCell : UITableViewCell

@property (nonatomic, retain)UIImageView *backImage;

@property (nonatomic, retain)UIImageView *photo;

@property (nonatomic, retain)UILabel *infoLabel;

@property (nonatomic, retain)UILabel *priceLabel;

@property (nonatomic, retain)UILabel *timeLabel;

@property (nonatomic, retain)UILabel *discountLabel;

@property (nonatomic, retain)CountryData *country;

@end
