//
//  City_InfoVC.m
//  YouWoYou
//
//  Created by dllo on 15/3/27.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "City_InfoVC.h"
#import "UIButton+Creat.h"
#import "UIImageView+WebCache.h"
#import "NetWorkHandle.h"
#import "CountryData.h"
#import "MgideCell.h"
#import "DiscountCell.h"
#import "AllMgideVC.h"
#import "CountryWebVC.h"
#import "KitsViewController.h"
#import "AllDiscountVC.h"
#import "DiscountDetailVC.h"
#import "KitsListTowTableViewController.h"
#import "MBProgressHUD.h"
#import "TravelVC.h"
#import "DataBaseHandle.h"
#import "AllCityData.h"
CGFloat width;
CGFloat height;


@interface City_InfoVC ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate>

@property (nonatomic, retain)UIScrollView *scrollView;
@property (nonatomic, retain)UIImageView *buttonImage;
@property (nonatomic, retain)UIImageView *imageView;

@property (nonatomic, retain)UIButton *hotButton;
@property (nonatomic, retain)UIImageView *backImage;

@property (nonatomic, retain)NSTimer *timer;

@property (nonatomic, retain)UIScrollView *imageScroll;
@property (nonatomic, retain)UIPageControl *pageControl;
@property (nonatomic, retain)NSMutableArray *photoArr;

@property (nonatomic, retain)UILabel *cnnameLabel;
@property (nonatomic, retain)CountryData *countryData;
@property (nonatomic, retain)UITableView *mguideTableView;
@property (nonatomic, retain)UITableView *disTableView;
@property (nonatomic, retain)UIButton *mguideButton;
@property (nonatomic, retain)UIButton *moreDis;
@property (nonatomic, retain)NSMutableArray *mguideArr;
@property (nonatomic, retain)NSMutableArray *discountArr;
@property (nonatomic, retain)MBProgressHUD *HUD;
@property (nonatomic, retain)DataBaseHandle *dataBase;
@property (nonatomic, retain) UILabel *titleLabel;
@end

@implementation City_InfoVC

- (void)cityInfoData
{
    NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/qyer/footprint/city_detail?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=863970023753015&track_app_version=6.1.0.2&track_app_channel=xiaomi&track_device_info=pisces&track_os=Android4.4.4&app_installtime=1426758347724&city_id=%@&oauth_token=", self.cityID];
    
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSDictionary *countData = [result objectForKey:@"data"];
        self.str = [NSString string];
        self.str = [NSString stringWithFormat:@"%@",[[result objectForKey:@"data"] objectForKey:@"id"] ];


        self.countryData = [[CountryData alloc] initWithDictionary:countData];

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
        
        [self scrollViewHeight];
        
        [self.mguideTableView reloadData];
        [self.disTableView reloadData];
        
        [self photosValue];
        [_countryData release];

    }];
}

- (void)makeView
{
   
    
    self.dataBase = [DataBaseHandle shareInstanse];
    [self.dataBase openDB];
    [self.dataBase createTable];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(0, 2000);
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    [_scrollView release];
    
    
    [self ImagePlayerView];
    
    
    self.buttonImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.imageView.frame.size.height + self.imageView.frame.origin.y, width, 100)];
    _buttonImage.userInteractionEnabled = YES;
    _buttonImage.image = [UIImage imageNamed:@"bgColor.png"];
    [_scrollView addSubview:_buttonImage];
    [_buttonImage release];
    
    self.backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, _buttonImage.frame.origin.y + _buttonImage.frame.size.height, width, 10000)];
    self.backImage.userInteractionEnabled = YES;
    _backImage.image = [UIImage imageNamed:@"bgColor.png"];
    [self.scrollView addSubview:_backImage];
    [_backImage release];
    
    [self discountView];
    
    
    [self mguideView];
    
    
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
        
        [self cityInfoData];
    } completionBlock:^{
        
        
        
        [_HUD removeFromSuperview];
        [_HUD release];
    }];
    
    
    

}

