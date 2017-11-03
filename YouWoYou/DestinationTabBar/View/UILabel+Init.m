//
//  UILabel+Init.m
//  YouWoYou
//
//  Created by dllo on 15/3/23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "UILabel+Init.h"

@implementation UILabel (Init)

+ (instancetype)labelWithFrame:(CGRect)frame color:(UIColor *)color alignment:(NSTextAlignment)alignment alpha:(CGFloat)alpha
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = color;
    label.textAlignment = alignment;
    label.alpha = alpha;

    return [label autorelease];
}

+ (instancetype)labelWithColor:(UIColor *)color alignment:(NSTextAlignment)alignment alpha:(CGFloat)alpha
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = color;
    label.textAlignment = alignment;
    label.alpha = alpha;
    return [label autorelease];
}

@end
