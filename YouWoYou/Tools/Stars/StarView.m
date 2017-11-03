//
//  StarView.m
//  DoubanMovieSample
//
//  Created by lzhr on 15/3/13.
//  Copyright (c) 2015年 lzhr. All rights reserved.
//

#import "StarView.h"

@interface StarView ()

@property (nonatomic, retain) UILabel *ratingLabel;

@end

@implementation StarView

- (void)dealloc
{
    [_ratingLabel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        for (NSInteger i = 0; i < 5; i++) {
            
            UIImageView *imageView = [[UIImageView alloc] init];
            
            [self addSubview:imageView];
            [imageView release];
        }
        
        self.ratingLabel = [[UILabel alloc] init];
        self.ratingLabel.textColor = [UIColor orangeColor];
        self.ratingLabel.textAlignment = NSTextAlignmentRight;
        self.ratingLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.ratingLabel];
        [_ratingLabel release];
        
    }
    return self;
}

- (void)setStarNumber:(NSInteger)starNumber
{
    _starNumber = starNumber;
    
    [self resetFrame];
}

- (void)resetFrame
{
    CGFloat width = self.bounds.size.width / 10;
    CGFloat height = self.bounds.size.height;
    
    NSInteger fullStars = self.starNumber / 10;
    BOOL halfStar = ((self.starNumber % 10) == 5)? YES:NO;

    for (NSInteger i = 0; i < 5; i++) {
        
        UIImageView *imageView = [self.subviews objectAtIndex:i];
        
        
        imageView.frame = CGRectMake(width * i, (height - width) / 2, width, width);
        
        if (i < fullStars) {
            imageView.image = [UIImage imageNamed:@"ic_star_red.png"];
        } else if (halfStar == YES && i == fullStars) {
            imageView.image = [UIImage imageNamed:@"ic_star_half.png"];
        } else {
            imageView.image = [UIImage imageNamed:@"star_unfav.png"];
        }
    }
    
   
    
}

- (void)setRating:(CGFloat)rating
{
    _rating = rating;
    
    self.ratingLabel.frame = self.bounds;
    self.ratingLabel.text = [NSString stringWithFormat:@"%.1f", _rating];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
