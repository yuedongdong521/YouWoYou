//
//  Detail_RFViewController.h
//  YouWoYou
//
//  Created by dlios on 15-3-24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//
@class RF_property,DoubleLabel;
#import <UIKit/UIKit.h>

@interface Detail_RFViewController : UIViewController
@property(nonatomic , retain)NSString *code;
@property(nonatomic, retain)UIScrollView *scrollView;
@property(nonatomic ,retain)RF_property *RF;
@property(nonatomic ,retain)UICollectionView *collectionView;
@property(nonatomic ,retain)NSMutableArray *arr;
@property (nonatomic, retain) NSTimer *timer;
@property(nonatomic ,retain)UILabel *desc_Label;
@property(nonatomic ,retain)UICollectionView *collectionView_pic;
@property(nonatomic ,retain)NSMutableArray *arr_pic;
@property(nonatomic, assign)BOOL flag;
@property(nonatomic, retain)UIScrollView *BigscrollView;
@property(nonatomic ,retain)DoubleLabel *tag_doubleLabel;
@property(nonatomic ,retain)NSMutableArray *arr_tag;
@property(nonatomic ,assign)CGRect rect;
@property(nonatomic , retain)DoubleLabel *address_doubleLabel;
@property(nonatomic , retain)DoubleLabel *type_doubleLabel;
@property(nonatomic , retain)DoubleLabel *opentime_doubleLabel;
@property(nonatomic , retain)UITableView *tableView;
@end
