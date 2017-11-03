//
//  travelCell.h
//  YouWoYou
//
//  Created by dllo on 15/3/31.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelData.h"

@interface TravelTableViewCell : UITableViewCell

@property (nonatomic, retain)UIImageView *backImage;

@property (nonatomic, retain)UIImageView *photo;

@property (nonatomic, retain)UILabel *subject;

@property (nonatomic, retain)UILabel *route;

@property (nonatomic, retain)UILabel *day_count;

@property (nonatomic, retain)TravelData *data;

@end
