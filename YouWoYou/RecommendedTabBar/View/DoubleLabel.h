//
//  DoubleLabel.h
//  YouWoYou
//
//  Created by dlios on 15-3-25.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoubleLabel : UIView
@property(nonatomic ,retain)UILabel *rightLabel;
@property(nonatomic, retain)UILabel *leftLabel;
- (void)GiveFrame;
@end
