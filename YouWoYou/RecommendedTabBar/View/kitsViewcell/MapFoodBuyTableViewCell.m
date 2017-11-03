//
//  MapFoodBuyTableViewCell.m
//  YouWoYou
//
//  Created by dlios on 15-3-26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "MapFoodBuyTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation MapFoodBuyTableViewCell



- (void)dealloc
{
    [_mfb release];
    [_firstName release];
    [_backImage release];
    [_secondName release];
    [_star release];
    [_bentoStr release];
    [super dealloc];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backImage = [[UIImageView alloc] init];
        self.backImage.clipsToBounds = YES;
        self.backImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview: _backImage];
        [_backImage release];
        
        self.firstName = [[UILabel alloc] init];
        [self.contentView addSubview:self.firstName];
        [_firstName release];
        
        self.secondName = [[UILabel alloc] init];
        [self.contentView addSubview:self.secondName];
        self.secondName.alpha = 0.5;
        [_secondName release];
       
        self.star = [[StarView alloc] init];
        [self.contentView addSubview:self.star];
        [_star release];
        
        self.bentoStr = [[UILabel alloc] init];
        [self.contentView addSubview:self.bentoStr];
        self.bentoStr.alpha = 0.5;
        [_bentoStr release];
        
        
        
        
    }
    return self;
}

- (void)layoutSubviews
{
  
    [super layoutSubviews];
    
    CGFloat height = self.contentView.frame.size.height - 20;
    self.backImage.frame = CGRectMake(10, 10, height, height);
    self.firstName.frame = CGRectMake(height + 20, 10, 200, height / 4);
    
    self.secondName.frame = CGRectMake(height + 20, height / 4 + 10, 200, height / 4);
    self.bentoStr.frame = CGRectMake(height + 20, height * 3 / 4 + 10, 200, height / 4);
    
    self.star.frame = CGRectMake(self.contentView.frame.size.height, self.contentView.frame.size.height / 2 - 5, self.contentView.frame.size.height, self.contentView.frame.size.height / 4);
}

- (void)setMfb:(MapFoodBuyModel *)mfb
{
    if (_mfb != mfb) {
        [_mfb release];
        _mfb = [mfb retain];
    }
    [self.backImage setImageWithURLStr:self.mfb.photo Photo:@"jiazaizhong.png"];
    self.firstName.text = self.mfb.firstname;
    self.secondName.text = self.mfb.englishname;
    
    self.star.starNumber = [self.mfb.gradeN integerValue] * 5;
    self.bentoStr.text = self.mfb.beenstr;
    NSLog(@"22222222222222");
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
