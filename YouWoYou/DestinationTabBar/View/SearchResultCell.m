//
//  SearchResultCell.m
//  YouWoYou
//
//  Created by dllo on 15/3/28.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "SearchResultCell.h"
#import "UIImageView+WebCache.h"
#import "StarView.h"
@implementation SearchResultCell

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
        
        self.photo = [[UIImageView alloc] init];
        [self.contentView addSubview:_photo];
        self.photo.contentMode = UIViewContentModeScaleAspectFill;
        self.photo.clipsToBounds = YES;
        [_photo release];
        
        
        self.cnname = [[UILabel alloc] init];
        [self.contentView addSubview:_cnname];
        [_cnname release];
        
        self.label = [[UILabel alloc] init];
        [self.contentView addSubview:self.label];
        [_label release];
        
        
        self.enname = [[UILabel alloc] init];
        [self.contentView addSubview:_enname];
        [_enname release];
        
        
        self.star = [[StarView alloc] init];
        [self.contentView addSubview:self.star];
        [_star release];
        
        self.beenstr = [[UILabel alloc] init];
        [self.contentView addSubview:_beenstr];
        [_beenstr release];

    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
    
    self.photo.frame = CGRectMake(5, 5, height, height - 10);
    [self.photo setImageWithURLStr:self.searchData.photo Photo:@"jiazaizhong.png"];
    
    self.cnname.frame = CGRectMake(width / 3, 0, width / 2 - 10, height / 4);
    self.cnname.text = self.searchData.cnname;
    
    self.enname.frame = CGRectMake(width / 3, height / 4, width / 2  - 10, height / 4);
    self.enname.text = self.searchData.enname;
    self.enname.alpha = 0.5;
    
    
    self.label.frame = CGRectMake(width - 60, height / 3 - 20, 60, 60);
    
    self.beenstr.frame = CGRectMake(width / 3, height / 4 * 3, width / 2 - 10, height / 4);
    self.beenstr.text = self.searchData.beenstr;
    self.beenstr.alpha = 0.5;
 self.star.frame = CGRectMake(self.contentView.frame.size.width / 3, self.contentView.frame.size.height / 2,  self.contentView.frame.size.width / 2 - 10, self.contentView.frame.size.height / 4);
    
}
- (void)setSearchData:(SearchData *)searchData
{
    if (_searchData != searchData) {
        [_searchData release];
        _searchData = [searchData retain];
    }
    self.label.text = self.searchData.label;
 
   
    if ([searchData.label isEqualToString:@"国家"]) {
        self.star.starNumber = 0;
    } else {
        self.star.starNumber = [searchData.gradeN integerValue] * 5;
    }
    
    

}

- (void)dealloc
{
    [_photo release];
    [_cnname release];
    [_enname release];
    [_label release];
    [_beenstr release];
    [_searchData release];
    [_star release];
    [super dealloc];
}

@end
