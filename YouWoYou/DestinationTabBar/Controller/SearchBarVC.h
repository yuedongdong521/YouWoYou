//
//  SearchBarVC.h
//  UISearchBar2
//
//  Created by dllo on 15/3/21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchBarVC : UIViewController
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)UISearchBar *searchBar;
@property (nonatomic, retain)NSMutableArray *dataArr;
@property (nonatomic, retain)NSString *str;
@property (nonatomic, retain)UITableView *topSearch;

@end
