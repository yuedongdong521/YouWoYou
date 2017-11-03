//
//  PhotosShowsViewController.h
//  YouWoYou
//
//  Created by dlios on 15-3-28.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosShowsViewController : UIViewController

@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, retain) NSString  *titleL;
@property (nonatomic, retain) NSString *idNumber;
@property (nonatomic, retain) NSIndexPath *indexPath;
@end
