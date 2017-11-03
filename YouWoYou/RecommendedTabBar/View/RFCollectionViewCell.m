//
//  RFCollectionViewCell.m
//  YouWoYou
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "RFCollectionViewCell.h"
#import "RF_property.h"
#import "UIImageView+WebCache.h"
@implementation RFCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imgView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imgView];
        [self.imgView release];
        
        self.title_label = [[UILabel alloc]init];
        self.title_label.textAlignment = NSTextAlignmentCenter;
        self.title_label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
         self.title_label.highlighted = YES;
        self.title_label.font = [UIFont systemFontOfSize:15];
        self.title_label.textColor = [UIColor whiteColor];
        [self.imgView addSubview:self.title_label];
        [self.title_label release];
        
        
        self.subtitle_label = [[UILabel alloc]init];
        self.subtitle_label.textAlignment = NSTextAlignmentCenter;
        self.subtitle_label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        self.subtitle_label.textColor = [UIColor whiteColor];
        self.subtitle_label.font = [UIFont boldSystemFontOfSize:13];
        [self.imgView addSubview:self.subtitle_label];
        [self.subtitle_label release];
        
       
      
        
    }
    return self;
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    
    self.imgView.frame = self.contentView.bounds;
    
    self.title_label.frame = CGRectMake(0 , 110, self.imgView.bounds.size.width, 20);
    
    self.subtitle_label.frame = CGRectMake(0 , 130, self.imgView.bounds.size.width, 20);
   
}

- (void)setRF:(RF_property *)RF
{
    if (_RF != RF) {
        [_RF release];
        _RF = [RF retain];
    }
    [_imgView setImageWithURLStr:self.RF.img ];
    self.title_label.text = self.RF.name;
    self.subtitle_label.text = self.RF.desc;
    
    
    
}
- (void)dealloc
{
  
    [_imgView release];
    [_title_label release];
    [_subtitle_label release];
    [_RF release];
    [super dealloc];
}
@end