- (void)buttonView
{
    CGFloat buttonWidth = self.buttonImage.frame.size.width;
    CGFloat buttonHeight = self.buttonImage.frame.size.height;
    
    UIButton *hotButton = [UIButton buttonWithFrame:CGRectMake(5, buttonHeight / 12 / 2, buttonWidth / 2 - 2.5 - 5, buttonHeight / 12 / 2 * 10) title:@"实用信息" target:self action:@selector(InfoButtonAction:)];
    [hotButton setBackgroundImage:[UIImage imageNamed:@"taBAR.png"] forState:UIControlStateNormal];
    hotButton.tintColor = [UIColor whiteColor];
    [self.buttonImage addSubview:hotButton];
    
    UIButton *disButton = [UIButton buttonWithFrame:CGRectMake(buttonWidth / 2 + 2.5, buttonHeight / 12 / 2, buttonWidth / 2 - 2.5 - 5, buttonHeight / 12 / 2 * 10) title:@"推荐行程" target:self action:@selector(disButtonAction:)];
    [disButton setBackgroundImage:[UIImage imageNamed:@"taBAR.png"] forState:UIControlStateNormal];
    disButton.tintColor = [UIColor whiteColor];
    [self.buttonImage addSubview:disButton];
    

    UIButton *attButton = [UIButton buttonWithFrame:CGRectMake(5, buttonHeight / 24 * 11 + 5, buttonWidth / 3 - 5 - 2.5, buttonHeight / 24 * 10) title:@"景点" target:self action:@selector(attButtonAction:)];
    attButton.tintColor = [UIColor whiteColor];
    [attButton setBackgroundImage:[UIImage imageNamed:@"taBAR.png"] forState:UIControlStateNormal];
    [self.buttonImage addSubview:attButton];
    
    UIButton *foodButton = [UIButton buttonWithFrame:CGRectMake(buttonWidth / 3 + 2.5, buttonHeight / 24 * 11 + 5, buttonWidth / 3 - 5 - 2.5, buttonHeight / 24 * 10) title:@"美食" target:self action:@selector(foodButtonAction:)];
    foodButton.tintColor = [UIColor whiteColor];
    [foodButton setBackgroundImage:[UIImage imageNamed:@"taBAR.png"] forState:UIControlStateNormal];
    [self.buttonImage addSubview:foodButton];
    
    UIButton *shopButton = [UIButton buttonWithFrame:CGRectMake(buttonWidth / 3 * 2, buttonHeight / 24 * 11 + 5, buttonWidth / 3 - 5, buttonHeight / 24 * 10) title:@"购物" target:self action:@selector(shopButtonAction:)];
    shopButton.tintColor = [UIColor whiteColor];
    [shopButton setBackgroundImage:[UIImage imageNamed:@"taBAR.png"] forState:UIControlStateNormal];
    [self.buttonImage addSubview:shopButton];
    
}

