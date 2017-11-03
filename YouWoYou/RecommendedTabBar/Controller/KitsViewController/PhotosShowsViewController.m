//
//  PhotosShowsViewController.m
//  YouWoYou
//
//  Created by dlios on 15-3-28.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "PhotosShowsViewController.h"
#import "PhotosShowsCollectionViewCell.h"
#import "NetWorkHandle.h"

@interface PhotosShowsViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) UILabel *titleL1;
@property (nonatomic, assign) BOOL flag;
@property (nonatomic, retain) UICollectionView *collection;
@property (nonatomic, assign) NSInteger fla;
@end

@implementation PhotosShowsViewController
- (void)dealloc
{   [_collection release];
    [_titleL1 release];
    [_indexPath release];
    [_idNumber release];
    [_arr release];
    [_titleL release];
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.translucent = NO;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.flag = YES;
    self.fla = self.indexPath.row + 1;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 64 - 49);

    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    self.collection.delegate = self;
    self.collection.showsHorizontalScrollIndicator = NO;
    self.collection.showsVerticalScrollIndicator = NO;
    self.collection.dataSource = self;
    [self.view addSubview:_collection];
    self.view.backgroundColor = [UIColor blackColor];
    // 按页翻页
    self.collection.pagingEnabled = YES;
    self.collection.bounces = NO;
    self.collection.contentOffset = CGPointMake(self.view.frame.size.width * self.page, 0);
 
    
    [_collection release];
    [_collection registerClass:[PhotosShowsCollectionViewCell class] forCellWithReuseIdentifier:@"654321"];
    [flowLayout release];
    
   

    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction:)] autorelease];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];

    self.titleL1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 2 * self.navigationItem.leftBarButtonItem.width, 50)];
    self.titleL1.textColor = [UIColor whiteColor];
       self.navigationItem.titleView = self.titleL1;
    self.titleL1.textAlignment = NSTextAlignmentLeft;
    [_titleL1 release];
//    NSInteger num = (NSInteger)self.collection.contentOffset.x / 375.0 + 1;
    NSString *str = [NSString stringWithFormat:@"%d",self.indexPath.item  + 1];
    self.titleL1.text = [NSString stringWithFormat:@"%@页/%@页",str,self.titleL];
   
    //当值是 YES的时候，用户触碰开始.要延迟一会，看看是否用户有意图滚动。假如滚动了，那么捕捉 touch-down事件，否则就不捕捉。假如值是NO，当用户触碰， scroll view会立即触发
//    self.collection.delaysContentTouches=YES;
  
    //canCancelContentTouches:YES-移动手指足够长度触发滚动事件,NO-scrollView发送 tracking events 后，就算用户移动手指，scrollView也不会滚动。
    self.collection.canCancelContentTouches = NO;
    // Do any additional setup after loading the view.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arr.count;
}
- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *str = [NSString stringWithFormat:@"%.0ld",indexPath.row+1];
    self.titleL1.text  = [NSString stringWithFormat:@"%@页/%@页",str,self.titleL];
  
    if (self.flag == YES) {
        [collectionView scrollToItemAtIndexPath:self.indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        self.flag = NO;
    }
    
    PhotosShowsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"654321" forIndexPath:indexPath];
    NSString *str2 = [[self.arr objectAtIndex:indexPath.item] objectForKey:@"url"];
    str2 = [str2 stringByAppendingString:@"640"];
    cell.imageUrl = str2;
//    cell.mode = PhotosCVCellModeMax;
    return cell;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.collection.contentOffset.x > (self.arr.count - 2) * self.view.frame.size.width) {
        [self loadNewData];
    }

}

- (void)loadNewData
{
    NSInteger number = [[[self.arr lastObject] objectForKey:@"id"] integerValue];
    number = number - 1;
    
    NSString *str1 = [NSString stringWithFormat:@"http://open.qyer.com/poi/get_pic_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=865424024133973&track_app_version=6.2&track_app_channel=xiaomi&track_device_info=armani&track_os=Android4.3&app_installtime=1426735827710&lat=38.883683&lon=121.545007&poi_id=%@&count=&page=&since_id=&max_id=%ld", self.idNumber, (long)number];
    NSLog(@"%@ 1111111111", str1);
    [NetWorkHandle postDataWithUrl:str1 completion:^(NSData *data) {
        
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSArray *array = [[result objectForKey:@"data"] objectForKey:@"photo_list"];
       
        for (NSDictionary *dic in array) {
            [self.arr addObject:dic];
        }
        [self.collection reloadData];
    
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    UIImage *naviBg = [UIImage imageNamed:@"taBAR.png"];
    naviBg = [naviBg imageWithAlignmentRectInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    [self.navigationController.navigationBar setBackgroundImage:naviBg forBarMetrics:UIBarMetricsDefault];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIImage *naviBg = [UIImage imageNamed:@"touming.png"];
    naviBg = [naviBg imageWithAlignmentRectInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    [self.navigationController.navigationBar setBackgroundImage:naviBg forBarMetrics:UIBarMetricsDefault];
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
