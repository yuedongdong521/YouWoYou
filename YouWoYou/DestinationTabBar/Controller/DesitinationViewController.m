//
//  DesitinationViewController.m
//  YouWoYou
//
//  Created by dlios on 15-3-22.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "DesitinationViewController.h"

#import "HotRegionCell.h"

#import "OtherCell.h"

#import "SearchBarVC.h"

#import "NetWorkHandle.h"

#import "Desitination_Data.h"

#import "Country_Info_ViewController.h"

#import "City_InfoVC.h"

#import "MBProgressHUD.h"
@interface DesitinationViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, MBProgressHUDDelegate>

@property (nonatomic, retain)NSMutableArray *hotArr;
@property (nonatomic, retain)NSMutableArray *otherArr;
@property (nonatomic, retain)NSMutableArray *dataArr;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, retain)UILabel *hotLabel;
@property (nonatomic, retain)UILabel *otherLabel;
@property (nonatomic, retain)UIImageView *backImage;
@property (nonatomic, retain)MBProgressHUD *HUD;
@property (nonatomic, retain)UIView *viewBack;
@property (nonatomic, retain)UISwipeGestureRecognizer *swipeL;
@property (nonatomic, retain)UISwipeGestureRecognizer *swipeR;
@end

@implementation DesitinationViewController


// 数据加载
- (void)dataResult
{
    NSString *str = @"http://open.qyer.com/qyer/footprint/continent_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=863970023753015&track_app_version=6.1.0.2&track_app_channel=xiaomi&track_device_info=pisces&track_os=Android4.4.4&app_installtime=1426758347724";
    self.viewBack.hidden = NO;
      
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        NSError *erron = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&erron];
        NSArray *arr = [result objectForKey:@"data"];
        if (arr.count == 0) {
            self.viewBack.hidden = NO;
        } else {
            self.viewBack.hidden = YES;
        }


        self.dataArr = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            Desitination_Data *desitData = [[Desitination_Data alloc] initWithDictionary:dic];
            [self.dataArr addObject:desitData];
            [desitData release];
        }
       
        // 进入目的地页面首先默认显示的大洲信息
        Desitination_Data *desit = [self.dataArr objectAtIndex:0];
        NSArray *dataArr = desit.hot_country;
        self.hotArr = [NSMutableArray array];
        for (NSDictionary *dic in dataArr) {
            Desitination_Data *hotData = [[Desitination_Data alloc] initWithDictionary:dic];
            [self.hotArr addObject:hotData];
            [hotData release];
        }
        
        NSArray *otherArr = desit.country;
        self.otherArr = [NSMutableArray array];
        for (NSDictionary *dic in otherArr) {
            Desitination_Data *otherData = [[Desitination_Data alloc] initWithDictionary:dic];
            [self.otherArr addObject:otherData];
            [otherData release];
        }
        [self makeView];
        
        
        [self.hotView reloadData];
        [self.otherView reloadData];
        [self scrollViewConten];
    }];
    
}

- (void)makeView
{

    self.backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _backImage.userInteractionEnabled = YES;
    _backImage.image = [UIImage imageNamed:@"bgColor.png"];
    [self.view addSubview:_backImage];
    [_backImage release];
    
    self.width = self.view.frame.size.width;
    self.height = self.view.frame.size.height;
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    
    self.scrollView.contentSize = CGSizeMake(self.width, 10000);
    
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.bounces = NO;
    
    [_backImage addSubview:self.scrollView];
    [_scrollView release];
    
    
    self.chauArr = [NSArray arrayWithObjects:@"亚洲", @"欧洲", @"北美洲", @"南美洲", @"大洋洲", @"非洲", @"南极洲", nil];
    
    UIImageView *segImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 50)];
    segImage.userInteractionEnabled = YES;
    segImage.image = [UIImage imageNamed:@"taBAR.png"];
    [_scrollView addSubview:segImage];
    [segImage release];
    
    
    self.seg = [[UISegmentedControl alloc] initWithItems:self.chauArr];
    self.seg.frame = CGRectMake(0, 0, self.width, 50);
    self.seg.backgroundColor = [UIColor clearColor];
    self.seg.tintColor = [UIColor whiteColor];
    self.seg.selectedSegmentIndex = 0;
    [self.seg addTarget:self action:@selector(segValueChanged) forControlEvents:UIControlEventValueChanged];
    [segImage addSubview:self.seg];
    [_seg release];
    
    self.swipeL = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    _swipeL.direction = UISwipeGestureRecognizerDirectionLeft;
    self.swipeR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    _swipeR.direction = UISwipeGestureRecognizerDirectionRight;
    [self.scrollView addGestureRecognizer:_swipeL];
    [self.scrollView addGestureRecognizer:_swipeR];
    [_swipeL release];
    [_swipeR release];
    [self hotRegion];
    
    [self otherDestination];

}

