//
//  KitsDetailTableViewCell.m
//  YouWoYou
//
//  Created by dlios on 15-3-26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "KitsDetailTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation KitsDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.avatar = [[UIImageView alloc] init];
        [self.contentView addSubview:self.avatar];
        [_avatar release];
        
        self.userName = [[UILabel alloc] init];
        [self.contentView addSubview:self.userName];
        self.userName.alpha = 0.5;
        [_userName release];
        
        self.stars = [[StarView alloc] initWithFrame:CGRectMake(60, 30, 100, 30)];
        [self.contentView addSubview: self.stars];
        [_stars release];
        
        self.commentLabel = [[UILabel alloc] init];
        self.commentLabel.alpha = 0.7;
        [self.contentView addSubview:self.commentLabel];
        [_commentLabel release];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.avatar.frame = CGRectMake(10, 10, 40, 40);
    self.avatar.layer.cornerRadius = 20;
    self.avatar.layer.masksToBounds = YES;
    
    
    self.userName.frame =  CGRectMake(60, 10, 200, 20);
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    
    CGRect rect = [self.commentLabel.text boundingRectWithSize:CGSizeMake(self.contentView.frame.size.width - 70, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    self.commentLabel.frame = CGRectMake(60, 60, self.contentView.frame.size.width - 70, rect.size.height);
    self.commentLabel.font = [UIFont systemFontOfSize:14];
    self.commentLabel.numberOfLines = 0;

}

- (void)setComment:(Comment_listData *)comment
{
    if (_comment != comment) {
        [_comment release];
        _comment = [comment retain];
    }
    
    [self.avatar setImageWithURLStr:self.comment.avatar Photo:@"jiazaizhong.png"];
    self.userName.text = self.comment.username;
    self.stars.starNumber = [self.comment.star integerValue] * 5;
    self.commentLabel.text = self.comment.comment;

}

- (void)setComment1:(CommentListData1 *)comment1
{
    if (_comment1 != comment1 ) {
        [_comment1 release];
        _comment1 = [comment1 retain];
    }
    
    [self.avatar setImageWithURLStr:self.comment1.avatar Photo:@"jiazaizhong.png"];
    self.userName.text = self.comment1.username;
    self.stars.starNumber = [self.comment1.star integerValue] * 5;
    self.commentLabel.text = self.comment1.comment;
}

- (void)dealloc
{
    [_comment release];
    [_avatar release];
    [_userName release];
    [_stars release];
    [_commentLabel release];
    [_comment1 release];
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
