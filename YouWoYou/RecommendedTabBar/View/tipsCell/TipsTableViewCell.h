//
//  TipsTableViewCell.h
//  YouWoYou
//
//  Created by dlios on 15-3-24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MguideModel.h"

@interface TipsTableViewCell : UITableViewCell

@property (nonatomic, retain) MguideModel *mguide;
@property (nonatomic, retain) UIImageView *photo;
@property (nonatomic, retain) UIImageView *avatar;
@property (nonatomic, retain) UILabel *username;
@property (nonatomic, retain) UILabel *title;

@end
