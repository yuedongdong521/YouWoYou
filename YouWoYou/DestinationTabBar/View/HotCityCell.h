//
//  HotCityCell.h
//  YouWoYou
//
//  Created by dllo on 15/3/24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryData.h"

@interface HotCityCell : UICollectionViewCell

@property (nonatomic, retain)UIImageView *imageView;
@property (nonatomic, retain)UILabel *cnnameLabel;
@property (nonatomic, retain)UILabel *ennameLabel;

@property (nonatomic, retain)CountryData *country;


@end
