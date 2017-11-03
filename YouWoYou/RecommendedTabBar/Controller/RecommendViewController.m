//
//  RecommendViewController.m
//  YouWoYou
//
//  Created by dlios on 15-3-22.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//
#import "RecommendViewController.h"
#import "NetWorkHandle.h"
#import "PhotosBroadCastView.h"
#import "RecommendViewData.h"
#import "MguideModel.h"
#import "DiscountModel.h"
#import "SlideModel.h"
#import "DiscountDetailVC.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "MJRefreshHeader.h"
#import "SearchBarVC.h"

#import "SDImageCache.h"

#import "AFNetworking.h"
#import "AFNetworkReachabilityManager.h"


// 主题推荐页面
#import "ReferralViewController.h"

// 旅游锦囊
#import "TipsTableViewCell.h"
static NSString * const reuseTips = @"tips";
#import "KitsViewController.h"

// 折扣页面
#import "DiscountTableViewCell.h"
static NSString *const reuseDiscount = @"discount";
#import "Discount_List_RFViewController.h"

@interface RecommendViewController () <UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate, MBProgressHUDDelegate>

@property (nonatomic, retain) PhotosBroadCastView *photoView;
@property (nonatomic, retain) NSMutableArray *mguideArr;
@property (nonatomic, retain) NSMutableArray *dicountArr;
@property (nonatomic, retain) NSMutableArray *sliderArr;

// 菊花
@property (nonatomic, retain) MBProgressHUD  *HUD;

// 背景scroll
@property (nonatomic, retain) UIScrollView *scroll;

// 穷游锦囊
@property (nonatomic, retain) UITableView *tipsView;

// 折扣
@property (nonatomic, retain) UITableView *discountView;
@property (nonatomic, retain) UIView *viewBack;

@end


@implementation RecommendViewController

- (void)dealloc
{
    NSLog(@"推荐页");
    [_HUD release];
    [_photoView release];
    [_mguideArr release];
    [_dicountArr release];
    [_sliderArr release];
    [_scroll release];
    [_tipsView release];
    [_discountView release];
    [_viewBack release];
    [super dealloc];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.scroll.footer endRefreshing];
}

#pragma mark 处理数据
- (void)makeData:(NSMutableDictionary *)dic
{

    // 处理总数据
    RecommendViewData *recommend = [[RecommendViewData alloc] initWithDictionary:dic];
    self.mguideArr = [NSMutableArray array];
    self.dicountArr = [NSMutableArray array];
    self.sliderArr = [NSMutableArray array];
    
    for (NSDictionary *dic in  recommend.mguide) {
        MguideModel *mguide = [[MguideModel alloc] initWithDictonary:dic];
        [self.mguideArr addObject:mguide];
        [mguide release];
    }
    for (NSDictionary *dic in recommend.discount ) {
        DiscountModel *dis = [[DiscountModel alloc] initWithDictionary:dic];
        [self.dicountArr addObject:dis];
        [dis release];
    }

    for (NSDictionary *dic in recommend.slide) {
       
        SlideModel *slide = [[SlideModel alloc] initWithDictionary:dic];
        [self.sliderArr addObject:slide];
        [slide release];
    }
    
}

#pragma mark 加载数据
- (void)handleData
{
    NSString *str = @"http://open.qyer.com/qyer/recommands/index?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=865424024133973&track_app_version=6.1.0.2&track_app_channel=xiaomi&track_device_info=armani&track_os=Android4.3&app_installtime=1426735827710&oauth_token=";
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSMutableDictionary *dataDic = [result objectForKey:@"data"];
        if (dataDic.allKeys.count > 0) {
            [self makeData:dataDic];
        }
        [self.HUD  hide:YES];
        self.viewBack.hidden = YES;
        self.photoView .photoArr = self.sliderArr;
        [self.photoView .collection reloadData];
        [self.tipsView reloadData];
        [self.discountView reloadData];
        [self makeFrame];
        [self.scroll addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(reLoad)];
    }];
    
}

- (void)handleNewData
{
    
    
    NSString *str = @"http://open.qyer.com/qyer/recommands/index?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=865424024133973&track_app_version=6.1.0.2&track_app_channel=xiaomi&track_device_info=armani&track_os=Android4.3&app_installtime=1426735827710&oauth_token=";
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        NSMutableDictionary *dataDic = [result objectForKey:@"data"];
        
        [self makeData:dataDic];
        self.photoView .photoArr = self.sliderArr;
        [self.photoView .collection reloadData];
        [self.tipsView reloadData];
        [self.discountView reloadData];
        [self makeFrame];
    }];
    [self.scroll.header endRefreshing];
}

