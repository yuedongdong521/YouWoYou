//
//  Image_RFCollectionViewCell.m
//  YouWoYou
//
//  Created by dlios on 15-3-24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "Image_RFCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation Image_RFCollectionViewCell
- (void)dealloc
{
    [_imgStr release];
    [_imgView release];
    [super dealloc ];
  
}
-(instancetype)initWithFrame:(CGRect)frame
{
    
    
    self = [super initWithFrame:frame];
    if (self) {
        self.imgView = [[UIImageView alloc]init];
        [self.contentView addSubview: self.imgView ];
        self.imgView.backgroundColor = [UIColor whiteColor];
        [self.imgView release];
    }
    
    return  self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    
    
    self.imgView.frame = self.contentView.bounds;
    
}

- (void)setImgStr:(NSString *)imgStr
{
    if (_imgStr != imgStr ) {
        [_imgStr release];
        _imgStr = [imgStr retain];
    }
    [self.imgView setImageWithURLStr:self.imgStr Photo:@"jiazaizhong.png"];
    
    
}


@end
