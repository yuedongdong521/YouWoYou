//
//  MoreCityCell.h
//  YouWoYou
//
//  Created by dllo on 15/3/26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllCityData.h"

@interface MoreCityCell : UICollectionViewCell

@property (nonatomic, retain) UIImageView *imageBack;

@property (nonatomic, retain) UIImageView *photo;

@property (nonatomic, retain) UILabel *enname;
@property (nonatomic, retain) UILabel *cnname;
@property (nonatomic, retain) UILabel *count;
@property (nonatomic, retain) UILabel *represent;
@property (nonatomic, retain) UILabel *labeL;
@property (nonatomic, retain) AllCityData *city;
@end
