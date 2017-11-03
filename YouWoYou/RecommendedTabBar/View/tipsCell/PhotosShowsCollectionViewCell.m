//
//  PhotosShowsCollectionViewCell.m
//  YouWoYou
//
//  Created by dlios on 15-3-29.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "PhotosShowsCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation PhotosShowsCollectionViewCell


- (void)dealloc
{
    [_imageUrl release];
    [_scroll release];
    [_image release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.scroll = [[UIScrollView alloc] init];
        [self.contentView addSubview:_scroll];
        self.scroll.delegate = self;
        self.scroll.bounces = NO;
//        self.scroll.maximumZoomScale = 2.0;
//        self.scroll.minimumZoomScale = 1.0;
        self.scroll.showsHorizontalScrollIndicator = NO;
        self.scroll.showsVerticalScrollIndicator = NO;
        self.scroll.contentSize = CGSizeMake(0, 0);
//        self.scroll.center = CGPointMake(self.contentView.frame.size.width / 2, self.contentView.frame.size.height / 2);

        [_scroll release];
       
        
        self.image = [[UIImageView alloc] init];
        [self.scroll addSubview:self.image];
        self.image.contentMode = UIViewContentModeScaleAspectFit;
        self.image.clipsToBounds = YES;
        [_image release];
        
    }
    return self;
}
- (void)action:(UITapGestureRecognizer *)tap
{
    self.scroll.zoomScale = 2.0;
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [self.scroll.subviews firstObject];
}
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
//    self.scroll.center = CGPointMake(self.contentView.frame.size.width / 2, self.contentView.frame.size.height / 2);
    self.scroll.frame = layoutAttributes.bounds;
      self.image.frame = CGRectMake(5, 5, layoutAttributes.bounds.size.width - 10, layoutAttributes.bounds.size.height - 10);
}

- (void)setImageUrl:(NSString *)imageUrl
{
    if (_imageUrl != imageUrl) {
        [_imageUrl release];
        _imageUrl = [imageUrl retain];
    }
    [self.image setImageWithURLStr:_imageUrl Photo:@"jiazaizhong.png"];
}

//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//{
//    return [scrollView.subviews firstObject];
//}

//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
//{
//    if (self.scroll.zoomScale < 0.8) {
//        self.scroll.zoomScale = 1;
//}
//}
//- (void)setMode:(PhotosCVCellMode)mode
//{
//    _mode = mode;
//    self.scroll.zoomScale = 1.0;
//    if (mode == PhotosCVCellModeMax) {
//        self.scroll.userInteractionEnabled = YES;
//        self.image.contentMode = UIViewContentModeScaleAspectFit;
//        self.contentView.backgroundColor = [UIColor blackColor];
//    } else {
//        self.scroll.userInteractionEnabled = NO;
//        self.image.contentMode = UIViewContentModeScaleAspectFill;
//        
//    }
//}


@end
