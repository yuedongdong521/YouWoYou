//
//  MapFoodBuyTableViewCell.h
//  YouWoYou
//
//  Created by dlios on 15-3-26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapFoodBuyModel.h"
#import "StarView.h"

@interface MapFoodBuyTableViewCell : UITableViewCell

@property (nonatomic, retain) MapFoodBuyModel *mfb;
@property (nonatomic, retain) UIImageView *backImage;
@property (nonatomic, retain) UILabel *firstName;
@property (nonatomic, retain) UILabel *secondName;
@property (nonatomic, retain) StarView *star;
@property (nonatomic, retain) UILabel *bentoStr;
@end
