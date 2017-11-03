//
//  TipsTableViewCell.m
//  YouWoYou
//
//  Created by dlios on 15-3-24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "TipsTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation TipsTableViewCell

- (void)dealloc
{
    [_mguide release];
    [_photo release];
    [_avatar release];
    [_username release];
    [_title release];
    
    [super dealloc];
}
 

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        self.photo = [[UIImageView alloc] init];
        [self.contentView addSubview:_photo];
        self.photo.clipsToBounds = YES;
        self.photo.contentMode = UIViewContentModeScaleAspectFill;
        [_photo release];
        
        self.avatar = [[UIImageView alloc] init];
        [self.contentView addSubview:_avatar];
        [_avatar release];
        
        self.username = [[UILabel alloc] init];
        [self. contentView addSubview:_username];
        [_username release];
        
        self.title = [[UILabel alloc] init];
        [self.contentView addSubview:_title];
        [_title release];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.photo.frame = CGRectMake(10, 10, self.contentView.frame.size.width - 20, self.contentView.frame.size.height * 2 / 3 );
    
    self.avatar.frame = CGRectMake(30, self.contentView.frame.size.height * 2 / 3 , self.contentView.frame.size.height / 6, self.contentView.frame.size.height / 6 );
    
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = 13;
  
//    CGColorCreateGenericRGB(CGFloat red, CGFloat green,
//                                                            CGFloat blue, CGFloat alpha)
    self.avatar.clipsToBounds = YES;
    
    self.username.frame = CGRectMake(70, self.contentView.frame.size.height * 2 / 3 + 5, self.contentView.frame.size.width / 3 - 20, self.contentView.frame.size.height / 6);

    
    self.title.frame = CGRectMake(10, self.contentView.frame.size.height * 2 / 3 + 5 + self.contentView.frame.size.height / 6 , self.contentView.frame.size.width, self.contentView.frame.size.height / 6 - 10);


}


- (void)setMguide:(MguideModel *)mguide
{
    if (_mguide != mguide) {
        [_mguide release];
        _mguide = [mguide retain];
    }
    
    self.username.text = self.mguide.username;
    self.username.font = [UIFont systemFontOfSize:12];
    self.username.alpha = 0.5;
    self.title.text = self.mguide.title;
    [self.avatar setImageWithURLStr:self.mguide.avatar];
    [self.photo setImageWithURLStr:self.mguide.photo Photo:@"loading.jpg"];

//    [self.photo setImageWithURLStr:self.mguide.photo];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
