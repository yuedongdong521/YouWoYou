//
//  SearchResultVC.m
//  YouWoYou
//
//  Created by dllo on 15/3/28.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "SearchResultVC.h"
#import "NetWorkHandle.h"
#import "SearchResultCell.h"
#import "SearchData.h"
#import "Country_Info_ViewController.h"
#import "City_InfoVC.h"
#import "KitsDetailViewController.h"
#import "MBProgressHUD.h"

#import "MJRefresh.h"

@interface SearchResultVC ()<UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate>

@property (nonatomic, retain)MBProgressHUD *HUD;
@property (nonatomic, retain)UITableView *resultV;
@property (nonatomic, retain)NSMutableArray *arr;
@end

@implementation SearchResultVC

- (void)dealloc
{
    [_resultStr release];
    [_arr release];
    [_resultV release];
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
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction:)] autorelease];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 2 * self.navigationItem.leftBarButtonItem.width, 80)];
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentLeft;
    title.text = @"搜索结果";
    self.navigationItem.titleView = title;
    [title release];
    
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

        [self resultData];
    } completionBlock:^{
        
        [self.HUD removeFromSuperview];
        [_HUD release];
    
    }];
    
    
}

- (void)creatView
{
    if (self.arr.count != 0) {
        self.resultV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.resultV.delegate = self;
        self.resultV.dataSource = self;
        [self.view addSubview:self.resultV];
        [_resultV release];
        [self.resultV registerClass:[SearchResultCell class] forCellReuseIdentifier:@"cell"];
        self.resultV.separatorStyle = UITableViewCellSeparatorStyleNone;

        
    } else {
        [self.HUD removeFromSuperview];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 2 - 80, self.view.frame.size.width, 40)];
        label.text = @"没有找到你要搜索的内容";
        label.textColor = [UIColor brownColor];
        label.shadowColor = [UIColor brownColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
        [label release];
    }
}

- (void)resultData
{
 
    
    NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/qyer/search/index?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=865424024133973&track_app_version=6.2&track_app_channel=xiaomi&track_device_info=armani&track_os=Android4.3&app_installtime=1426735827710&lat=38.883584&lon=121.544654&type=place&keyword=%@&count=20&page=1", self.resultStr];
    NSLog(@"%@", str);
    str = [str stringByRemovingPercentEncoding];
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSArray *arr = [([result objectForKey:@"data"]) objectForKey:@"entry"];
        self.arr = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            SearchData *data = [[SearchData alloc] initWithDictionary:dic];
            if ([data.label isEqualToString:@"国家"] || [data.label isEqualToString:@"城市"] || [data.label isEqualToString:@"景点"] || [data.label isEqualToString:@"美食"] || [data.label isEqualToString:@"购物"]) {
        
                [self.arr addObject:data];
                [data release];
            }
        }
        [self creatView];
        [self.resultV reloadData];
        [self.resultV addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(resultNewData)];
        [self.resultV.footer beginRefreshing];
    }];
}

- (void)resultNewData
{
    static NSInteger n = 2;
    
    NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/qyer/search/index?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=865424024133973&track_app_version=6.2&track_app_channel=xiaomi&track_device_info=armani&track_os=Android4.3&app_installtime=1426735827710&lat=38.883584&lon=121.544654&type=place&keyword=%@&count=20&page=%ld", self.resultStr, n++];
    NSLog(@"%@", str);
    str = [str stringByRemovingPercentEncoding];
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSArray *arr = [([result objectForKey:@"data"]) objectForKey:@"entry"];
        if (arr.count == 0) {
            [self.resultV removeFooter];
        }
        for (NSDictionary *dic in arr) {
            SearchData *data = [[SearchData alloc] initWithDictionary:dic];
            if ([data.label isEqualToString:@"国家"] || [data.label isEqualToString:@"城市"] || [data.label isEqualToString:@"景点"] || [data.label isEqualToString:@"美食"] || [data.label isEqualToString:@"购物"]) {
                [self.arr addObject:data];
                [data release];
            }
        }
        [self.resultV reloadData];
        [self.resultV.footer endRefreshing];
    }];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height / 6
    ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.searchData = [self.arr objectAtIndex:indexPath.row];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SearchData *data = [self.arr objectAtIndex:indexPath.row];
    if ([data.label isEqualToString:@"国家"]) {
        Country_Info_ViewController *country = [[Country_Info_ViewController alloc] init];
        country.country_id = data.number_id;
        [self.navigationController pushViewController:country animated:YES];
        [country release];
    } else if ([data.label isEqualToString:@"城市"]) {
        City_InfoVC *city = [[City_InfoVC alloc] init];
        city.cityID = data.number_id;
        [self.navigationController pushViewController:city animated:YES];
    } else if ([data.label isEqualToString:@"景点"]) {
        
        KitsDetailViewController *kit = [[KitsDetailViewController alloc] init];
        kit.idNumber = data.number_id;
        [self.navigationController pushViewController:kit animated:YES];
        [kit release];
        
    } else if ([data.label isEqualToString:@"美食"]) {
        
        KitsDetailViewController *kit = [[KitsDetailViewController alloc] init];
        kit.idNumber = data.number_id;
        [self.navigationController pushViewController:kit animated:YES];
        [kit release];
        
    } else if ([data.label isEqualToString:@"购物"]) {
        
        KitsDetailViewController *kit = [[KitsDetailViewController alloc] init];
        kit.idNumber = data.number_id;
        [self.navigationController pushViewController:kit animated:YES];
        [kit release];
        
    }
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
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
