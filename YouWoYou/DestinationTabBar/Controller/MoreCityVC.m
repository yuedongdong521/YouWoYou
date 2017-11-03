//
//  MoreCityVC.m
//  YouWoYou
//
//  Created by dllo on 15/3/26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "MoreCityVC.h"

#import "MoreCityCell.h"
#import "MJRefresh.h"
#import "NetWorkHandle.h"

#import "AllCityData.h"

#import "City_InfoVC.h"

#import "MBProgressHUD.h"

@interface MoreCityVC ()<UICollectionViewDataSource, UICollectionViewDelegate, MBProgressHUDDelegate>

@property (nonatomic, retain)UICollectionView *moreCollection;

@property (nonatomic, retain)NSMutableArray *arr;

@property (nonatomic, assign)CGFloat width;

@property (nonatomic, assign)CGFloat heigth;

@property (nonatomic, retain)MBProgressHUD *HUD;
@property (nonatomic, assign)NSInteger n;
@end

@implementation MoreCityVC


- (void)allCityData
{
    NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/place/city/get_city_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=863970023753015&track_app_version=6.1.0.2&track_app_channel=xiaomi&track_device_info=pisces&track_os=Android4.4.4&app_installtime=1426758347724&page=1&countryid=%@", self.countryID];

    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSArray *arr = [result objectForKey:@"data"];
        self.arr = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            AllCityData *all = [[AllCityData alloc] initWithDictionary:dic];
            [self.arr addObject:all];
            [all release];
        }
        [self creatView];
        [self.moreCollection reloadData];
        [self.moreCollection addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(allCityNewData)];
        [self.moreCollection.footer beginRefreshing];
    }];
 

}
- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.n = 2;
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction:)] autorelease];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];

    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    self.HUD.labelText = @"努力加载中......";
    self.HUD.minShowTime = 5;
    self.HUD.activityIndicatorColor = [UIColor colorWithRed:36.0 / 255.0 green:196.0 / 255.0 blue:145.0 / 255.0 alpha:1];
    self.HUD.progress = 0;
    self.HUD.labelColor = [UIColor colorWithRed:36.0 / 255.0 green:196.0 / 255.0 blue:145.0 / 255.0 alpha:1];
    self.HUD.color = [UIColor clearColor];
    self.HUD.delegate = self;
    [self.HUD show:YES];
    [self.HUD showAnimated:YES whileExecutingBlock:^{
        [self allCityData];
    } completionBlock:^{
        
        [self.HUD removeFromSuperview];
        [_HUD release];
    }];
    
}



- (void)creatView
{
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 2 * self.navigationItem.leftBarButtonItem.width, 80)];
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentLeft;
    title.text = @"全部城市";
    self.navigationItem.titleView = title;
    [title release];
    
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageV.image = [UIImage imageNamed:@"bgColor.png"];
    imageV.userInteractionEnabled = YES;
    [self.view addSubview:imageV];
    [imageV release];
    

    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    self.width = self.view.bounds.size.width;
    self.heigth = self.view.bounds.size.height;
    
    flowLayout.itemSize = CGSizeMake(self.width / 2 - 30, self.heigth / 3);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.moreCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 10, self.width - 20, self.view.frame.size.height) collectionViewLayout:flowLayout];
    self.moreCollection.backgroundColor = [UIColor clearColor];
    self.moreCollection.delegate = self;
    self.moreCollection.dataSource = self;
    [imageV addSubview:self.moreCollection];
    [_moreCollection release];
    
    [self.moreCollection registerClass:[MoreCityCell class] forCellWithReuseIdentifier:@"cell"];
    
}


- (void)dealloc
{
    [_HUD release];
    [_arr release];
    [_moreCollection release];
    [_countryID release];
    [super dealloc];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MoreCityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.city = [self.arr objectAtIndex:indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    City_InfoVC *city = [[City_InfoVC alloc] init];
    AllCityData *cityData = [self.arr objectAtIndex:indexPath.row];
    city.cityID = cityData.city_id;
    [self.navigationController pushViewController:city animated:YES];
    [city release];
}

- (void)allCityNewData
{
    NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/place/city/get_city_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=863970023753015&track_app_version=6.1.0.2&track_app_channel=xiaomi&track_device_info=pisces&track_os=Android4.4.4&app_installtime=1426758347724&page=%ld&countryid=%@", (long)self.n++, self.countryID];
 
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSArray *arr = [result objectForKey:@"data"];
        
        if (arr.count == 0) {
            [self.moreCollection removeFooter];
            NSLog(@"12");
        }
        
        for (NSDictionary *dic in arr) {
            AllCityData *all = [[AllCityData alloc] initWithDictionary:dic];
            [self.arr addObject:all];
            [all release];
        }
        [self.moreCollection reloadData];
        [self.moreCollection.footer endRefreshing];

    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
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
