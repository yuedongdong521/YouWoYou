//
//  CityCollect_CollectionViewCell.m
//  YouWoYou
//
//  Created by dlios on 15-3-30.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "CityCollect_CollectionViewCell.h"
#import "AllCityData.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
@implementation CityCollect_CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imgView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imgView];
        self.imgView.clipsToBounds = YES;
        self.imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self.imgView release];
        
        self.title_label = [[UILabel alloc]init];
        self.title_label.textAlignment = NSTextAlignmentCenter;
        self.title_label.backgroundColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:0.75];
        self.title_label.highlighted = YES;
        self.title_label.font = [UIFont systemFontOfSize:15];
        self.title_label.textColor = [UIColor whiteColor];
        [self.imgView addSubview:self.title_label];
        [self.title_label release];
        
    }
    return self;
}
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
 

    self.imgView.frame = self.contentView.bounds;
    
    self.title_label.frame = CGRectMake(0 , self.imgView.frame.size.height * 4 / 5, self.imgView.bounds.size.width, self.imgView.frame.size.height / 4);

    
}

- (void)setCity:(AllCityData *)city
{
    if (_city != city) {
        [_city release];
        _city = [city retain];
    }
    
    [self.imgView setImageWithURLStr:city.photo];
    
     self.title_label.text = city.catename;
}
- (void)dealloc
{
    [_imgView release];
    [_title_label release];
    [_city release];
    [super dealloc];
}

@end
