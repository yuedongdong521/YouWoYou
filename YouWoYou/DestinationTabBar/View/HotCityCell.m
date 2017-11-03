//
//  HotCityCell.m
//  YouWoYou
//
//  Created by dllo on 15/3/24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "HotCityCell.h"

#import "UIImageView+WebCache.h"

@implementation HotCityCell

- (void)dealloc
{
    [_imageView release];
    [_ennameLabel release];
    [_cnnameLabel release];
    [_country release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_imageView];
        [_imageView release];
        
        self.cnnameLabel = [[UILabel alloc] init];
        _cnnameLabel.backgroundColor = [UIColor clearColor];
        _cnnameLabel.textColor = [UIColor whiteColor];
        _cnnameLabel.font = [UIFont systemFontOfSize:12];
        [self.imageView addSubview:_cnnameLabel];
        [_cnnameLabel release];
        
        self.ennameLabel = [[UILabel alloc] init];
        _ennameLabel.backgroundColor = [UIColor clearColor];
        _ennameLabel.textColor = [UIColor whiteColor];
        _ennameLabel.font = [UIFont systemFontOfSize:12];
        [self.imageView addSubview:_ennameLabel];
        [_ennameLabel release];
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.imageView.frame = CGRectMake(1, 10, self.contentView.frame.size.width - 2, self.contentView.frame.size.height - 10);
    
    self.cnnameLabel.frame = CGRectMake(10, self.imageView.frame.size.height / 2, self.imageView.frame.size.width - 20, self.imageView.frame.size.height / 4);
    
    self.ennameLabel.frame = CGRectMake(10, self.imageView.frame.size.height / 4 * 3, self.imageView.frame.size.width - 20, self.imageView.frame.size.height / 4);
}

- (void)setCountry:(CountryData *)country
{
    if (_country != country) {
        [_country release];
        _country = [country retain];
    }
    
    NSString *str = self.country.photo;
    [self.imageView setImageWithURLStr:str Photo:@"jiazaizhong.png"];
    
    self.cnnameLabel.text = self.country.cnname;
    self.ennameLabel.text = self.country.enname;
}


@end