#pragma mark 重新绘制scrollframe
- (void)makeFrame
{
    self.tipsView.frame = CGRectMake(10, self.view.frame.size.height / 4 + 90, self.view.frame.size.width - 20, self.tipsView.contentSize.height);
    
    self.discountView.frame = CGRectMake(10, self.tipsView.contentSize.height + self.tipsView.frame.origin.y + 20, self.view.frame.size.width - 20, self.discountView.contentSize.height);
    
    self.scroll.contentSize = CGSizeMake(0, self.discountView.contentSize.height + self.discountView.frame.origin.y + 64);
    UIImageView *image = (UIImageView *)[self.view viewWithTag:1001];
    image.frame = CGRectMake(0, 0, self.view.frame.size.width, self.scroll.contentSize.height + 64);
 
}

#pragma mark 创建背景scrollView
- (void)makeScroll
{
    
    self.scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];

    self.scroll.delegate = self;
    [self.scroll addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(reLoad)];

    UIImage *bgImage = [UIImage imageNamed:@"bgColor.png"];
    bgImage = [bgImage imageWithAlignmentRectInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    
    UIImageView *imageVIew = [[UIImageView alloc] initWithImage:bgImage];
    imageVIew.tag = 1001;
    [self.scroll addSubview:imageVIew];
    [imageVIew release];
    [self.view addSubview:self.scroll];
    
    UIButton *RFbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    RFbutton.frame = CGRectMake(5, self.view.frame.size.height / 4 + 20 + 5, self.view.frame.size.width / 2 - 10, 50);
    [RFbutton addTarget:self action:@selector(RFbuttonAciton:) forControlEvents:UIControlEventTouchUpInside];
    [RFbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    RFbutton.backgroundColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:0.8];
    
    [RFbutton setTitle:@"主题推荐" forState:UIControlStateNormal];
    RFbutton.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.scroll addSubview:RFbutton];
    
    
    UIButton *discoutButton = [UIButton buttonWithType:UIButtonTypeSystem];
    discoutButton.backgroundColor = [UIColor whiteColor];
    discoutButton.frame = CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height / 4 + 20 + 5, self.view.frame.size.width / 2 - 5, 50);
    discoutButton.backgroundColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:0.8];
    [discoutButton setTitle:@"折扣" forState:UIControlStateNormal];
    [discoutButton addTarget:self action:@selector(discoutButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    discoutButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [discoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.scroll addSubview:discoutButton];

    [_scroll release];
    
}
#pragma mark 创建图片导播栏 以及所有视图
- (void)makeColection
{
    
    self.photoView = [[PhotosBroadCastView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 4 + 20)];
    self.photoView .backgroundColor = [UIColor whiteColor];
    [self.scroll addSubview:self.photoView ];
    [_photoView release];
    self.photoView.collection.bounces = NO;

    
    self.tipsView = [[UITableView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height / 4 + 60, self.view.frame.size.width - 20, 200) style:UITableViewStylePlain];
    self.tipsView.backgroundColor = [UIColor whiteColor];
    self.tipsView.delegate = self;
    self.tipsView.dataSource = self;
    
    [self.tipsView registerClass:[TipsTableViewCell class] forCellReuseIdentifier:reuseTips];
    [self.scroll addSubview:self.tipsView];
    [_tipsView release];
    
    self.discountView = [[UITableView alloc] initWithFrame:CGRectMake(10, self.tipsView.frame.origin.y + self.tipsView.frame.size.height, self.view.frame.size.width - 20, 200) style:UITableViewStylePlain];
    self.discountView.backgroundColor = [UIColor whiteColor];
    self.discountView.delegate = self;
    self.discountView.dataSource = self;
    [self.discountView registerClass:[DiscountTableViewCell class] forCellReuseIdentifier:reuseDiscount];
    [self.scroll addSubview:self.discountView];
    [_discountView release];
    

}



#pragma mark 视图加载
- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeScroll];
    [self makeColection];
    [self.photoView addtimer];
    self.viewBack = [[UIView alloc] initWithFrame:self.view.bounds];
    self.viewBack.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(self.view.frame.size.width / 3, 250, self.view.frame.size.width / 3, 50);
    [button setTitleColor:[UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:1] forState:UIControlStateNormal];
    [button setTitle:@"点击刷新" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleData) forControlEvents:UIControlEventTouchUpInside];
    [self.viewBack addSubview:button];
    [self.view addSubview:self.viewBack];
    [_viewBack release];
    
    
    self.HUD = [[MBProgressHUD showHUDAddedTo:self.view animated:YES]retain];
    self.HUD.labelText = @"努力加载中....";
    self.HUD.activityIndicatorColor =  [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:1];
    self.HUD.progress = 0;
    self.HUD.labelColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:1];
    self.HUD.color = [UIColor whiteColor];
    self.HUD.dimBackground = NO;
    [self.HUD show:YES];
    self.HUD.delegate = self;
 
    [self checkNetworkStatus];
   
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"推荐";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    [titleLabel release];
 
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchAction:)] autorelease];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
   
    /// 按钮
    // Do any additional setup after loading the view.
}
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    
    [_HUD removeFromSuperview];
    [_HUD release];
    _HUD  = nil;
    
}
#pragma mark 判断网络
-(void)alert:(NSString *)message{
    
    [self.HUD hide:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];
}

