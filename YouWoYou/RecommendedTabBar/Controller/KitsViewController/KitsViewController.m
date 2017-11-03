
//
//  KitsViewController.m
//  YouWoYou
//
//  Created by dlios on 15-3-24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "KitsViewController.h"

#import "NetWorkHandle.h"
#import "UIImageView+WebCache.h"
#import "KitsModel.h"
#import "PoisModel.h"
#import "MJRefresh.h"

#import "MBProgressHUD.h"
#import "KitsTableViewCell.h"

#import "KitsDetailViewController.h"

static  NSString *const reuseDis = @"dis";


@interface KitsViewController () <UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate>


@property (nonatomic, retain) NSMutableArray *poisArr;
@property (nonatomic, retain) KitsModel *kitsData;

@property (nonatomic, retain) UIImageView *bigImage;
@property (nonatomic, retain) UIImageView *avatarImage;
@property (nonatomic, retain) UILabel *user_name;
@property (nonatomic, retain) UILabel *titlel;
@property (nonatomic, retain) UILabel *descriptionN;
@property (nonatomic, retain) UILabel *citys;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIScrollView *scroll;

// 文章列表
@property (nonatomic, retain) UITableView *table;
@property (nonatomic, assign) NSInteger i;
@property (nonatomic, retain) MBProgressHUD *HUD;
@end

@implementation KitsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)dealloc
{
    NSLog(@"第一页");
    [_titleLabel release];
    [_idNumber release];
    [_poisArr release];
    [_kitsData release];
    [_bigImage release];
    [_avatarImage release];
    [_user_name release];
    [_titlel release];
    [_descriptionN release];
    [_citys release];
    [_scroll release];
    [_table release];
    [_HUD release];
    [_label release];

    [super dealloc];
}

- (void)handleData
{
    NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/qyer/footprint/mguide_detail?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=865424024133973&track_app_version=6.1.0.2&track_app_channel=xiaomi&track_device_info=armani&track_os=Android4.3&app_installtime=1426735827710&lat=38.88373&lon=121.54491&oauth_token=&id=%@&page=1&count=10", self.idNumber];
    
        [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSDictionary *dic = [result objectForKey:@"data"];
        [self makeView];

        [self loadData:dic];
        [self.HUD hide:YES];
        [self.table reloadData];
        [self makeframe];
        [self.scroll addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(handleDatatwo)];
        [self.scroll.footer beginRefreshing];

    }];
    self.i = 2;   

    
}


#pragma mark 处理数据

- (void)loadData:(NSDictionary *)dic
{
   self.kitsData = [[KitsModel alloc] initWithDictionary:dic];
    
    
    
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = self.kitsData.titleL;
    self.navigationItem.titleView = _titleLabel;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
   
    
    self.poisArr = [NSMutableArray array];
    for (NSDictionary *dic in self.kitsData.pois) {
        PoisModel *pois = [[PoisModel alloc] initWithDictionary:dic];
        [self.poisArr addObject:pois];
        [pois release];
    }
    [self.bigImage setImageWithURLStr:self.kitsData.photo];
    [self.avatarImage setImageWithURLStr:self.kitsData.avatar];
    self.user_name.text = self.kitsData.username;
    self.titlel.text = self.kitsData.titleL;
    self.descriptionN.text = self.kitsData.descriptionN;
    self.descriptionN.numberOfLines = 0;
    [self.descriptionN sizeToFit];
 
 
    
    self.citys.text = self.kitsData.countN;
    self.citys.textColor = [UIColor whiteColor];
    [_kitsData release];
}

#pragma mark 返回按钮
- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 创建视图
- (void)makeView
{
    // 设置返回图标
   
    
    self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + 64)];
