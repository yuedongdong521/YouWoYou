//
//  KitsTableViewCell.m
//  YouWoYou
//
//  Created by dlios on 15-3-24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "KitsTableViewCell.h"

@implementation KitsTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.back = [[UIImageView alloc] init];
        [self.contentView addSubview:self.back];
        UIImage *image = [UIImage imageNamed:@"ibg.png"];
        image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
        self.back.image = image;
        [_back release];
        
        
        self.bigImage = [[UIImageView alloc] init];
        [self.back addSubview:self.bigImage];
        self.bigImage.contentMode = UIViewContentModeScaleAspectFill;
        self.bigImage.clipsToBounds = YES;
        
        [_bigImage release];
        
        self.chinesename = [[UILabel alloc] init];
        [self.back addSubview:self.chinesename];
        [_chinesename release];
        
        self.stars = [[StarView alloc] init];
        [self.back addSubview:self.stars];
        [_stars release];
        
        self.descriptionN = [[UILabel alloc] init];
        [self.back addSubview:_descriptionN];
        [_descriptionN release];
        
        
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.back.frame = CGRectMake(0, 10, self.contentView.frame.size.width, self.contentView.frame.size.height - 10);
    
    self.bigImage.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 200);
    [self.bigImage setImageWithURLStr:self.pois.photo Photo:@"jiazaizhong.png"];
    
    self.chinesename.font = [UIFont systemFontOfSize:20];
    self.chinesename.frame = CGRectMake(10, 140, 150, 20);
    if (self.pois.chinesename.length != 0) {
        self.chinesename.text = self.pois.chinesename;
    } else {
        self.chinesename.text = self.pois.firstname;
    }
    self.chinesename.textColor = [UIColor whiteColor];
    
  
    
    
  
    self.descriptionN.text = self.pois.descriptionN;
  

    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    
    CGRect rect = [self.pois.description boundingRectWithSize:CGSizeMake( self.back.frame.size.width - 20, 10000) options: NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    self.descriptionN.font = [UIFont systemFontOfSize:14];
    self.descriptionN.frame = CGRectMake(10, 210, self.back.frame.size.width - 20, rect.size.height);
    self.descriptionN.numberOfLines = 0;
    [self.descriptionN sizeToFit];


}


- (void)setPois:(PoisModel *)pois
{
    if (_pois != pois) {
        [_pois release];
        _pois = [pois retain];
    }
    self.stars.frame = CGRectMake(10, 160, 150, 30);

    self.stars.starNumber = [self.pois.recommandstarN integerValue ] * 5;
}

- (void)dealloc
{
    [_back release];
    [_pois release];
    [_bigImage release];
    [_chinesename release];
    [_descriptionN release];
    [_stars release];
    [super dealloc];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