- (void)InfoButtonAction:(UIButton *)button
{
    NSLog(@"hot");
    CountryWebVC *webVC = [[CountryWebVC alloc] init];
    NSString *name = [self.countryData.enname lowercaseString];
    name = [name stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    webVC.cityName = name;
    [self.navigationController pushViewController:webVC animated:YES];
    [webVC release];
    
}
- (void)disButtonAction:(UIButton *)button
{
    NSLog(@"discount");
    
    TravelVC *travel = [[TravelVC alloc] init];
    travel.cityID = self.cityID;
    [self.navigationController pushViewController:travel animated:YES];
    [travel release];
    
}

- (void)attButtonAction:(UIButton *)button
{
    KitsListTowTableViewController *kitslVC = [[KitsListTowTableViewController alloc] init];
    kitslVC.cateId = @"32"; // 32为景点编号
    kitslVC.titleName = @"景点";
    kitslVC.cityNumber = self.str;
    [self.navigationController pushViewController:kitslVC animated:YES];
    [kitslVC release];

    
}

- (void)foodButtonAction:(UIButton *)button
{
    KitsListTowTableViewController *kitslVC = [[KitsListTowTableViewController alloc] init];
    kitslVC.cateId = @"78"; // 78为美食编号
    kitslVC.titleName = @"美食";
    kitslVC.cityNumber = self.str;
    [self.navigationController pushViewController:kitslVC animated:YES];
    [kitslVC release];
}

- (void)shopButtonAction:(UIButton *)button
{
    KitsListTowTableViewController *kitslVC = [[KitsListTowTableViewController alloc] init];
    kitslVC.cateId = @"147"; // 147为购物编号
    kitslVC.titleName = @"购物";
    kitslVC.cityNumber = self.str;
    [self.navigationController pushViewController:kitslVC animated:YES];
    [kitslVC release];
    
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
    self.imageView.userInteractionEnabled = YES;
    self.imageView.alpha = 0.8;
    self.imageView.image = [UIImage imageNamed:@"title3.png"];
    [self.scrollView addSubview:self.imageView];
    [_imageView release];
    
    
    self.cnnameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, height / 2 + 20, width - 80, height / 4)];
    self.cnnameLabel.font = [UIFont systemFontOfSize:25];
    self.cnnameLabel.textColor = [UIColor whiteColor];
    self.cnnameLabel.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.cnnameLabel];
    [_cnnameLabel release];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(width - 60, height / 2 + 20, 40, height / 4);
    button.tintColor =  [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:1];

    if ([self.dataBase selectOne:self.cityID]) {
       
        [button setImage:[UIImage imageNamed:@"collection2.png"] forState:UIControlStateNormal];
         button.tag = 101;
    } else {
        [button setImage:[UIImage imageNamed:@"collection.png"] forState:UIControlStateNormal];
         button.tag = 100;

    }
    
    [self.scrollView addSubview:button];
    [button addTarget:self action:@selector(shoucang:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)shoucang:(UIButton *)button
{
    if (button.tag == 100) {
        
        [button setImage:[UIImage imageNamed:@"collection2.png"] forState:UIControlStateNormal];
        AllCityData *city = [[AllCityData alloc] init];
        city.catename = self.countryData.cnname;
        city.photo = [self.countryData.photos firstObject];
        city.city_id = self.countryData.city_id;
        [self.dataBase inserCity:city];
        [city release];
        button.tag = 101;
        
    } else {

        [button setImage:[UIImage imageNamed:@"collection.png"] forState:UIControlStateNormal];
        AllCityData *city = [[AllCityData alloc] init];
        city.city_id = self.cityID;
        [self.dataBase delCity:city];
        [city release];
        button.tag = 100;
    }
    
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
    if (self.photoArr.count == 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height / 2 + 20)];
        imageView.image = [UIImage imageNamed:@"jiazaizhong.png"];
        [self.imageScroll addSubview:imageView];
        [imageView release];
    }
    self.titleLabel.text = self.countryData.cnname;
    self.cnnameLabel.text = [([self.countryData.cnname stringByAppendingString:@"    "]) stringByAppendingString:self.countryData.enname];

}

// 图片轮播图
- (void)imageScorllPlayer
{
    NSInteger x = width * self.photoArr.count;
    NSInteger temp = self.imageScroll.contentOffset.x + width;
    if (self.photoArr.count != 0) {
        [self.imageScroll setContentOffset:CGPointMake(temp % x, 0) animated:YES];
    }
}



// 微锦囊

