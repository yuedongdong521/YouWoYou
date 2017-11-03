//
//  CityCollect_CollectionViewCell.h
//  YouWoYou
//
//  Created by dlios on 15-3-30.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//
@class AllCityData;
#import <UIKit/UIKit.h>

@interface CityCollect_CollectionViewCell : UICollectionViewCell
@property (nonatomic , retain)UIImageView *imgView;
@property (nonatomic ,retain)UILabel *title_label;
@property(nonatomic ,retain)AllCityData *city;
- (void)setCity:(AllCityData *)city;
@end
