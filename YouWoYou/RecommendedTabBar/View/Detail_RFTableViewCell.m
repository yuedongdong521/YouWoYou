//
//  Detail_RFTableViewCell.m
//  YouWoYou
//
//  Created by dlios on 15-3-25.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "Detail_RFTableViewCell.h"
#import "DoubleLabel.h"
@implementation Detail_RFTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.doubleLabel = [[DoubleLabel alloc]init];
        [self.contentView addSubview: self.doubleLabel];
        [_doubleLabel release];
    }
    return self;
    
}
- (void)layoutSubviews
{
    
    [super layoutSubviews];
   
    self.contentView.backgroundColor = [UIColor clearColor];
    self.doubleLabel.backgroundColor =[UIColor clearColor];
    self.doubleLabel.frame = self.contentView.bounds;
    [self.doubleLabel GiveFrame];
    self.doubleLabel.rightLabel.text = self.content;
   
    self.doubleLabel.rightLabel.textColor = [UIColor blackColor];
    self.doubleLabel.leftLabel.textAlignment = NSTextAlignmentLeft;
    self.doubleLabel.leftLabel.text = [_name stringByAppendingString:@":"];
    self.doubleLabel.leftLabel.numberOfLines = 0;
    self.doubleLabel.rightLabel.numberOfLines = 0;
}
- (void)dealloc

{
   [_name release];
    [_content release];
    [_doubleLabel release];
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
