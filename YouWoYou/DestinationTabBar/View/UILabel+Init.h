//
//  UILabel+Init.h
//  YouWoYou
//
//  Created by dllo on 15/3/23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Init)

+ (instancetype)labelWithFrame:(CGRect)frame color:(UIColor *)color alignment:(NSTextAlignment)alignment alpha:(CGFloat)alpha;

+ (instancetype)labelWithColor:(UIColor *)color alignment:(NSTextAlignment)alignment alpha:(CGFloat)alpha;

@end
