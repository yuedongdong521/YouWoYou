//
//  Country_Info_ViewController.m
//  YouWoYou
//
//  Created by dllo on 15/3/24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "Country_Info_ViewController.h"

#import "UIButton+Creat.h"

#import "HotRegionCell.h"

#import "HotCityCell.h"

#import "DiscountCell.h"

#import "NetWorkHandle.h"

#import "CountryData.h"

#import "UIImageView+WebCache.h"

#import "MgideCell.h"

#import "HotHeaderCV.h"

#import "MoreCityVC.h"

#import "AllMgideVC.h"

#import "City_InfoVC.h"

#import "CountryWebVC.h"

#import "AllDiscountVC.h"

#import "KitsViewController.h"

#import "DiscountDetailVC.h"

#import "AllMegideData.h"

#import "MBProgressHUD.h"

#import "TravelVC.h"

@interface Country_Info_ViewController ()<UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate,  MBProgressHUDDelegate>

@property (nonatomic, retain)NSMutableArray *photoArr;
@property (nonatomic, retain)UIImageView *hotImageView;

@property (nonatomic, retain)UITableView *tableView;

@property (nonatomic, retain)CountryData *countryData;

@property (nonatomic, retain)NSTimer *timer;

@property (nonatomic, retain)NSMutableArray *hotArr;

@property (nonatomic, retain)NSMutableArray *mguideArr;

@property (nonatomic, retain)NSMutableArray *discountArr;

@property (nonatomic, retain)UITableView *mguideTableView;

@property (nonatomic, retain)UIButton *moreCity;

@property (nonatomic, retain)UIButton *mguideButton;

@property (nonatomic, retain)UIButton *moreDis;

@property (nonatomic, retain)UIImageView *buttonImage;

@property (nonatomic, retain)MBProgressHUD *HUD;

@property (nonatomic, retain) NSString *countryID;
@property (nonatomic, retain) UILabel *titleLabel;
@end

CGFloat width;
CGFloat height;


@implementation Country_Info_ViewController

- (void)dealloc
{
    [_titleLabel release];
    [_timer release];
    [_hotArr release];
    [_mguideArr release];
    [_discountArr release];
    
    [_mguideTableView release];
    [_moreCity release];
    [_mguideButton release];
    [_moreDis release];
    [_buttonImage release];
    
    [_scrollView release];
    [_imageScroll release];
    [_imageView release];
    [_cnnameLabel release];
    [_hotCollectionView release];
    [_disTableView release];
    [_country_id release];
    
    
    [_photoArr release];
    [_hotImageView release];
    [_tableView release];
    [_countryData release];
    
    [_HUD release];
    [_countryID release];
    [super dealloc];
}


- (void)countryInfoData
{
    NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/qyer/footprint/country_detail?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=863970023753015&track_app_version=6.1.0.2&track_app_channel=xiaomi&track_device_info=pisces&track_os=Android4.4.4&app_installtime=1426758347724&country_id=%@&oauth_token=", self.country_id];

    
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
       
        NSDictionary *countData = [result objectForKey:@"data"];
        
        self.countryID = [countData objectForKey:@"id"];
        
        self.countryData = [[CountryData alloc] initWithDictionary:countData];
        
        // 热门城市
        self.hotArr = [NSMutableArray array];
        NSArray *arr = self.countryData.hot_city;
        for (NSDictionary *dic in arr) {
            CountryData *data = [[CountryData alloc] initWithDictionary:dic];
            [self.hotArr addObject:data];
            [data release];
        }
        
        // 微锦囊
        self.mguideArr = [NSMutableArray array];
        NSArray *mArr = self.countryData.hot_mguide;
        for (NSDictionary *dic in mArr) {
            CountryData *data = [[CountryData alloc] initWithDictionary:dic];
            [self.mguideArr addObject:data];
            [data release];
        }
        
        // 新折扣
        self.discountArr = [NSMutableArray array];
        NSArray *disArr = self.countryData.discount;
        for (NSDictionary *dic in disArr) {
            CountryData *data = [[CountryData alloc] initWithDictionary:dic];
            [self.discountArr addObject:data];
            [data release];
        }
        
        [self makeView];
        [self buttonView];
        
        [self scrollHeight];
        
        [self.hotCollectionView reloadData];
        [self.mguideTableView reloadData];
        [self.disTableView reloadData];
        
        [self photosValue];
        
    }];
}

