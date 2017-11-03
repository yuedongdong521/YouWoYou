//
//  MgideCell.m
//  YouWoYou
//
//  Created by dllo on 15/3/25.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "MgideCell.h"

#import "UIImageView+WebCache.h"


@implementation MgideCell

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
        
        self.imageV = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageV];
        [_imageV release];
        
        self.photo = [[UIImageView alloc] init];
        self.photo.backgroundColor = [UIColor whiteColor];
        [self.imageV addSubview:_photo];
        [_photo release];
        
        self.title = [[UILabel alloc] init];
        self.title.backgroundColor = [UIColor clearColor];
        [self.imageV addSubview:_title];
        [_title release];
        
        self.avatar = [[UIImageView alloc] init];
        self.title.backgroundColor = [UIColor clearColor];
        [self.imageV addSubview:_avatar];
        [_avatar release];
        
        self.username = [[UILabel alloc] init];
        self.username.font = [UIFont systemFontOfSize:12];
        self.username.backgroundColor = [UIColor clearColor];
        self.username.shadowColor = [UIColor brownColor];
        self.username.alpha = 0.5;
        [self.imageV addSubview:_username];
        [_username release];
        
        
        
    }

    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageV.frame = self.contentView.bounds;
    self.imageV.image = [UIImage imageNamed:@"cell"];
    
    CGFloat width = self.imageV.frame.size.width;
    CGFloat height = self.imageV.frame.size.height;
    
    self.photo.frame = CGRectMake(0, 0, width, height / 3 * 2);
    NSString *str = self.country.photo;
    [self.photo setImageWithURLStr:str Photo:@"jiazaizhong.png"];
    
    self.avatar.frame = CGRectMake(20, height / 3 * 2 - 20, 40, 40);
    self.avatar.layer.cornerRadius = 20;
    self.avatar.layer.masksToBounds = YES;
    NSString *avaStr = self.country.avatar;
    [self.avatar setImageWithURLStr:avaStr Photo:@"jiazaizhong.png"];
    
    self.username.frame = CGRectMake(70, height / 3 * 2, width - 70, 20);
    self.username.text = self.country.username;
    
    self.title.frame = CGRectMake(20, height / 3 * 2 + 20, width - 20, height / 3 - 30);
    self.title.text = self.country.title;
    
}

- (void)dealloc
{
    [_imageV release];
    [_photo release];
    [_title release];
    [_username release];
    [_avatar release];
    [_country release];
    [super dealloc];
}

@end