- (void)swipeAction:(UISwipeGestureRecognizer *)swipe
{
    if (swipe == self.swipeR) {
        if (self.seg.selectedSegmentIndex == 0) {
            self.seg.selectedSegmentIndex = 6;
            [self segValueChanged];
        } else {
            self.seg.selectedSegmentIndex = self.seg.selectedSegmentIndex - 1;
            [self segValueChanged];
        }
    } else if (swipe == self.swipeL) {
        if (self.seg.selectedSegmentIndex == 6) {
            self.seg.selectedSegmentIndex = 0;
            [self segValueChanged];
        } else {
            self.seg.selectedSegmentIndex = self.seg.selectedSegmentIndex + 1;
            [self segValueChanged];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 2 * self.navigationItem.leftBarButtonItem.width, 80)];
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"目的地";
    self.navigationItem.titleView = title;
    [title release];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(barButtonAction:)] autorelease];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    self.HUD.labelText = @"努力加载中....";
    self.HUD.minShowTime = 5.0;
    self.HUD.activityIndicatorColor =  [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:1];
    self.HUD.progress = 0;
    self.HUD.labelColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:1];
    self.HUD.color = [UIColor clearColor];
    self.HUD.delegate = self;
    [self.HUD show:YES];
    
    [self.HUD showAnimated:YES whileExecutingBlock:^{
        [self dataResult];
    } completionBlock:^{
        [_HUD removeFromSuperview];
        [_HUD release];
    }];
   
    self.viewBack = [[UIView alloc] initWithFrame:self.view.bounds];
    self.viewBack.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.viewBack.hidden = YES;
    button.frame = CGRectMake(self.view.frame.size.width / 3, 250, self.view.frame.size.width / 3, 50);
    [button setTitleColor:[UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:1] forState:UIControlStateNormal];
    [button setTitle:@"点击刷新" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dataResult) forControlEvents:UIControlEventTouchUpInside];
    [self.viewBack addSubview:button];
    [self.view addSubview:self.viewBack];
    [_viewBack release];

}

// segmentedContrl的点击事件
- (void)segValueChanged
{
    Desitination_Data *data = [self.dataArr objectAtIndex:self.seg.selectedSegmentIndex];
    
    if (data.hot_country != nil) {
        NSArray *arr = data.hot_country;
        self.hotArr = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            Desitination_Data *hotData = [[Desitination_Data alloc] initWithDictionary:dic];
            [self.hotArr addObject:hotData];
        }
    } else {
        self.hotArr = nil;
    }
    
    if (data.country != nil) {
        NSArray *otherArr = data.country;
        self.otherArr = [NSMutableArray array];
        for (NSDictionary *dic in otherArr) {
            Desitination_Data *otherData = [[Desitination_Data alloc] initWithDictionary:dic];
            [self.otherArr addObject:otherData];
            [otherData release];
        }
    } else {
        self.otherArr = nil;
    }
    
    
    [self scrollViewConten];
    
    [self.hotView reloadData];
    
    [self.otherView reloadData];
    
}

// 搜索按钮
- (void)barButtonAction:(UIButton *)button
{
    SearchBarVC *searchVC = [[SearchBarVC alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    searchVC.hidesBottomBarWhenPushed = YES;

    [searchVC release];
}

// 热门目的地
- (void)hotRegion
{
    self.hotLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.seg.frame.size.height + self.seg.frame.origin.y + 20, self.width - 20, 30)];
    _hotLabel.text = @"热门目的地";
    _hotLabel.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:_hotLabel];
    [_hotLabel release];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.width / 2 - 40, self.height / 3);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20);
    
    
    self.hotView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, _hotLabel.frame.origin.y + 30, self.width - 30, 1250) collectionViewLayout:flowLayout];
    self.hotView.backgroundColor = [UIColor clearColor];
    self.hotView.bounces = NO;
    self.hotView.userInteractionEnabled = YES;
    self.hotView.delegate = self;
    self.hotView.dataSource = self;
    [self.scrollView addSubview:self.hotView];
    [_hotView release];
    
    [self.hotView registerClass:[HotRegionCell class] forCellWithReuseIdentifier:@"cell"];

}

