//
//  AllMgideVC.m
//  YouWoYou
//
//  Created by dllo on 15/3/26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "AllMgideVC.h"

#import "AllMgideCell.h"

#import "AllMegideData.h"

#import "NetWorkHandle.h"

#import "KitsViewController.h"

#import "MBProgressHUD.h"

#import "MJRefresh.h"
@interface AllMgideVC ()<UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate>

@property (nonatomic, retain)NSMutableArray *arr;
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)UILabel *labeL;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat heigth;
@property (nonatomic, assign)NSInteger n;
@property (nonatomic, retain)MBProgressHUD *HUD;
@end

@implementation AllMgideVC

- (void)dealloc
{   [_labeL release];
    [_arr release];
    [_tableView release];
    [_country release];
    [_HUD release];
    [super dealloc];
}

- (void)allmgideData
{
    NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/qyer/footprint/mguide_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=863970023753015&track_app_version=6.1.0.2&track_app_channel=xiaomi&track_device_info=pisces&track_os=Android4.4.4&app_installtime=1426758347724&lat=38.883757&lon=121.544935&type=country&id=%@&count=20&page=1", self.country];
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
            AllMegideData *megide = [[AllMegideData alloc] initWithDictionary:dic];
            [self.arr addObject:megide];
            [megide release];
        }
        [self.tableView reloadData];
        [self creatView];
        [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(allmgideNewData)];
        [self.tableView.footer beginRefreshing];
    }];


}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction:)] autorelease];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    self.HUD.labelText = @"努力加载中......";
    self.HUD.minShowTime = 5.0;
    self.HUD.activityIndicatorColor = [UIColor colorWithRed:36.0 / 255.0 green:196.0 / 255.0 blue:145.0 / 255.0 alpha:1];
    self.HUD.progress = 0;
    self.HUD.labelColor = [UIColor colorWithRed:36.0 / 255.0 green:196.0 / 255.0 blue:145.0 / 255.0 alpha:1];
    self.HUD.color = [UIColor clearColor];
    self.HUD.delegate = self;
    [self.HUD show:YES];
    [self.HUD showAnimated:YES whileExecutingBlock:^{
        [self allmgideData];
    } completionBlock:^{
        
        [self.HUD removeFromSuperview];
        [_HUD release];
    }];
    self.n = 2;
    self.labeL = [[UILabel alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.labeL];
    self.labeL.text = @"暂时没有相关信息";
    self.labeL.textColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:1];
    self.labeL.font = [UIFont systemFontOfSize:20];
    self.labeL.textAlignment = NSTextAlignmentCenter;
    self.labeL.hidden = YES;
    [_labeL release];

}
- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatView
{
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 2 * self.navigationItem.leftBarButtonItem.width, 80)];
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentLeft;
    title.text = @"全部微锦囊";
    self.navigationItem.titleView = title;
    [title release];
    
    self.title = @"全部微锦囊";
    
    self.width = self.view.frame.size.width;
    self.heigth = self.view.frame.size.height;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.heigth) style:UITableViewStylePlain];
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [_tableView release];
    
    [self.tableView registerClass:[AllMgideCell class] forCellReuseIdentifier:@"cell"];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.heigth / 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AllMgideCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.megide = [self.arr objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KitsViewController *kitsView = [[KitsViewController alloc] init];
    AllMegideData *data = [self.arr objectAtIndex:indexPath.row];
    kitsView.idNumber = data.megideID;
    [self.navigationController pushViewController:kitsView animated:YES];
    [kitsView release];
}

- (void)allmgideNewData
{
    
    NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/qyer/footprint/mguide_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=863970023753015&track_app_version=6.1.0.2&track_app_channel=xiaomi&track_device_info=pisces&track_os=Android4.4.4&app_installtime=1426758347724&lat=38.883757&lon=121.544935&type=country&id=%@&count=20&page=%ld", self.country, (long)self.n++ ];
    NSLog(@"%@", str);

    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSArray *arr = [result objectForKey:@"data"];
        
        if (arr.count == 0) {
            [self.tableView removeFooter];
        }
        
        for (NSDictionary *dic in arr) {
            AllMegideData *megide = [[AllMegideData alloc] initWithDictionary:dic];
            [self.arr addObject:megide];
            [megide release];
        }
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];

    }];
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
