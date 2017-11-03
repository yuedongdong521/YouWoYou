//
//  KitsTableViewCell.h
//  YouWoYou
//
//  Created by dlios on 15-3-24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "PoisModel.h"
#import "StarView.h"
@interface KitsTableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *back;
@property (nonatomic, retain) PoisModel *pois;
@property (nonatomic, retain) UIImageView *bigImage;
@property (nonatomic, retain) UILabel *chinesename;
@property (nonatomic, retain) UILabel *descriptionN;
@property (nonatomic, retain) StarView *stars;

@end
