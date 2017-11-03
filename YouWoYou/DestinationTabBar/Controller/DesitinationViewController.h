//
//  DesitinationViewController.h
//  YouWoYou
//
//  Created by dlios on 15-3-22.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DesitinationViewController : UIViewController

@property (nonatomic, retain)UIScrollView *scrollView;

@property (nonatomic, retain)UISegmentedControl *seg;

// 七大洲数组
@property (nonatomic, retain)NSArray *chauArr;

@property (nonatomic, retain)UICollectionView *hotView;

@property (nonatomic, retain)UICollectionView *otherView;

@end
