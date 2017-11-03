//
//  KitsListTowTableViewController.m
//  YouWoYou
//
//  Created by dlios on 15-3-30.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "KitsListTowTableViewController.h"
#import "KitsListTableViewController.h"
#import "NetWorkHandle.h"
#import "MapFoodBuyTableViewCell.h"
#import "MapFoodBuyModel.h"
#import "KitsDetailViewController.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
@interface KitsListTowTableViewController () <MBProgressHUDDelegate>

@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, retain) MBProgressHUD *HUD;
@property (nonatomic, retain) UILabel *labeL;
@end

@implementation KitsListTowTableViewController

- (void)dealloc
{
    [_arr release];
    [_HUD release];
    [_labeL release];
    [_titleName release];
    [_idNumber release];
    [_cateId release];
    [_cityNumber release];
    [super dealloc];
}

- (void)handleData
{
    NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/qyer/onroad/poi_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=865424024133973&track_app_version=6.2&track_app_channel=xiaomi&track_device_info=armani&track_os=Android4.3&app_installtime=1426735827710&page=1&city_id=%@&category_id=%@&count=20&types=&orderby=popular&oauth_token=", self.cityNumber, self.cateId];
    
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        NSError *error = nil;
        
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSArray *arr = [[result objectForKey:@"data"] objectForKey:@"entry"];
        if (arr.count == 0) {
            self.labeL.hidden = NO;
        } else {
            self.labeL.hidden = YES;

        }
        self.arr = [NSMutableArray array];
        for (NSDictionary *dic in  arr) {
            MapFoodBuyModel *mfb = [[MapFoodBuyModel alloc] initWithDiction:dic];
            
            [self.arr addObject:mfb];
            [mfb release];
        }
        [self.tableView reloadData];
        [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(hadleDataNew)];
        [self.tableView.footer beginRefreshing];

    }];
    
}

#pragma mark 返回按钮

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[MapFoodBuyTableViewCell class] forCellReuseIdentifier:@"1234"];
    self.clearsSelectionOnViewWillAppear = NO;
    // 消除分区县线条
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction:)] autorelease];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 2 * self.navigationItem.leftBarButtonItem.width, 80)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = self.titleName;
    self.navigationItem.titleView = titleLabel;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [titleLabel release];
    
    self.page = 2;
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    self.HUD.labelText = @"努力加载中....";
    self.HUD.activityIndicatorColor =  [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:1];
    self.HUD.progress = 0;
    self.HUD.labelColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:1];
    self.HUD.color = [UIColor clearColor];
    self.HUD.delegate = self;
    [self.HUD show:YES];
    
    [self.HUD showAnimated:YES whileExecutingBlock:^{
        
        [self handleData];
        [self hadleDataNew];
  
    } completionBlock:^{
        [_HUD removeFromSuperview];
        [_HUD release];
    }];

    self.labeL = [[UILabel alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.labeL];
    self.labeL.text = @"暂时没有相关信息";
    self.labeL.font = [UIFont systemFontOfSize:20];
    self.labeL.textAlignment = NSTextAlignmentCenter;
    self.labeL.hidden = YES;
    [_labeL release];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height / 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MapFoodBuyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1234" forIndexPath:indexPath];
    cell.mfb = [self.arr objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KitsDetailViewController *kits = [[KitsDetailViewController alloc] init];
    [self.navigationController pushViewController:kits animated:YES];
    MapFoodBuyModel *mfb = [self.arr objectAtIndex:indexPath.row];
    kits.idNumber = mfb.idNumber;
    
    [kits release];
    
    
}



- (void)hadleDataNew
{
    NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/qyer/onroad/poi_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=865424024133973&track_app_version=6.2&track_app_channel=xiaomi&track_device_info=armani&track_os=Android4.3&app_installtime=1426735827710&page=%ld&city_id=%@&category_id=%@&count=20&types=&orderby=popular&oauth_token=", (long)self.page++, self.cityNumber, self.cateId];
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
       
        NSError *error = nil;
        id  result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];

        NSArray *arr = [[result objectForKey:@"data"] objectForKey:@"entry"];
        if (arr.count == 0) {
            [self.tableView removeFooter];
        }
        
        for (NSDictionary *dic in  arr) {
        
            MapFoodBuyModel *mfb = [[MapFoodBuyModel alloc] initWithDiction:dic];
            [self.arr addObject:mfb];
            [mfb release];
        }
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
    }];
    

    
}
- (void)viewWillAppear:(BOOL)animated
{    [super viewWillDisappear:animated];

    UIImage *meishi = [UIImage imageNamed:@"juse.png"];
    meishi = [meishi imageWithAlignmentRectInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    UIImage *jingdian = [UIImage imageNamed:@"zise.png"];
    jingdian = [jingdian imageWithAlignmentRectInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    UIImage *gouwu = [UIImage imageNamed:@"red.png"];
    gouwu = [gouwu imageWithAlignmentRectInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    
    if ([self.cateId isEqualToString:@"78"]) {
        [self.navigationController.navigationBar setBackgroundImage:meishi forBarMetrics:UIBarMetricsDefault];
        self.labeL.textColor = [UIColor colorWithRed:(255.0 / 255.0) green:(155.0 / 255.0) blue:(36.0 / 255.0) alpha:1];

    } else if ([self.cateId isEqualToString:@"32"]){
        self.labeL.textColor = [UIColor colorWithRed:(154.0 / 255.0) green:(84.0 / 255.0) blue:(249.0 / 255.0) alpha:1];
        [self.navigationController.navigationBar setBackgroundImage:jingdian forBarMetrics:UIBarMetricsDefault];
    } else {
        [self.navigationController.navigationBar setBackgroundImage:gouwu forBarMetrics:UIBarMetricsDefault];
         self.labeL.textColor = [UIColor colorWithRed:(238.0 / 255.0) green:(54.0 / 255.0) blue:(54.0 / 255.0) alpha:1];
    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    UIImage *naviBg = [UIImage imageNamed:@"taBAR.png"];
    naviBg = [naviBg imageWithAlignmentRectInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    [self.navigationController.navigationBar setBackgroundImage:naviBg forBarMetrics:UIBarMetricsDefault];
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
