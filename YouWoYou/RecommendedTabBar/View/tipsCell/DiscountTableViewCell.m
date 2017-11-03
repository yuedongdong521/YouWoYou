//
//  DiscountTableViewCell.m
//  YouWoYou
//
//  Created by dlios on 15-3-24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "DiscountTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation DiscountTableViewCell

- (void)dealloc
{
    [_discount release];
    [_title release];
    [_price release];
    [_end_data release];
    [_priceoff release];
    [_photo release];
    [super dealloc];
    

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        self.photo = [[UIImageView alloc] init];
        [self.contentView addSubview:_photo];
        [_photo release];
        
        
        self.title = [[UILabel alloc] init];
        [self.contentView addSubview:_title];
        [_photo release];
        
        self.price = [[UILabel alloc] init];
        [self.contentView addSubview:_price];
        [_price release];
    
        self.priceoff = [[UILabel alloc] init];
        [self.contentView addSubview:_priceoff];
        [_priceoff release];
        
        self.end_data = [[UILabel alloc] init];
        [self.contentView addSubview:_end_data];
        [_end_data release];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.photo.frame = CGRectMake(10, 10, self.contentView.frame.size.width - 20, self.contentView.frame.size.height * 2 / 3);
    self.photo.contentMode = UIViewContentModeScaleAspectFill;
    self.photo.clipsToBounds = YES;
    
    self.title.frame = CGRectMake(10, self.contentView.frame.size.height * 2 / 3 + 5, self.contentView.frame.size.width - 20, self.contentView.frame.size.height / 6);
    
    self.price.frame = CGRectMake(10, self.contentView.frame.size.height * 2 / 3 + self.contentView.frame.size.height / 6, 100, self.contentView.frame.size.height / 12);
    self.price.font = [UIFont systemFontOfSize:15];
    self.price.textColor = [UIColor redColor];
    
    self.end_data.frame = CGRectMake(10, self.contentView.frame.size.height * 11 / 12 , 200, self.contentView.frame.size.height / 12);
    self.end_data.font = [UIFont systemFontOfSize:10];
    self.end_data.alpha = 0.5;
    
    self.priceoff.frame = CGRectMake(self.contentView.frame.size.width - 100, self.contentView.frame.size.height * 11 / 12, 100, self.contentView.frame.size.height / 12);
    self.priceoff.font = [UIFont systemFontOfSize:15];
    self.priceoff.textColor = [UIColor redColor];
    self.priceoff.textAlignment = NSTextAlignmentCenter;

    
    
}


- (void)setDiscount:(DiscountModel *)discount
{
    if (_discount != discount) {
        [_discount release];
        _discount = [discount retain];
    }
    
//    [self.photo setImageWithURLStr:self.discount.photo];
    [self.photo setImageWithURLStr:self.discount.photo Photo:@"loading.jpg"];

    self.title.text = self.discount.title;
    NSRange rang = NSMakeRange(4, 4);
    NSString *str = [self.discount.price substringWithRange:rang];
   
    self.price.text = [NSString stringWithFormat:@"%@元起", str];
    
    
    self.priceoff.text = self.discount.priceoff;
    self.end_data.text = self.discount.end_date;
    

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
