//
//  Discount_List_RFViewController.h
//  YouWoYou
//
//  Created by dlios on 15-3-26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//
@class DiscountList_Property;
#import <UIKit/UIKit.h>

@interface Discount_List_RFViewController : UIViewController
@property(nonatomic ,retain)UICollectionView *collectionView;
@property(nonatomic ,retain)DiscountList_Property *discount;
@property(nonatomic ,retain)NSMutableArray *arr;
@property(nonatomic , retain)NSString *num_id;
@property(nonatomic , retain)NSString *product_type;
@property(nonatomic , retain)NSString *continent_id;
@property(nonatomic , retain)NSString *country_id;
@property(nonatomic , retain)NSString *departure;
@property (nonatomic , retain)NSString *times;
@property(nonatomic , retain)UITableView *tableView_type;
@property(nonatomic , retain)UITableView *tableView_times;
@property(nonatomic , retain)UITableView *tableView_departure;
@property(nonatomic , retain)UITableView *tableView_left;
@property(nonatomic , retain)UITableView *tableView_right;
@property(nonatomic  , retain)NSMutableArray *arr_screen;
@property(nonatomic , retain)NSMutableArray *arr_country;
@property(nonatomic  , retain)NSMutableArray *arr_type;
@property(nonatomic  , retain)NSMutableArray *arr_poi;
@property(nonatomic  , retain)NSMutableArray *arr_times_drange;
@property(nonatomic  , retain)NSMutableArray *arr_departure;
@property(nonatomic , retain) UISegmentedControl *seg;
@property(nonatomic , assign)BOOL flag_netWork;
@property(nonatomic ,retain )UILabel *label;


@property(nonatomic, assign)BOOL flag;
@end
