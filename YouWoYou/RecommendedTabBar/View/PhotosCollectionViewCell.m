//
//  PhotosCollectionViewCell.m
//  YouWoYou
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "PhotosCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation PhotosCollectionViewCell
- (void)dealloc
{
    [_image release];
    [_slide release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [[UIImageView alloc] init];
        [self.contentView addSubview:_image];
        self.image.backgroundColor = [UIColor whiteColor];
        _image.backgroundColor = [UIColor whiteColor];
        [_image release];
  
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.image.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.frame.size.height);
}


- (void)setSlide:(SlideModel *)slide
{
    if (_slide != slide) {
        [_slide release];
        _slide = [slide retain];
    }
   
//    [_image setImageWithURLStr:self.slide.photo ];
    [_image setImageWithURLStr:self.slide.photo Photo:@"loading.jpg"];

}




@end
