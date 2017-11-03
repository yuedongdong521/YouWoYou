//
//  DiscountLIstCollectionViewCell.m
//  YouWoYou
//
//  Created by dlios on 15-3-26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "DiscountLIstCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "DiscountList_Property.h"
@implementation DiscountLIstCollectionViewCell
- (void)dealloc
{
    [_imgView release];
    [_DCL release];
    [_title_label release];
    [_price_label release];
    [_end_date_label release];
    [_lastminute_des release];
    [super dealloc];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor =[UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:0.6];
        self.imgView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imgView];
        [self.imgView release];
    
        self.title_label = [[UILabel alloc]init];
        self.title_label.numberOfLines = 0 ;
        //self.title_label.textColor =[UIColor whiteColor];
        self.title_label.font = [UIFont systemFontOfSize:20];
        self.title_label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.title_label];
        [self.title_label release];
        
        self.price_label = [[UILabel alloc]init];
        
         self.price_label.textAlignment = NSTextAlignmentCenter;
        self.price_label.textColor = [UIColor redColor];
        [self.contentView addSubview:self.price_label];
        [self.price_label release];
        
        self.end_date_label= [[UILabel alloc]init];
         self.end_date_label.textAlignment = NSTextAlignmentCenter;
        self.end_date_label.textColor =[UIColor whiteColor];
        [self.contentView addSubview:self.end_date_label];
        [self.end_date_label release];

        self.lastminute_des= [[UILabel alloc]init];
        self.lastminute_des.font = [UIFont systemFontOfSize:15];
        //self.lastminute_des.textColor =[UIColor whiteColor];
         self.lastminute_des.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.lastminute_des];
        [self.lastminute_des release];
        
    }
    return self;
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    CGFloat width = self.contentView.bounds.size.width;
    self.imgView.frame = CGRectMake(0 , 0, width, 110);
    self.title_label.frame = CGRectMake(0 ,120  , width , 50);
    self.price_label.frame = CGRectMake(0 , 180, width / 4 , 20);
    self.lastminute_des.frame = CGRectMake(width / 4 ,180, width / 4 , 20);
    self.end_date_label.frame = CGRectMake(width / 2 , 180, width / 2 , 20);
    
}
- (void)setDCL:(DiscountList_Property *)DCL
{
    if (_DCL != DCL ) {
        [_DCL release];
        _DCL = [DCL retain];
        
    }
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    self.imgView.clipsToBounds = YES;
    [self.imgView  setImageWithURLStr:self.DCL.pic];
    self.title_label.text = self.DCL.title;
     self.price_label.text = self.DCL.price;
    self.lastminute_des.text = self.DCL.lastminute_des;
    self.end_date_label.text = self.DCL.end_date;
  
}

@end
