//
//  PhotoCollectionViewCell.m
//  YouWoYou
//
//  Created by dlios on 15-3-28.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation PhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [[UIImageView alloc] init];
        self.image.contentMode = UIViewContentModeScaleAspectFill ;
        self.image.clipsToBounds = YES;
        [self.contentView addSubview:self.image];
        [_image release];
        
    }
    return self;
}
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.image.frame = self.contentView.bounds;

}

- (void)setUrlImage:(NSString *)urlImage
{
    if (_urlImage != urlImage) {
        [_urlImage release];
        _urlImage = [urlImage retain];
    }
    [self.image setImageWithURLStr:self.urlImage Photo:@"jiazaizhong.png"];


}

- (void)dealloc
{
    [_urlImage release];
    [_image release];
    [super dealloc];
}
@end
