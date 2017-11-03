//
//  Country_Info_ViewController.h
//  YouWoYou
//
//  Created by dllo on 15/3/24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Desitination_Data.h"

@interface Country_Info_ViewController : UIViewController

@property (nonatomic, retain)UIScrollView *scrollView;
@property (nonatomic, retain)UIScrollView *imageScroll;

@property (nonatomic, retain)UIImageView *imageView;
@property (nonatomic, retain)UILabel *cnnameLabel;


@property (nonatomic, retain)UICollectionView *hotCollectionView;

@property (nonatomic, retain)UITableView *disTableView;

@property (nonatomic, retain)NSString *country_id;

@end
