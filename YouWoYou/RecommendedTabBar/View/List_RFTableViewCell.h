//
//  List_RFTableViewCell.h
//  YouWoYou
//
//  Created by dlios on 15-3-24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//
@class  RF_property;
#import <UIKit/UIKit.h>

@interface List_RFTableViewCell : UITableViewCell
@property (nonatomic , retain)UIImageView *imgView;
@property (nonatomic ,retain)UILabel *title_label;
@property (nonatomic ,retain)UILabel  *desc_label;
@property(nonatomic ,retain)RF_property *RF;
- (void)setRF:(RF_property *)RF;
@end