- (void)makeView
{
  
   
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(0, 2000);
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    [_scrollView release];
    
    
    [self ImagePlayerView];
    
    
    self.buttonImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.imageView.frame.size.height + self.imageView.frame.origin.y, width, 60)];
    _buttonImage.userInteractionEnabled = YES;
    _buttonImage.image = [UIImage imageNamed:@"bgColor.png"];
    [_scrollView addSubview:_buttonImage];
    [_buttonImage release];
    
    self.hotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _buttonImage.frame.origin.y + _buttonImage.frame.size.height, width, 10000)];
    self.hotImageView.userInteractionEnabled = YES;
    _hotImageView.image = [UIImage imageNamed:@"bgColor.png"];
    [self.scrollView addSubview:_hotImageView];
    [_hotImageView release];
    
   
    
    [self hotCity];
    
    [self mguideView];
    
    [self discountView];
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(imageScorllPlayer) userInfo:nil repeats:YES];
}
- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction:)] autorelease];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    

    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 2 * self.navigationItem.leftBarButtonItem.width, 80)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.navigationItem.titleView = self.titleLabel;
    [_titleLabel release];
    
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
        
     [self countryInfoData];
    } completionBlock:^{
        [_HUD removeFromSuperview];
        [_HUD release];
    }];
    

    
    
}

- (void)buttonView
{
    CGFloat buttonWidth = self.buttonImage.frame.size.width;
    CGFloat buttonHeight = self.buttonImage.frame.size.height;
    
    
    UIButton *hotButton = [UIButton buttonWithFrame:CGRectMake(10, buttonHeight / 12, buttonWidth / 2 - 15, buttonHeight / 12 * 10) title:@"实用信息" target:self action:@selector(InfoButtonAction:)];
    [hotButton setBackgroundImage:[UIImage imageNamed:@"taBAR.png"] forState:UIControlStateNormal];
    hotButton.tintColor = [UIColor whiteColor];
    [self.buttonImage addSubview:hotButton];
    
    UIButton *disButton = [UIButton buttonWithFrame:CGRectMake(buttonWidth / 2 + 5 , buttonHeight / 12, buttonWidth / 2 - 15, buttonHeight / 12 * 10) title:@"推荐行程" target:self action:@selector(disButtonAction:)];
    [disButton setBackgroundImage:[UIImage imageNamed:@"taBAR.png"] forState:UIControlStateNormal];
    disButton.tintColor = [UIColor whiteColor];
    [self.buttonImage addSubview:disButton];
}

- (void)InfoButtonAction:(UIButton *)button
{
    CountryWebVC *webVC = [[CountryWebVC alloc] init];
    NSString *name = [self.countryData.enname lowercaseString];
    name = [name stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    webVC.countryName = name;
    [self.navigationController pushViewController:webVC animated:YES];
 
}
- (void)disButtonAction:(UIButton *)button
{
    TravelVC *travel = [[TravelVC alloc] init];
    travel.countryID = self.countryID;
    [self.navigationController pushViewController:travel animated:YES];
    [travel release];
    
}


// 展示图片
- (void)ImagePlayerView
{
    
    width = self.view.frame.size.width;
    height = self.view.frame.size.height / 2;
    
    self.imageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height / 2 + 20)];
    self.imageScroll.backgroundColor = [UIColor whiteColor];
    
    self.imageScroll.contentSize = CGSizeMake(width * self.countryData.photos.count, 0);
    
    self.imageScroll.pagingEnabled = YES;
    self.imageScroll.bounces = NO;
    [self.scrollView addSubview:self.imageScroll];
    [_imageScroll release];
    
    
    self.photoArr = [NSMutableArray array];
    for (NSInteger i = 0; i < self.countryData.photos.count; i++) {
        UIImageView *photo = [[UIImageView alloc] initWithFrame:CGRectMake(width * i, 0, width, height / 2 + 20)];
        photo.userInteractionEnabled = YES;
        [self.imageScroll addSubview:photo];
        [self.photoArr addObject:photo];
        [photo release];
    }
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, height / 2 + 20, width, height / 4)];
    self.imageView.alpha = 0.8;
    self.imageView.image = [UIImage imageNamed:@"title3.png"];
    [self.scrollView addSubview:self.imageView];
    [_imageView release];
    
    
    self.cnnameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, height / 2 + 20, width - 20, height / 4)];
    self.cnnameLabel.font = [UIFont systemFontOfSize:25];
    self.cnnameLabel.textColor = [UIColor whiteColor];
    self.cnnameLabel.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.cnnameLabel];
    [_cnnameLabel release];
    
}

// 图片赋值
- (void)photosValue
{
    NSArray *imageArr = self.countryData.photos;
    for (NSInteger i = 0; i < imageArr.count; i++) {
        UIImageView *imageView = [self.photoArr objectAtIndex:i];
        NSString *str = [imageArr objectAtIndex:i];
        [imageView setImageWithURLStr:str Photo:@"jiazaizhong.png"];
    }
    self.titleLabel.text = self.countryData.cnname;
    
    self.cnnameLabel.text = [([self.countryData.cnname stringByAppendingString:@"   "]) stringByAppendingString:self.countryData.enname];
}

