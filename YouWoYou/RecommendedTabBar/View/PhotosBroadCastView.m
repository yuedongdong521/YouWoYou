//
//  PhotosBroadCastView.m
//  YouWoYou
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "PhotosBroadCastView.h"
#import "PhotosCollectionViewCell.h"


@interface PhotosBroadCastView () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) NSTimer *timer;

@end

@implementation PhotosBroadCastView

static NSString * const reuseIdentifier = @"Cell";

- (void)dealloc
{
    [_timer release];
    [_photoArr release];
    [_collection release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 设置图片轮播去的cell
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
   
        
        self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
        
        self.collection.delegate = self;
        self.collection.dataSource = self;
        [self.collection setPagingEnabled:YES];
        [self.collection registerClass:[PhotosCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [self addSubview:self.collection];
        
        [_collection release];

        [flowLayout release];
        
    }
    return self;
}

#pragma mark collection的必备的两个方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoArr.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotosCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    cell.slide = [self.photoArr objectAtIndex:indexPath.item];
    
    return cell;
    
}

- (void)addtimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(time) userInfo:nil repeats:YES];
    // 循环播放
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}
static  NSInteger p = 0;


- (void)time
{
    if (p == self.photoArr.count - 1) {
        p = 0;
    } else {
        p++;
    }
    
    self.collection.contentOffset = CGPointMake(self.frame.size.width * p, 0);
}

-(void)closeTimer
{
    [self.timer invalidate];
}
//  scrollView 开始拖拽的时候调用

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self closeTimer];
}
//  scrollView 结束拖拽的时候调用
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addtimer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