- (void)mguideView
{
    
    self.mguideTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, width - 20, 830) style:UITableViewStylePlain];
    self.mguideTableView.bounces = NO;
    self.mguideTableView.delegate = self;
    self.mguideTableView.dataSource = self;
    [self.backImage addSubview:self.mguideTableView];
    [_mguideTableView release];
    
    [_mguideTableView registerClass:[MgideCell class] forCellReuseIdentifier:@"suibian"];
    
    
    self.mguideButton = [UIButton buttonWithFrame:CGRectMake(10, self.mguideTableView.frame.size.height, width - 20, 30) title:@"查看更多" target:self action:@selector(moreMguideAction:)];
    [self.mguideButton setBackgroundImage:[UIImage imageNamed:@"taBAR.png"] forState:UIControlStateNormal];
    self.mguideButton.tintColor = [UIColor whiteColor];
    [self.backImage addSubview:self.mguideButton];
}

- (void)moreMguideAction:(UIButton *)button
{
    AllMgideVC *allMgide = [[AllMgideVC alloc] init];
    allMgide.country = self.countryData.country_id;
    NSLog( @"%@", allMgide.country);
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
    [self.backImage addSubview:_disTableView];
    [_disTableView release];
    
    [self.disTableView registerClass:[DiscountCell class] forCellReuseIdentifier:@"reuse"];
    
    self.moreDis = [UIButton buttonWithFrame:CGRectMake(10, y + 675, width - 20, 30) title:@"查看更多" target:self action:@selector(moreDisAction:)];
    [self.moreDis setBackgroundImage:[UIImage imageNamed:@"taBAR.png"] forState:UIControlStateNormal];
    self.moreDis.tintColor = [UIColor whiteColor];
    [self.backImage addSubview:self.moreDis];
}

- (void)moreDisAction:(UIButton *)button
{
    AllDiscountVC *discount = [[AllDiscountVC alloc] init];
    discount.discountID = self.countryData.country_id;
    [self.navigationController pushViewController:discount animated:YES];
    [discount release];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *str = [NSString string];
    if (tableView == self.mguideTableView) {
        str = @"微锦囊";
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
    NSLog(@"%ld", (long)indexPath.row);
    
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

- (void)scrollViewHeight
{
    if (self.mguideArr.count != 0) {
        self.mguideTableView.frame = CGRectMake(10, 0, width - 20, height / 3 * 2 * self.mguideArr.count + 30);
        self.mguideButton.frame = CGRectMake(10, self.mguideTableView.frame.origin.y + self.mguideTableView.frame.size.height, width - 20, 40);
    } else {
        self.mguideTableView.frame = CGRectMake(10, 0, 0, 0);
        self.mguideButton.frame = CGRectMake(10, self.mguideTableView.frame.origin.y + self.mguideTableView.frame.size.height, 0, 0);
    }
    
    if (self.discountArr.count != 0) {
        
        self.disTableView.frame = CGRectMake(10, self.mguideButton.frame.origin.y + self.mguideButton.frame.size.height, width - 20, height / 2 * self.discountArr.count + 30);
    
        self.moreDis.frame = CGRectMake(10, self.disTableView.frame.origin.y + self.disTableView.frame.size.height, width - 20, 40);
        
    } else {
        self.disTableView.frame = CGRectMake(10, self.mguideButton.frame.origin.y + self.mguideButton.frame.size.height, 0, 0);
        self.moreDis.frame = CGRectMake(10, self.disTableView.frame.origin.y + self.disTableView.frame.size.height, 0, 0);
    }
    
    self.scrollView.contentSize = CGSizeMake(0, self.moreDis.frame.origin.y + self.moreDis.frame.size.height + self.backImage.frame.origin.y + 10);
}

- (void)dealloc
{
    [_cityID release];
    [_str release];
    
    [_timer release];
    [_mguideArr release];
    [_discountArr release];
    [_mguideTableView release];
    [_mguideButton release];
    [_moreDis release];
    
    [_buttonImage release];
    [_scrollView release];
    [_imageScroll release];
    [_imageView release];
    [_cnnameLabel release];
    [_pageControl release];
    [_disTableView release];
    [_photoArr release];
    [_countryData release];
    [_backImage release];
    [_dataBase release];
    [_HUD release];
    [_titleLabel release];
    [_hotButton release];
    
    [super dealloc];
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