// 图片轮播图
- (void)imageScorllPlayer
{

    NSInteger x = width * self.photoArr.count;
    NSInteger temp = self.imageScroll.contentOffset.x + width;
    
    [self.imageScroll setContentOffset:CGPointMake(temp % x, 0) animated:NO];
    
}



// 热门城市

- (void)hotCity
{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((width - 40) / 2, height / 5 * 2);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
    
    flowLayout.headerReferenceSize = CGSizeMake(width - 20, 20);


    self.hotCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, width - 20, 390) collectionViewLayout:flowLayout];
    self.hotCollectionView.bounces = NO;
    self.hotCollectionView.backgroundColor = [UIColor whiteColor];
    self.hotCollectionView.delegate = self;
    self.hotCollectionView.dataSource = self;
    [_hotImageView addSubview:self.hotCollectionView];
    [_hotCollectionView release];

    [self.hotCollectionView registerClass:[HotCityCell class] forCellWithReuseIdentifier:@"cell"];
    
    // 给collectView添加标题
    [self.hotCollectionView registerClass:[HotHeaderCV class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    self.moreCity = [UIButton buttonWithFrame:CGRectMake(10, self.hotCollectionView.frame.size.height + self.hotCollectionView.frame.origin.y - 40, width - 20, 30) title:@"查看全部" target:self action:@selector(moreCityButton:)];
    [self.moreCity setBackgroundImage:[UIImage imageNamed:@"taBAR.png"] forState:UIControlStateNormal];
    self.moreCity.backgroundColor = [UIColor whiteColor];
    self.moreCity.tintColor = [UIColor whiteColor];
    [self.hotImageView addSubview:self.moreCity];
}

- (void)moreCityButton:(UIButton *)button
{
    NSLog(@"morecity");
    
    MoreCityVC *moreCity = [[MoreCityVC alloc] init];
    moreCity.countryID = self.country_id;
    
    [self.navigationController pushViewController:moreCity animated:YES];
    [moreCity release];
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    HotHeaderCV *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    return header;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.hotArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotCityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.country = [self.hotArr objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CountryData *countryData = [self.hotArr objectAtIndex:indexPath.row];
    City_InfoVC *city = [[City_InfoVC alloc] init];
    city.cityID = countryData.city_id;
    [self.navigationController pushViewController:city animated:YES];
    [city release];
}

// 微锦囊

- (void)mguideView
{

    CGFloat y = self.hotCollectionView.frame.origin.y + self.hotCollectionView.frame.size.height + 30;
    self.mguideTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, y + 10, width - 20, 830) style:UITableViewStylePlain];
    self.mguideTableView.bounces = NO;
    self.mguideTableView.delegate = self;
    self.mguideTableView.dataSource = self;
    [self.hotImageView addSubview:self.mguideTableView];
    [_mguideTableView release];
    
    [_mguideTableView registerClass:[MgideCell class] forCellReuseIdentifier:@"suibian"];
    
    
    self.mguideButton = [UIButton buttonWithFrame:CGRectMake(10, y + 835, width - 20, 30) title:@"查看更多" target:self action:@selector(moreMguideAction:)];
    [self.mguideButton setBackgroundImage:[UIImage imageNamed:@"taBAR.png"] forState:UIControlStateNormal];
    self.mguideButton.tintColor = [UIColor whiteColor];
    [self.hotImageView addSubview:self.mguideButton];
}

- (void)moreMguideAction:(UIButton *)button
{
    AllMgideVC *allMgide = [[AllMgideVC alloc] init];
    allMgide.country = self.country_id;
    [self.navigationController pushViewController:allMgide animated:YES];
    [allMgide release];
}


// 新折扣
- (void)discountView
{
    
    CGFloat y = self.mguideTableView.frame.origin.y + self.mguideTableView.frame.size.height + 30;
    
    self.disTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, y + 10, width - 20, 670)];
    self.disTableView.bounces = NO;
    self.disTableView.delegate = self;
    self.disTableView.dataSource = self;
    [self.hotImageView addSubview:_disTableView];
    [_disTableView release];
    
    [self.disTableView registerClass:[DiscountCell class] forCellReuseIdentifier:@"reuse"];
    
    
    
    self.moreDis = [UIButton buttonWithFrame:CGRectMake(10, y + 675, width - 20, 30) title:@"查看更多" target:self action:@selector(moreDisAction:)];
    [self.moreDis setBackgroundImage:[UIImage imageNamed:@"taBAR.png"] forState:UIControlStateNormal];
    self.moreDis.tintColor = [UIColor whiteColor];
    [self.hotImageView addSubview:self.moreDis];
}

