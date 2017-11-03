//
//  PhotoMainViewController.m
//  YouWoYou
//
//  Created by dlios on 15-3-29.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "PhotoMainViewController.h"
#import "PhotoCollectionViewCell.h"
#import "NetWorkHandle.h"
#import "MJRefresh.h"
#import "PhotosShowsViewController.h"

@interface PhotoMainViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain) UICollectionView *collection;
@property (nonatomic, retain) NSMutableArray *array;
@property (nonatomic, retain) NSString *total_number;

@end

@implementation PhotoMainViewController

- (void)dealloc
{
    [_idNmber release];
    [_collection release];
    [_array release];
    [_total_number release];
    [super dealloc];
}

- (void)handleData
{
    
    NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/poi/get_pic_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=865424024133973&track_app_version=6.2&track_app_channel=xiaomi&track_device_info=armani&track_os=Android4.3&app_installtime=1426735827710&lat=38.883683&lon=121.545007&poi_id=%@&count=&page=&since_id=&max_id=0", self.idNmber];
    [NetWorkHandle postDataWithUrl:str completion:^(NSData *data) {
        
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        self.array = [[result objectForKey:@"data"] objectForKey:@"photo_list"];
        self.total_number = [[result objectForKey:@"data"] objectForKey:@"total_number"];
        [self.collection reloadData];
        [self.collection addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        [self.collection.footer beginRefreshing];
    }];
    
    
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"321" forIndexPath:indexPath];
    
    NSString *str = [[self.array objectAtIndex:indexPath.item] objectForKey:@"url"];
    NSLog(@"%@ aaa",str);


    str = [str stringByAppendingString:@"120"];
    NSLog(@"%@ ccc",str);
     cell.urlImage = str;
    
    return cell;
}
- (void)makeView
{
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    //    flow.estimatedItemSize =  CGSizeMake((self.view.frame.size.width - 30) / 3, (self.view.frame.size.width - 30) / 3);
    flow.itemSize = CGSizeMake((self.view.frame.size.width - 30) / 3, (self.view.frame.size.width - 30) / 3);
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing  = 10;
    
    self.collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flow];
    self.collection.backgroundColor = [UIColor whiteColor];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.view addSubview:self.collection];
    
    [_collection release];
    [self.collection registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"321"];
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction:)] autorelease];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 2 * self.navigationItem.leftBarButtonItem.width, 80)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"相册";
    self.navigationItem.titleView = titleLabel;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [titleLabel release];

    
    [flow release];
}
- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)loadNewData
{
    NSInteger number = [[[self.array lastObject] objectForKey:@"id"] integerValue];
    number = number - 1;
    
    NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/poi/get_pic_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=865424024133973&track_app_version=6.2&track_app_channel=xiaomi&track_device_info=armani&track_os=Android4.3&app_installtime=1426735827710&lat=38.883683&lon=121.545007&poi_id=%@&count=&page=&since_id=&max_id=%ld", self.idNmber, (long)number];
    
    
    [NetWorkHandle postDataWithUrl:str completion:^(NSData *data) {
        
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSArray *array = [[result objectForKey:@"data"] objectForKey:@"photo_list"];
        if ( array.count == 0) {
            [self.collection removeFooter];
        }
        for (NSDictionary *dic in array) {
            [self.array addObject:dic];
        }
    
        [self.collection reloadData];
        [self.collection.footer endRefreshing];
    }];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    PhotosShowsViewController *photoShow = [[PhotosShowsViewController alloc] init];
    photoShow.arr = self.array;
    photoShow.page = indexPath.item;
    photoShow.titleL =  self.total_number;
    photoShow.idNumber = self.idNmber;
    photoShow.indexPath = indexPath;
    [self.navigationController pushViewController:photoShow animated:YES];
    
    [photoShow release];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeView];
    [self handleData];
   
    // Do any additional setup after loading the view.
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
