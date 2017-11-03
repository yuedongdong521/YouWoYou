//
//  AllDiscountCell.m
//  YouWoYou
//
//  Created by dllo on 15/3/28.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "AllDiscountCell.h"

#import "UIImageView+WebCache.h"

@implementation AllDiscountCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backImage = [[UIImageView alloc] init];
        self.backImage.layer.masksToBounds = YES;
        self.backImage.layer.cornerRadius = 10;
        [self.contentView addSubview:_backImage];
        [_backImage release];
        
        self.photo = [[UIImageView alloc] init];
        [self.backImage addSubview:_photo];
        [_photo release];
        
        self.infoLabel = [[UILabel alloc] init];
        self.infoLabel.numberOfLines = 0;
        [self.backImage addSubview:_infoLabel];
        [_infoLabel release];
        
        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.textColor = [UIColor redColor];
        [self.backImage addSubview:_priceLabel];
        [_priceLabel release];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = [UIFont systemFontOfSize:10];
        [self.backImage addSubview:_timeLabel];
        [_timeLabel release];
        
        self.discountLabel = [[UILabel alloc] init];
        self.discountLabel.textColor = [UIColor redColor];
        self.discountLabel.font = [UIFont systemFontOfSize:12];
        [self.backImage addSubview:_discountLabel];
        [_discountLabel release];
        
    }
    
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.backImage.frame = layoutAttributes.bounds;
    CGFloat width = self.backImage.frame.size.width;
    CGFloat height = self.backImage.frame.size.height;
    self.photo.frame = CGRectMake(0, 0, width, height / 2);
    self.infoLabel.frame = CGRectMake(10, height / 2, width - 20, height / 4);
    self.priceLabel.frame = CGRectMake(10, height / 4 * 3, width / 3 * 2, height / 8);
    self.timeLabel.frame = CGRectMake(10, height / 8 * 7 - 5, width - 20, height / 8);
    self.discountLabel.frame = CGRectMake(width / 3 * 2, height / 4 * 3, width / 3 - 10, height / 8);
    
    
}

- (void)setDiscountData:(CountryData *)discountData
{
    if (_discountData != discountData) {
        [_discountData release];
        _discountData = [discountData retain];
    }
    self.backImage.image = [UIImage imageNamed:@"cell.png"];
    [self.photo setImageWithURLStr:self.discountData.photo Photo:@"jiazaizhong.png"];
    self.infoLabel.text = self.discountData.title;
    self.priceLabel.text = self.discountData.priceStr;
    self.timeLabel.text = self.discountData.expire_date;
    self.discountLabel.text = self.discountData.priceoff;
}

- (void)dealloc
{
    [_backImage release];
    [_photo release];
    [_infoLabel release];
    [_priceLabel release];
    [_timeLabel release];
    [_discountLabel release];
    [_discountData release];
    [super dealloc];
}

@end
