//
//  Detail_RFTableViewCell.h
//  YouWoYou
//
//  Created by dlios on 15-3-25.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//
@class DoubleLabel;
#import <UIKit/UIKit.h>

@interface Detail_RFTableViewCell : UITableViewCell
@property (nonatomic ,retain)DoubleLabel *doubleLabel;
@property(nonatomic ,retain)NSString * name;
@property (nonatomic, retain)NSString * content;
- (void)setName:(NSString *)name;
- (void)setContent:(NSString *)content;

@end