//    self.scroll.bounces = NO;
    
    UIImage *bgImage = [UIImage imageNamed:@"bgColor.png"];
    bgImage = [bgImage imageWithAlignmentRectInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    
    UIImageView *imageVIew = [[UIImageView alloc] initWithImage:bgImage];
    imageVIew.tag = 1001;
    [self.view addSubview:imageVIew];
    [imageVIew release];
    [self.view addSubview:self.scroll];
    
    self.bigImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 4 + 20)];
    self.bigImage.contentMode =  UIViewContentModeScaleAspectFill;
    self.bigImage.clipsToBounds = YES;
    [self.scroll addSubview:_bigImage];
    [_bigImage release];
    
    self.label = [[UILabel alloc] init];
   
    [self.scroll addSubview:_label];
    [_label release];
    
    self.citys = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 55, self.view.frame.size.height / 4 - 65, 50, 50)];
    self.citys.font = [UIFont systemFontOfSize:20];
    [self.scroll addSubview:_citys];
    [_citys release];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 75, self.view.frame.size.height / 4 - 20, 100, 30)];
    label2.textColor = [UIColor whiteColor];
    label2.text = @"目的地";
    [self.scroll addSubview:label2];
    [label2 release];
    
    
    
    self.avatarImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height / 4, 50, 50)];
    self.avatarImage.layer.masksToBounds = YES;
    self.avatarImage.layer.cornerRadius = 25;
    [self.scroll addSubview:self.avatarImage];
    [_avatarImage release];
    
    
    
    
    self.user_name = [[UILabel alloc] initWithFrame:CGRectMake(80, self.view.frame.size.height / 4 + 5, 200, 50)];
    self.user_name.alpha = 0.5;
 
    [self.scroll addSubview:_user_name];
    [_user_name release];
    
    self.titlel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height / 4 + 50, self.view.frame.size.width - 20, 30)];
    self.scroll.backgroundColor = [UIColor clearColor];
 
    [self.scroll addSubview:self.titlel];
    [_titlel release];
    
    self.descriptionN = [[UILabel alloc] initWithFrame:CGRectMake(10,   self.view.frame.size.height / 4 + 90, self.view.frame.size.width - 20, 100)];
    
    self.descriptionN.font = [UIFont systemFontOfSize:15];
    [self.scroll addSubview:_descriptionN];

    self.table = [[UITableView alloc] initWithFrame:CGRectMake(10,  self.descriptionN.frame.origin.y + self.descriptionN.frame.size.height + 10, self.scroll.frame.size.width - 20, 100)];
    [self.scroll addSubview:_table];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerClass:[KitsTableViewCell class] forCellReuseIdentifier:reuseDis];
    
    [_table release];
    
    [self.view addSubview:_scroll];
    [_scroll release];
    
}
#pragma mark 重新绘制frame
- (void)makeframe
{
    self.label.frame = CGRectMake(self.view.frame.size.width - 80, self.view.frame.size.height / 4 - 60, 60, 70);
    self.label.backgroundColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:0.8];
    self.label.alpha = 0.5;
    
    self.table.frame = CGRectMake(10, self.descriptionN.frame.size.height + self.descriptionN.frame.origin.y + 20,  self.view.frame.size.width - 20, self.table.contentSize.height);
    self.scroll.contentSize = CGSizeMake(self.view.frame.size.width, self.table.frame.origin.y + self.table.contentSize.height + 40);
    UIImageView *image = (UIImageView *)[self.view viewWithTag:1001];
    image.frame = CGRectMake(0, 0, self.view.frame.size.width, self.scroll.contentSize.height);
}

#pragma mark tableView必备的两个方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.poisArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KitsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseDis forIndexPath:indexPath];
    cell.pois = [self.poisArr objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    KitsDetailViewController *kitsDe = [[KitsDetailViewController alloc] init];
   
    [self.navigationController pushViewController:kitsDe animated:YES];
    PoisModel *pois = [self.poisArr objectAtIndex:indexPath.row];
    kitsDe.idNumber = pois.idNumber;
    kitsDe.lat = pois.lat;
    kitsDe.lon = pois.lng;
    kitsDe.countryname = pois.countryname;
    kitsDe.cityname = pois.cityname;
    [kitsDe release];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

// 设置cell 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    PoisModel *pois = [self.poisArr objectAtIndex:indexPath.row];
    CGRect rect = [pois.descriptionN boundingRectWithSize:CGSizeMake( self.scroll.frame.size.width - 20, 10000) options: NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height + 230;
}

#pragma mark 加载视图
- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 2 * self.navigationItem.leftBarButtonItem.width, 80)];
    [_titleLabel release];
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction:)] autorelease];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
 
    self.HUD = [[MBProgressHUD showHUDAddedTo:self.view animated:YES]retain];
    self.HUD.labelText = @"努力加载中....";
    self.HUD.activityIndicatorColor =  [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:1];
    self.HUD.progress = 0;
    self.HUD.labelColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:1];
    self.HUD.color = [UIColor clearColor];
    self.HUD.delegate = self;
    [self.HUD show:YES];
    [self handleData];
    
//    [self.HUD showAnimated:YES whileExecutingBlock:^{
//        
//        [self makeView];
//        [self handleData];
//        
//    } completionBlock:^{
//        [_HUD removeFromSuperview];
//        [_HUD release];
//    }];

    
   
    
    // Do any additional setup after loading the view.
}
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    
    [_HUD removeFromSuperview];
    [_HUD release];
    _HUD  = nil;
    
}

#pragma mark 上拉加载

- (void)handleDatatwo
{

    NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/qyer/footprint/mguide_detail?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=865424024133973&track_app_version=6.1.0.2&track_app_channel=xiaomi&track_device_info=armani&track_os=Android4.3&app_installtime=1426735827710&lat=38.88373&lon=121.54491&oauth_token=&id=%@&page=%ld&count=10", self.idNumber, self.i++];
  
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        NSDictionary *dic = [result objectForKey:@"data"];
        [self.table.footer beginRefreshing];
        NSLog(@"2222222222222");
        [self loadData1:dic];
        [self.table reloadData];
        [self makeframe];
        [self.scroll.footer endRefreshing];
    }];
}

- (void)loadData1:(NSDictionary *)dic
{
    KitsModel *kits = [[KitsModel alloc] initWithDictionary:dic];
    if (kits.pois.count == 0) {

        [self.scroll removeFooter];
        NSLog(@"%ld 移除成功", self.i);

    }
    NSMutableArray *temparr = [NSMutableArray arrayWithArray:self.poisArr];
    for (NSDictionary *dic in kits.pois) {
    PoisModel *pois = [[PoisModel alloc] initWithDictionary:dic];
    [temparr addObject:pois];
        
    [pois release];
}
    self.poisArr = [NSMutableArray arrayWithArray:temparr];
    [kits release];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.scroll.footer endRefreshing];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
