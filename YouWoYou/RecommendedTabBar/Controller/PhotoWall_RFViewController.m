//
//  PhotoWall_RFViewController.m
//  YouWoYou
//
//  Created by dlios on 15-3-25.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "PhotoWall_RFViewController.h"
#import "Image_RFCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "iCarousel.h"
@interface PhotoWall_RFViewController ()<iCarouselDataSource,iCarouselDelegate,UIActionSheetDelegate>
@property (nonatomic, retain)
iCarousel *carousel;
@end

@implementation PhotoWall_RFViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if ((self = [super initWithCoder:aDecoder]))
    {
        self.wrap = YES;
    }
    
    return self;

}

- (void)dealloc
{
    [_carousel release];
    [_arr release];
    [super dealloc];
    
}
- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction:)] autorelease];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 2 * self.navigationItem.leftBarButtonItem.width, 80)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"照片墙";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    self.navigationItem.titleView = titleLabel;
    [titleLabel release];
    self.carousel = [[iCarousel alloc]initWithFrame:self.view.bounds];
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    self.carousel.type = iCarouselTypeCoverFlow;
    [self.view addSubview:self.carousel];
    [self.carousel release];
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    for (UIView *view in self.carousel.visibleItemViews)
    {
        view.alpha = 1.0;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView commitAnimations];
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.arr.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width / 5, self.view.bounds.size.height / 5, self.view.bounds.size.width  * 3/ 5, self.view.bounds.size.height /2 )];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:view.bounds];
  
   //[imageView setImageWithURLStr:[self.arr objectAtIndex:index]];
   [imageView setImageWithURLStr:[self.arr objectAtIndex:index] Photo:@"jiazaizhong.png"];
    
    [view addSubview:imageView];
        return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    return 0;
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    return self.arr.count;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return 250;
}

- (CATransform3D)carousel:(iCarousel *)_carousel transformForItemView:(UIView *)view withOffset:(CGFloat)offset
{
    view.alpha = 1.0 - fminf(fmaxf(offset, 0.0), 1.0);
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = self.carousel.perspective;
    transform = CATransform3DRotate(transform, M_PI / 8.0, 0, 1.0, 0);
    return CATransform3DTranslate(transform, 0.0, 0.0, offset * self.carousel.itemWidth);
}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    return self.wrap;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
