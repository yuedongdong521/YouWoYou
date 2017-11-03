//
//  DiscountCell.m
//  YouWoYou
//
//  Created by dllo on 15/3/24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "DiscountCell.h"

#import "UIImageView+WebCache.h"

@implementation DiscountCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_backImage];
        [_backImage release];
        
        self.photo = [[UIImageView alloc] init];
        [self.backImage addSubview:_photo];
        [_photo release];
        
        self.infoLabel = [[UILabel alloc] init];
        [self.backImage addSubview:_infoLabel];
        [_infoLabel release];
        
        self.priceLabel = [[UILabel alloc] init];
        [self.backImage addSubview:_priceLabel];
        [_priceLabel release];
        
        self.timeLabel = [[UILabel alloc] init];
        [self.backImage addSubview:_timeLabel];
        [_timeLabel release];
        
        self.discountLabel = [[UILabel alloc] init];
        [self.backImage addSubview:_discountLabel];
        [_timeLabel release];
        
    }

    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backImage.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    self.backImage.image = [UIImage imageNamed:@"cell.png"];
    
    CGFloat width = self.backImage.frame.size.width;
    CGFloat height = self.backImage.frame.size.height;
    
    self.photo.frame = CGRectMake(10, 10, width / 2 - 20, height - 20);
    self.photo.backgroundColor = [UIColor whiteColor];
    NSString *str = self.country.photo;
    [self.photo setImageWithURLStr:str Photo:@"jiazaizhong.png"];
    
    self.infoLabel.frame = CGRectMake(width / 2, 10, width / 2 - 10, height / 3);
    self.infoLabel.backgroundColor = [UIColor clearColor];
    self.infoLabel.text = self.country.title;
    self.infoLabel.numberOfLines = 0;
    
    self.priceLabel.frame = CGRectMake(width / 2, height / 3 + 10, width / 4, height / 3);
    self.priceLabel.text = self.country.priceStr;
    self.priceLabel.textColor = [UIColor redColor];
    self.priceLabel.backgroundColor = [UIColor clearColor];
    
    self.discountLabel.frame = CGRectMake(width / 4 * 3, height / 3 + 10, width / 4 - 10, height / 3);
    self.discountLabel.textColor = [UIColor redColor];
    self.discountLabel.backgroundColor = [UIColor clearColor];
    self.discountLabel.text = self.country.priceoff;
    
    self.timeLabel.frame = CGRectMake(width / 2, height / 3 * 2 + 10, width / 2 - 10, height / 3 - 20);
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.backgroundColor = [UIColor clearColor];
    self.timeLabel.text = self.country.expire_date;
}

- (void)dealloc
{
    [_backImage release];
    [_photo release];
    [_infoLabel release];
    [_priceLabel release];
    [_timeLabel release];
    [_discountLabel release];
    [_country release];
    [super dealloc];
}

@end
