//
//  DiscountLIstCollectionViewCell.h
//  YouWoYou
//
//  Created by dlios on 15-3-26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//
@class DiscountList_Property;
#import <UIKit/UIKit.h>

@interface DiscountLIstCollectionViewCell : UICollectionViewCell
@property (nonatomic , retain)UIImageView *imgView;
@property (nonatomic ,retain)UILabel *title_label;
@property (nonatomic ,retain)UILabel *price_label;
@property (nonatomic ,retain)UILabel *end_date_label;
@property (nonatomic ,retain)UILabel *lastminute_des;
@property(nonatomic , retain)DiscountList_Property *DCL;
- (void)setDCL:(DiscountList_Property *)DCL;
@end
