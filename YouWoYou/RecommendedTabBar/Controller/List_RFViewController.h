//
//  List_RFViewController.h
//  YouWoYou
//
//  Created by dlios on 15-3-24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//
@class RF_property;
#import <UIKit/UIKit.h>

@interface List_RFViewController : UIViewController
@property(nonatomic ,retain)NSString *mtid;
@property(nonatomic ,retain)NSString *issue;
@property(nonatomic, retain)NSString *name;
@property(nonatomic ,retain)RF_property *RF;
@property(nonatomic ,retain)UITableView *tableView;
@end
