//
//  AllMgideCell.m
//  YouWoYou
//
//  Created by dllo on 15/3/26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "AllMgideCell.h"

#import "UIImageView+WebCache.h"

@interface AllMgideCell ()

@property (nonatomic, retain) UIImageView *contView;

@end


@implementation AllMgideCell

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
        
    
        self.contView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.contView];
        [_contView release];
        
        self.backImage = [[UIImageView alloc] init];
        [self.contView addSubview:self.backImage];
        [_backImage release];
        
        self.photo = [[UIImageView alloc] init];
        self.photo.backgroundColor = [UIColor whiteColor];
        [self.backImage addSubview:self.photo];
        [_photo release];
        
        self.avatar = [[UIImageView alloc] init];
        self.avatar.backgroundColor = [UIColor redColor];
        [self.photo addSubview:self.avatar];
        [_avatar release];
        
        self.username = [[UILabel alloc] init];
        self.username.font = [UIFont systemFontOfSize:16];
        [self.backImage addSubview:self.username];
        self.username.alpha = 0.5;
        [_username release];
        
        self.title = [[UILabel alloc] init];
        self.title.font = [UIFont systemFontOfSize:25];
        [self.backImage addSubview:self.title];
        [_title release];
        
        self.descrip = [[UILabel alloc] init];
        self.descrip.numberOfLines = 0;
        [self.backImage addSubview:self.descrip];
        self.descrip.alpha = 0.7;
        [_descrip release];
        
        self.count = [[UILabel alloc] init];
        [self.photo addSubview:self.count];
        [_count release];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contView.frame = self.contentView.bounds;
    self.contView.image = [UIImage imageNamed:@"bgColor.png"];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backImage.frame = CGRectMake(10, 10, self.contentView.frame.size.width - 20, self.contentView.frame.size.height - 20);
    self.backImage.image = [UIImage imageNamed:@"cell2.png"];
    
    CGFloat width = self.backImage.frame.size.width;
    CGFloat heigth = self.backImage.frame.size.height;
    
    self.photo.frame = CGRectMake(0, 0, width, heigth / 2);
    [self.photo setImageWithURLStr:self.megide.photo Photo:@"jiazaizhong.png"];
    
    self.avatar.frame = CGRectMake(10, heigth / 2 - 20, 40, 40);
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = self.avatar.frame.size.width / 2;
    [self.avatar setImageWithURLStr:self.megide.avatar Photo:@"jiazaizhong.png"];
    
    self.username.frame = CGRectMake(60, heigth / 2, width - 60, 20);
    self.username.text = self.megide.username;
    
    self.title.frame = CGRectMake(10, heigth / 2 + 20, width - 10, 40);
    
    self.title.text = self.megide.title;
    
    self.descrip.frame = CGRectMake(10, heigth / 2 + 60, width - 20, heigth / 2 - 60);
    self.descrip.text = self.megide.descrip;
}

- (void)dealloc
{
    [_backImage release];
    [_photo release];
    [_avatar release];
    [_title release];
    [_username release];
    [_descrip release];
    [_count release];
    [_megide release];
    [super dealloc];
}

@end
