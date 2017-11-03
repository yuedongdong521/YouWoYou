//
//  MoreCityCell.m
//  YouWoYou
//
//  Created by dllo on 15/3/26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "MoreCityCell.h"

#import "UIImageView+WebCache.h"

@implementation MoreCityCell

- (void)dealloc
{
    [_imageBack release];
    [_enname release];
    [_cnname release];
    [_count release];
    [_photo release];
    [_represent release];
    [_city release];
    [_labeL release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageBack = [[UIImageView alloc] init];
        self.imageBack.layer.cornerRadius = 10;
        self.imageBack.layer.masksToBounds = YES;
        [self.contentView addSubview:_imageBack];
        [_imageBack release];
        
        self.photo = [[UIImageView alloc] init];
        [self.imageBack addSubview:_photo];
        [_photo release];
       
        self.labeL = [[UILabel alloc] init];
        [self.photo addSubview:self.labeL];
        self.labeL.backgroundColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:0.5];
        [_labeL release];

        self.cnname = [[UILabel alloc] init];
//        self.cnname.highlighted = YES;
        self.cnname.font = [UIFont systemFontOfSize:10];
        self.cnname.textColor = [UIColor whiteColor];
//        self.cnname.highlightedTextColor = [UIColor whiteColor];
        [self.photo addSubview:_cnname];
        [_cnname release];
        

        self.enname = [[UILabel alloc] init];
//        self.enname.highlighted = YES;
        self.enname.textColor = [UIColor whiteColor];
        self.enname.font = [UIFont systemFontOfSize:10];
//        self.enname.highlightedTextColor = [UIColor whiteColor];
        [self.photo addSubview:_enname];
        [_enname release];
        
        

        self.count = [[UILabel alloc] init];
        [self.imageBack addSubview:_count];
        self.count.font = [UIFont systemFontOfSize:14];
        [_count release];

        self.represent = [[UILabel alloc] init];
        self.represent.numberOfLines = 0;
        self.represent.font = [UIFont systemFontOfSize:10];
        [self.imageBack addSubview:_represent];
        self.represent.alpha = 0.75;
        
        [_represent release];
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.imageBack.frame = layoutAttributes.bounds;
    
    
    CGFloat width = self.imageBack.frame.size.width;
    CGFloat height = self.imageBack.frame.size.height;
    
    self.photo.frame = CGRectMake(0, 0, width, height * 1 / 1.618);
      self.labeL.frame = CGRectMake(0, height * 5 / 12 - 3, width - 70, height / 6 + 6);
    self.cnname.frame = CGRectMake(0, height * 5 / 12, width - 70, height / 12);
    self.enname.frame = CGRectMake(0, height / 2, width - 70, height / 12);
  
    
    self.count.frame = CGRectMake(10, height * 1 / 1.618 + 5, width - 20, height / 12);
    
    self.represent.frame = CGRectMake(10, height * 8 / 12 + 5, width - 20, height / 3 - 10);
 
}

- (void)setCity:(AllCityData *)city
{
    if (_city != city) {
        [_city release];
        _city = [city retain];
    }
    
    self.imageBack.image = [UIImage imageNamed:@"cell.png"];
    [self.photo setImageWithURLStr:self.city.photo Photo:@"jiazaizhong.png"];
    self.cnname.text = self.city.catename;
    self.enname.text = self.city.catename_en;
    self.count.text = self.city.beenstr;
    self.represent.text = self.city.represen;
    self.represent.numberOfLines = 3;

}

@end