-(void)checkNetworkStatus{
    //根据不同的网络状态改变去做相应处理
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                [self alert:@"网络无连接"];
                break;
            default:[self handleData];
                break;
        }
    }];
    
    //开始监控
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)searchAction:(UIButton *)button
{
    SearchBarVC *search = [[SearchBarVC alloc] init];
    [self.navigationController pushViewController:search animated:YES];
    [search release];
}

#pragma mark 微锦囊的tableView
// 分区顶部高度
- (CGFloat)tableView:(UITableView *)tableView  heightForHeaderInSection:(NSInteger)section
{
    // 分区顶部的高度
    return 30;
}

// 设值分区顶部label

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    static NSString *name;
    if (tableView == _tipsView) {
        name = @"旅游包裹";
    } else {
        name = @"最新折扣";
    }
    return name;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tipsView) {
        return 180;
    } else {
        return 200;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _discountView) {
        return self.dicountArr.count;
    } else {
        return self.mguideArr.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tipsView) {
    TipsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseTips forIndexPath:indexPath];
    cell.mguide = [self.mguideArr objectAtIndex:indexPath.row];
        return cell;
        
    } else {
        DiscountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseDiscount forIndexPath:indexPath];
        cell.discount = [self.dicountArr objectAtIndex:indexPath.row];
        
        return cell;
    
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tipsView) {
        KitsViewController *kitsView = [[KitsViewController alloc] init];
        MguideModel *mguide = [self.mguideArr objectAtIndex:indexPath.row];
        kitsView.idNumber = mguide.idNumber;
        [self.navigationController pushViewController:kitsView animated:YES];
        [kitsView release];

        self.tabBarController.tabBar.hidden = YES;
        [[SDImageCache sharedImageCache] cleanDisk];


        

        
    } else {
        
        DiscountDetailVC *disVC = [[DiscountDetailVC alloc] init];
        DiscountModel *disMo = [self.dicountArr objectAtIndex:indexPath.row];
        disVC.id_discount = disMo.idNumber;
        [self.navigationController pushViewController:disVC animated:YES];
        [disVC release];
        
    }
    // 清除选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark 按钮的方法
- (void)RFbuttonAciton:(UIButton *)button
{
    ReferralViewController *re = [[ReferralViewController alloc] init];
    [self.navigationController pushViewController:re animated:YES];
    [re release];
    
}
- (void)discoutButtonAction:(UIButton *)button
{
    
    Discount_List_RFViewController *DCLVC = [[Discount_List_RFViewController alloc]init];
    [self.navigationController pushViewController:DCLVC animated:YES];
    [DCLVC release];

}


- (void)reLoad
{
    [self handleNewData];
}

// 上拉刷新下拉加载 的补充
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    [self.scroll addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(reLoad)];
//    NSLog(@"创建成功");
// }
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    NSLog(@"移除成功");
//        [self.scroll removeHeader];
//    self.scroll.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//}
// 状态栏常亮状态
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

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
