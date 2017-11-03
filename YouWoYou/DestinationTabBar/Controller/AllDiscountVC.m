//
//  AllDiscountVC.m
//  YouWoYou
//
//  Created by dllo on 15/3/28.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "AllDiscountVC.h"

#import "AllDiscountCell.h"

#import "CountryData.h"

#import "NetWorkHandle.h"

#import "DiscountDetailVC.h"

#import "MBProgressHUD.h"

#import "MJRefresh.h"

NSInteger n = 2;

@interface AllDiscountVC ()<UICollectionViewDataSource, UICollectionViewDelegate, MBProgressHUDDelegate>
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, retain)UICollectionView *collectionView;
@property (nonatomic, retain)NSMutableArray *arr;
@property (nonatomic, retain)MBProgressHUD *HUD;
@property (nonatomic, retain)UILabel *labeL;
@end

@implementation AllDiscountVC

- (void)dealloc
{
    [_labeL release];
    [_collectionView release];
    [_arr release];
    [_discountID release];
    [_HUD release];
    [super dealloc];
}
- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction:)] autorelease];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    self.HUD.labelText = @"努力加载中....";
    self.HUD.labelColor = [UIColor colorWithRed:36.0 / 255 green:196.0 / 255 blue:145.0 / 255 alpha:1];
    [self.HUD show:YES];
    self.HUD.minShowTime = 5.0;
    self.HUD.activityIndicatorColor = [UIColor colorWithRed:36.0 / 255 green:196.0 / 255 blue:145.0 / 255 alpha:1];
    self.HUD.delegate = self;
    self.HUD.progress = 0;
    self.HUD.color = [UIColor clearColor];
     [self.view addSubview:self.HUD];
    [self.HUD showAnimated:YES whileExecutingBlock:^{
      
        [self discountData];
   
    } completionBlock:^{
        [self.HUD removeFromSuperview];
        [_HUD release];
    }];
   
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 2 * self.navigationItem.leftBarButtonItem.width, 80)];
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentLeft;
    title.text = @"全部折扣";
    self.navigationItem.titleView = title;
    [title release];
    
    self.title = @"全部折扣";
    
    
}

- (void)creatView
{
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageV.image = [UIImage imageNamed:@"bgColor.png"];
    imageV.userInteractionEnabled = YES;
    [self.view addSubview:imageV];
    [imageV release];
    
    self.width = self.view.bounds.size.width;
    self.height = self.view.frame.size.height;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.width / 2 - 30, self.height / 3);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, self.width - 20, self.height) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [imageV addSubview:self.collectionView];
    [_collectionView release];
    
    [self.collectionView registerClass:[AllDiscountCell class] forCellWithReuseIdentifier:@"reuse"];
    
    
    
    [self.collectionView addLegendFooterWithRefreshingBlock:^{
        [self discountNewData];
    }];
   
//    [self.collectionView.footer beginRefreshing];

    self.labeL = [[UILabel alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.labeL];
    self.labeL.text = @"暂时没有相关信息";
    self.labeL.textColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:1];
    self.labeL.font = [UIFont systemFontOfSize:20];
    self.labeL.textAlignment = NSTextAlignmentCenter;
    self.labeL.hidden = YES;
    [_labeL release];
}

- (void)discountData
{
    NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/qyer/discount/place_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=865424024133973&track_app_version=6.1.0.2&track_app_channel=xiaomi&track_device_info=armani&track_os=Android4.3&app_installtime=1426735827710&lat=38.883683&lon=121.544904&oauth_token=&type=country&id=%@&count=10&page=1 HTTP/1.1", self.discountID];
    NSLog(@"%@", str);

    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSArray *arr = [result objectForKey:@"data"];
        if (arr.count == 0) {
            self.labeL.hidden = YES;
        } else {
            self.labeL.hidden = NO;
            
        }
        self.arr = [NSMutableArray array];
   
        for (NSDictionary *dic in arr) {
            CountryData *data = [[CountryData alloc] initWithDictionary:dic];
            [self.arr addObject:data];
            [data release];
        }
        
        [self creatView];
        [self.collectionView reloadData];
    }];
}

- (void)discountNewData
{
    NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/qyer/discount/place_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=865424024133973&track_app_version=6.1.0.2&track_app_channel=xiaomi&track_device_info=armani&track_os=Android4.3&app_installtime=1426735827710&lat=38.883683&lon=121.544904&oauth_token=&type=country&id=%@&count=10&page=%ld", self.discountID, (long)n++];
    NSLog(@"%@", str);
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSArray *arr = [result objectForKey:@"data"];
        
        if (arr.count == 0) {
            [self.collectionView removeFooter];

        } else {
            [self.collectionView.footer endRefreshing];
        }
        for (NSDictionary *dic in arr) {
            CountryData *data = [[CountryData alloc] initWithDictionary:dic];
            [self.arr addObject:data];
            [data release];
        }
       
        [self.collectionView reloadData];
        [self.collectionView.footer endRefreshing];

    }];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AllDiscountCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    cell.discountData = [self.arr objectAtIndex:indexPath.row];
    NSLog(@"%ld", (long)indexPath.row);
   
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DiscountDetailVC *DDVC = [[DiscountDetailVC alloc]init];
    CountryData *data = [self.arr objectAtIndex:indexPath.item];
    DDVC.id_discount = data.city_id;
    [self.navigationController pushViewController:DDVC animated:YES];
    [DDVC release];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
