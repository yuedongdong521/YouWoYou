//
//  PhotosShowsCollectionViewCell.h
//  YouWoYou
//
//  Created by dlios on 15-3-29.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef enum : NSUInteger {
//    PhotosCVCellModeMin,
//    PhotosCVCellModeMax,
//} PhotosCVCellMode;
//@class Photo;

@interface PhotosShowsCollectionViewCell : UICollectionViewCell <UIScrollViewDelegate>

@property (nonatomic, retain) UIScrollView *scroll;
@property (nonatomic, retain) UIImageView *image;
@property (nonatomic, retain) NSString *imageUrl;
//@property (nonatomic, assign) PhotosCVCellMode mode;
@end
