//
//  AllMgideCell.h
//  YouWoYou
//
//  Created by dllo on 15/3/26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllMegideData.h"

@interface AllMgideCell : UITableViewCell

@property (nonatomic, retain)UIImageView *backImage;
@property (nonatomic, retain)UIImageView *photo;
@property (nonatomic, retain)UIImageView *avatar;
@property (nonatomic, retain)UILabel *title;
@property (nonatomic, retain)UILabel *username;
@property (nonatomic, retain)UILabel *descrip;
@property (nonatomic, retain)UILabel *count;
@property (nonatomic, retain)AllMegideData *megide;

@end
