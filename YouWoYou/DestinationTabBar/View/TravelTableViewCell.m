//
//  travelCell.m
//  YouWoYou
//
//  Created by dllo on 15/3/31.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "TravelTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation TravelTableViewCell

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
        
        self.subject = [[UILabel alloc] init];
        [self.backImage addSubview:_subject];
        [_subject release];
        self.subject.font = [UIFont systemFontOfSize:15];

        self.route = [[UILabel alloc] init];
        self.route.font = [UIFont systemFontOfSize:13];
        self.route.numberOfLines = 0;
        [self.backImage addSubview:_route];
        
        [_route release];
        
        
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
    
    self.photo.frame = CGRectMake(10, 10, width / 3 - 20, height - 20);
    self.photo.backgroundColor = [UIColor whiteColor];
    self.photo.contentMode = UIViewContentModeScaleAspectFill;
    self.photo.clipsToBounds = YES;
    NSString *str = self.data.photo;
    [self.photo setImageWithURLStr:str Photo:@"jiazaizhong.png"];
    
    self.subject.frame = CGRectMake(width / 3, 10, width / 2 , height / 3);
    self.subject.backgroundColor = [UIColor clearColor];
    self.subject.text = self.data.subject;
    
    
    self.route.frame = CGRectMake(width / 3, height / 3 + 5, width / 2, height / 3 * 2 - 10);
    self.route.text = [self.data.day stringByAppendingString:self.data.route];
    self.route.backgroundColor = [UIColor clearColor];
    
}

- (void)dealloc
{
    [_backImage release];
    [_photo release];
    [_subject release];
    [_route release];
    [_day_count release];
    [_day_count release];
    [super dealloc];
}

@end
