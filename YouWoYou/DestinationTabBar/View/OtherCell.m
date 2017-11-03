//
//  OtherCell.m
//  YouWoYou
//
//  Created by dllo on 15/3/23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "OtherCell.h"

@implementation OtherCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.imageView];
        [_imageView release];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        [self.imageView addSubview:self.nameLabel];
        [_nameLabel release];
        
        self.ennameLabel = [[UILabel alloc] init];
        self.ennameLabel.backgroundColor = [UIColor clearColor];
        [self.imageView addSubview:self.ennameLabel];
        [_ennameLabel release];
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
    
    self.imageView.frame = self.contentView.bounds;
    

    
    self.nameLabel.frame = CGRectMake(20, 20, width - 20, height / 3);
    
    self.ennameLabel.frame = CGRectMake(20, 20 + height / 3, width - 20, height / 3);
    
}

- (void)setDesit:(Desitination_Data *)desit
{
    if (_desit != desit) {
        [_desit release];
        _desit = [desit retain];
    }
    
    self.imageView.image = [UIImage imageNamed:@"beijing.jpg"];
    
    self.nameLabel.text = _desit.cnname;
    self.ennameLabel.text = _desit.enname;
    
}


- (void)dealloc
{
    [_ennameLabel release];
    [_nameLabel release];
    [_imageView release];
    [_desit release];
    [super dealloc];
}


@end
