//
//  RFCollectionViewCell.h
//  YouWoYou
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//
@class RF_property;
#import <UIKit/UIKit.h>

@interface RFCollectionViewCell : UICollectionViewCell
@property (nonatomic , retain)UIImageView *imgView;
@property (nonatomic ,retain)UILabel *title_label;
@property (nonatomic ,retain)UILabel *subtitle_label;
@property(nonatomic ,retain)RF_property *RF;
- (void)setRF:(RF_property *)RF;
@end
