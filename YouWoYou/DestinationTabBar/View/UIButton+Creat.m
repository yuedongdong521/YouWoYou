//
//  UIButton+Creat.m
//  YouWoYou
//
//  Created by dllo on 15/3/24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "UIButton+Creat.h"

@implementation UIButton (Creat)

+ (instancetype)buttonWithFrame:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
