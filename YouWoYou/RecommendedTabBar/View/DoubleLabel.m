//
//  DoubleLabel.m
//  YouWoYou
//
//  Created by dlios on 15-3-25.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "DoubleLabel.h"

@implementation DoubleLabel
- (void)dealloc{
    
    [_rightLabel release];
    [_leftLabel release];
    [super dealloc];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
    self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width / 4, frame.size.height )];
        self.leftLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview: self.leftLabel ];
    [self.leftLabel release];
    
    
    
    self.rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width / 4, 0, frame.size.width * 3 / 4, frame.size.height )];
    self.rightLabel.textColor = [UIColor whiteColor];
         self.rightLabel.font = [UIFont systemFontOfSize:20];
        self.rightLabel.highlighted = YES;
    [self addSubview: self.rightLabel ];
    [self.rightLabel release];
    
    }
    return  self;
    
}

- (instancetype)init
{
    [super init];
    if (self) {
        self.leftLabel = [[UILabel alloc]init];
        self.leftLabel.textAlignment = NSTextAlignmentRight;
        self.leftLabel.backgroundColor = [UIColor clearColor];
        [self addSubview: self.leftLabel ];
        [self.leftLabel release];
        
    self.rightLabel = [[UILabel alloc]init];
        self.rightLabel.textColor = [UIColor whiteColor];
        self.rightLabel.backgroundColor = [UIColor clearColor];
        self.rightLabel.highlighted = YES;
        [self addSubview: self.rightLabel ];
        [self.rightLabel release];
 
    }
    return self;
}

- (void)GiveFrame
{
    self.leftLabel.frame = CGRectMake(0, 0, self.bounds.size.width / 3, self.bounds.size.height );
    self.rightLabel.frame = CGRectMake(self.bounds.size.width / 3, 0, self.bounds.size.width  * 2 / 3, self.bounds.size.height );
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
