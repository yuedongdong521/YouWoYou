//
//  List_RFTableViewCell.m
//  YouWoYou
//
//  Created by dlios on 15-3-24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "List_RFTableViewCell.h"
#import "RF_property.h"
#import "UIImageView+WebCache.h"
@implementation List_RFTableViewCell
- (void)dealloc
{
    
    [_imgView release];
    [_title_label release];
    [_desc_label release];
    [_RF release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self) {
        self.imgView = [[UIImageView alloc]init];
         self.imgView.contentMode = NO;
        [self.contentView addSubview:self.imgView];
        [self.imgView release];
        
        self.title_label = [[UILabel alloc]init];
        self.title_label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview: self.title_label ];
        [self.title_label release];
        
        self.desc_label = [[UILabel alloc]init];
        self.desc_label.numberOfLines = 0;
                [self.contentView addSubview:self.desc_label];
        [self.desc_label release];
        
        
        
    }
    return self;
    
}
- (void)setRF:(RF_property *)RF
{
    if (_RF != RF) {
        [_RF release];
        _RF = [RF retain];
    }
  
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.title_label.text = self.RF.title;
    self.desc_label.text = self.RF.desc;
    [self.imgView setImageWithURLStr:self.RF.img];
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
    CGRect rect =   [self.desc_label.text boundingRectWithSize:CGSizeMake(self.contentView.frame.size.width, 10000) options: NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];

    CGFloat width = self.contentView.bounds.size.width;
    CGFloat height = rect.size.height;
    self.imgView.frame = CGRectMake(10, 10, width - 20, 200);
    
    self.title_label.frame =CGRectMake(0, 220, width, 30);
    
    self.desc_label.frame =CGRectMake(20, 260, width- 40 , height + 10  );
    
    self.title_label.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor =[UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:0.6];
    self.desc_label.backgroundColor = [UIColor clearColor];
    
  
    
    
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
