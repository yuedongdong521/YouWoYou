//
//  HotHeaderCV.m
//  YouWoYou
//
//  Created by dllo on 15/3/26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "HotHeaderCV.h"

@interface HotHeaderCV ()

@property (nonatomic, retain) UILabel *label;

@end

@implementation HotHeaderCV

- (void)dealloc
{
    [_label release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] init];
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:_label];
        [_label release];
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.label.frame = layoutAttributes.bounds;
    self.label.text = @"    热门城市";
}


@end