- (void)moreDisAction:(UIButton *)button
{
    AllDiscountVC *discount = [[AllDiscountVC alloc] init];
    discount.discountID = self.countryData.city_id;
    [self.navigationController pushViewController:discount animated:YES];
    [discount release];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *str = [NSString string];
    if (tableView == self.mguideTableView) {
        str = @"旅游包裹";
    }
    if (tableView == self.disTableView) {
        str = @"最新折扣";
    }
    return str;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num = 0;
    if (self.mguideTableView == tableView) {
      
          num = self.mguideArr.count;
    
    }
    if (self.disTableView == tableView) {
        num = self.discountArr.count;
    }
    
    return num;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.mguideTableView == tableView) {
        
        return height / 3 * 2;
        
    } else {
        return height / 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.disTableView == tableView) {
        DiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
        cell.country = [self.discountArr objectAtIndex:indexPath.row];

        return cell;
    } else {
        MgideCell *cell = [tableView dequeueReusableCellWithIdentifier:@"suibian" forIndexPath:indexPath];
        cell.country = [self.mguideArr objectAtIndex:indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.mguideTableView == tableView) {
        
        KitsViewController *kitsView = [[KitsViewController alloc] init];
        CountryData *countryData = [self.mguideArr objectAtIndex:indexPath.row];
        kitsView.idNumber = countryData.city_id;
       
        [self.navigationController pushViewController:kitsView animated:YES];
        [kitsView release];
        self.tabBarController.tabBar.hidden = YES;

    } else {
        DiscountDetailVC *DDVC = [[DiscountDetailVC alloc]init];
         CountryData *data = [self.discountArr objectAtIndex:indexPath.item];
        DDVC.id_discount = data.city_id;
        [self.navigationController pushViewController:DDVC animated:YES];
        [DDVC release];
        
    }
}

- (void)scrollHeight
{
    
    if (self.hotArr.count != 0) {
        self.hotCollectionView.frame = CGRectMake(10, 0, width - 20, (height / 5 * 2 + 10)* (self.hotArr.count / 2 + self.hotArr.count % 2) + 20);
       
        self.moreCity.frame = CGRectMake(10, self.hotCollectionView.frame.size.height + self.hotCollectionView.frame.origin.y, width - 20, 40);
        self.scrollView.contentSize = CGSizeMake(0, self.moreCity.frame.origin.y + self.moreCity.frame.size.height + self.hotImageView.frame.origin.y);
    } else {
        self.hotCollectionView.frame = CGRectMake(10, 0, 0, 0);
        self.moreCity.frame = CGRectMake(10, self.hotCollectionView.frame.size.height + self.hotCollectionView.frame.origin.y, 0, 0);
        self.scrollView.contentSize = CGSizeMake(0, height * 2);
    }
    
    
    if (self.mguideArr.count != 0) {
        self.mguideTableView.frame = CGRectMake(10, self.moreCity.frame.origin.y + self.moreCity.frame.size.height, width - 20, height / 3 * 2 * self.mguideArr.count + 40);

        self.mguideButton.frame = CGRectMake(10, self.mguideTableView.frame.size.height + self.mguideTableView.frame.origin.y - 10, width - 20, 40);
        self.scrollView.contentSize = CGSizeMake(0, self.mguideButton.frame.size.height + self.mguideButton.frame.origin.y + self.hotImageView.frame.origin.y);
    } else {
        self.mguideTableView.frame = CGRectMake(10, self.moreCity.frame.origin.y + self.moreCity.frame.size.height, 0, 0);
        self.mguideButton.frame = CGRectMake(10, self.moreCity.frame.origin.y + self.moreCity.frame.size.height, 0, 0);
        self.scrollView.contentSize = CGSizeMake(0, self.moreCity.frame.size.height + self.moreCity.frame.origin.y + self.hotImageView.frame.origin.y);
   
    }
    
    if (self.discountArr.count != 0) {
        self.disTableView.frame = CGRectMake(10, 30 + self.mguideTableView.frame.origin.y + self.mguideTableView.frame.size.height, width - 20, height / 2 * self.discountArr.count + 30);
        
        self.moreDis.frame = CGRectMake(10, self.disTableView.frame.origin.y + self.disTableView.frame.size.height, width - 20, 40);
         self.scrollView.contentSize = CGSizeMake(0, self.moreDis.frame.origin.y + self.moreDis.frame.size.height + self.hotImageView.frame.origin.y + 10.);
        
    } else  {
        self.disTableView.frame = CGRectMake(10, 30 + self.mguideTableView.frame.origin.y + self.mguideTableView.frame.size.height, 0, 0);
        self.moreDis.frame = CGRectMake(10, 30 + self.mguideTableView.frame.origin.y + self.mguideTableView.frame.size.height, 0, 0);
        self.scrollView.contentSize = CGSizeMake(0, self.mguideButton.frame.origin.y + self.mguideButton.frame.size.height + self.hotImageView.frame.origin.y);
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
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