// 其他目的地
- (void)otherDestination
{
    self.otherLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.hotView.frame.size.height + self.hotView.frame.origin.y, self.width - 20, 30)];
    _otherLabel.text = @"其他目的地";
    _otherLabel.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:_otherLabel];
    [_otherLabel release];
    
    UICollectionViewFlowLayout *otherFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    otherFlowLayout.itemSize = CGSizeMake(self.width / 2 - 40, self.height / 6);
    otherFlowLayout.minimumInteritemSpacing = 10;
    otherFlowLayout.minimumLineSpacing = 10;
    otherFlowLayout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20);
    
    
    self.otherView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _otherLabel.frame.size.height + 30, self.width, 1000) collectionViewLayout:otherFlowLayout];
    self.otherView.bounces = NO;
    self.otherView.backgroundColor = [UIColor clearColor];
    self.otherView.userInteractionEnabled = YES;
    self.otherView.delegate = self;
    self.otherView.dataSource = self;
    [self.scrollView addSubview:self.otherView];
    [_otherView release];
    
    [self.otherView registerClass:[OtherCell class] forCellWithReuseIdentifier:@"other"];
}


- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger num = 0;
    
    if (collectionView == self.hotView) {
        num = self.hotArr.count;
    }
    if (collectionView == self.otherView) {
        num = self.otherArr.count;
    }

    return num;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.hotView == collectionView) {
        HotRegionCell *hotCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        hotCell.desit = [self.hotArr objectAtIndex:indexPath.row];
        return hotCell;
    }
    if (self.otherView == collectionView) {
        
        OtherCell *otherCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"other" forIndexPath:indexPath];
        otherCell.desit = [self.otherArr objectAtIndex:indexPath.row];

        return otherCell;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    Desitination_Data *desit = [[Desitination_Data alloc] init];
    if (self.hotView == collectionView) {
        NSLog(@"热门国家");
        desit = [self.hotArr objectAtIndex:indexPath.row];
    }
    if (self.otherView == collectionView) {
        NSLog(@"其他地区");
        desit = [self.otherArr objectAtIndex:indexPath.row];
    }
    
    if (desit.flag == 1) {
        Country_Info_ViewController *country = [[Country_Info_ViewController alloc] init];
        
        country.country_id = desit.country_id;
        [self.navigationController pushViewController:country animated:YES];
        [country release];
    } else {
        City_InfoVC *city = [[City_InfoVC alloc] init];
        city.cityID = desit.country_id;
        [self.navigationController pushViewController:city animated:YES];
        [city release];
    }
}

// 重置scrollView的滑动高度
- (void)scrollViewConten
{
    
    self.hotView.frame = CGRectMake(10, self.hotLabel.frame.origin.y + 30, self.width - 20, (self.height / 3 + 20) * (self.hotArr.count / 2 + self.hotArr.count % 2));
    
    self.otherLabel.frame = CGRectMake(10, self.hotView.frame.origin.y + self.hotView.frame.size.height, self.width - 20, 30);
    self.otherView.frame = CGRectMake(10, self.otherLabel.frame.size.height + self.otherLabel.frame.origin.y, self.width - 20, (self.height / 6 + 10)* (self.otherArr.count / 2 + self.otherArr.count % 2) + 20);
    
    self.scrollView.contentSize = CGSizeMake(0, self.otherView.frame.size.height + self.otherView.frame.origin.y + 49);

    if (self.otherArr.count == 0) {
        self.otherLabel.frame = CGRectMake(0, 0, 0, 0);
        self.otherView.frame = CGRectMake(0, 0, 0, 0);
    }
    
    
}

// 状态栏常亮状态
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)dealloc
{
    
    [_viewBack release];
    [_otherLabel release];
    
    
    [_scrollView release];
    [_seg release];
    [_chauArr release];
    [_hotView release];
    [_otherArr release];
    
    
    [_hotArr release];
    [_dataArr release];
    [_backImage release];
    [_HUD release];
    [_hotLabel release];
    [_otherView release];
    
    [_swipeR release];
    [_swipeL release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
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
