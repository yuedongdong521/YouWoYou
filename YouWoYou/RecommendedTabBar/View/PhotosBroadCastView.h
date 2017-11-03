//
//  PhotosBroadCastView.h
//  YouWoYou
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideModel.h"

@interface PhotosBroadCastView : UIView

@property (nonatomic, retain) NSArray *photoArr;
@property (nonatomic, retain) UICollectionView *collection;
- (void)addtimer;
- (void)time;
@end
