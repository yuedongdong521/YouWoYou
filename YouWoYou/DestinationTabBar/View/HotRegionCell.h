//
//  HotRegionCell.h
//  YouWoYou
//
//  Created by dllo on 15/3/23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Desitination_Data.h"

@interface HotRegionCell : UICollectionViewCell


@property (nonatomic, retain)UIImageView *backIV;

@property (nonatomic, retain)UIImageView *imageView;

@property (nonatomic, retain)UILabel *cityLabel;
@property (nonatomic, retain)UILabel *numLabel;
@property (nonatomic, retain)UILabel *countryLabel;
@property (nonatomic, retain)UILabel *ennameLabel;
@property (nonatomic, retain)UILabel *label;
@property (nonatomic, retain)UIImageView *imageV;
@property (nonatomic, retain)Desitination_Data *desit;

@end
