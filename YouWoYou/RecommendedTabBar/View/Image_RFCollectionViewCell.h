//
//  Image_RFCollectionViewCell.h
//  YouWoYou
//
//  Created by dlios on 15-3-24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Image_RFCollectionViewCell : UICollectionViewCell
@property(nonatomic, retain)UIImageView *imgView;
@property(nonatomic ,retain)NSString *imgStr;
- (void)setImgStr:(NSString *)imgStr;
@end
