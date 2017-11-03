//
//  HotRegionCell.m
//  YouWoYou
//
//  Created by dllo on 15/3/23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "HotRegionCell.h"
#import "UILabel+Init.h"
#import "UIImageView+WebCache.h"

@implementation HotRegionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backIV = [[UIImageView alloc] init];
        [self.contentView addSubview:self.backIV];
        [_backIV release];
        
        self.imageView = [[UIImageView alloc] init];
        self.imageView.backgroundColor = [UIColor whiteColor];
        [self.backIV addSubview:self.imageView];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        [_imageView release];
        
        
        self.imageV = [[UIImageView alloc] init];
        self.imageV.alpha = 0.6;
        [self.imageView addSubview:self.imageV];
        [_imageV release];
        
        self.numLabel = [UILabel labelWithColor:[UIColor clearColor] alignment:NSTextAlignmentCenter alpha:1];
        self.numLabel.textColor = [UIColor whiteColor];
        self.numLabel.font = [UIFont systemFontOfSize:12];
        [self.backIV addSubview:self.numLabel];
        [_numLabel release];
        
        self.cityLabel = [UILabel labelWithColor:[UIColor clearColor] alignment:NSTextAlignmentCenter alpha:1];
        self.cityLabel.textColor = [UIColor whiteColor];
        self.cityLabel.font = [UIFont boldSystemFontOfSize:10];
        [self.backIV addSubview:self.cityLabel];
        [_cityLabel release];
        
        
        self.countryLabel = [UILabel labelWithColor:[UIColor clearColor] alignment:NSTextAlignmentLeft alpha:1];
        self.countryLabel.font = [UIFont systemFontOfSize:15];
        [self.backIV addSubview:self.countryLabel];
        [_countryLabel release];
        
        self.ennameLabel = [UILabel labelWithColor:[UIColor clearColor] alignment:NSTextAlignmentLeft alpha:1];
        self.ennameLabel.font = [UIFont systemFontOfSize:15];
        [self.backIV addSubview:self.ennameLabel];
        [_ennameLabel release];
    }
    
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    CGFloat width = self.contentView.frame.size.width - 5;
    CGFloat height = self.contentView.frame.size.height - 5;
    
    self.backIV.frame = self.contentView.bounds;
    
    self.imageView.frame = CGRectMake(0, 0, width, height / 5 * 4 - 20);

    self.imageV.frame = CGRectMake(width / 5 * 4 - 20, 20, width / 5, height / 5);
    self.numLabel.frame = CGRectMake(width / 5 * 4 - 20, 20, width / 5, height / 5 / 2);
    
    self.cityLabel.frame = CGRectMake(width / 5 * 4 - 20, 20 + height / 10, width / 5, height / 5 / 2);

    self.cityLabel.textColor = [UIColor whiteColor];
 
    self.countryLabel.frame = CGRectMake(20, height / 5 * 4 - 20, width - 20, height / 5 / 2 + 10);
    
    self.ennameLabel.frame = CGRectMake(20, height / 10 * 9 - 5, width - 20, height / 10 - 5);
    
}

- (void)setDesit:(Desitination_Data *)desit
{
    if (_desit != desit) {
        [_desit release];
        _desit = [desit retain];
    }
    
    self.backIV.image = [UIImage imageNamed:@"beijing.jpg"];
    self.imageV.image = [UIImage imageNamed:@"taBAR.png"];
    
    [self.imageView setImageWithURLStr:self.desit.photo Photo:@"loading.jpg"];
    self.numLabel.text =  [NSString stringWithFormat:@"%ld", self.desit.count];
    
    self.cityLabel.text = @"城市";
    self.countryLabel.text = self.desit.cnname;
    
    self.ennameLabel.text = self.desit.enname;

    

    
}


- (void)dealloc
{
    [_backIV release];
    [_imageView release];
    [_cityLabel release];
    [_numLabel release];
    [_countryLabel release];
    [_ennameLabel release];
    [_imageV release];
    [_desit release];
    [_label release];
    [super dealloc];
}
@end
