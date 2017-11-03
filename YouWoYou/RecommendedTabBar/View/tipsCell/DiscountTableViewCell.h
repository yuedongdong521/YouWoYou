//
//  DiscountTableViewCell.h
//  YouWoYou
//
//  Created by dlios on 15-3-24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscountModel.h"

@interface DiscountTableViewCell : UITableViewCell

@property (nonatomic, retain) DiscountModel *discount;

@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UILabel *price;
@property (nonatomic, retain) UILabel *end_data;
@property (nonatomic, retain) UILabel *priceoff;
@property (nonatomic, retain) UIImageView *photo;

@end
