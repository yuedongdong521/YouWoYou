//
//  TravelVC.m
//  YouWoYou
//
//  Created by dllo on 15/3/31.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "TravelVC.h"
#import "NetWorkHandle.h"
#import "TravelData.h"
#import "TravelTableViewCell.h"
#import "CountryWebVC.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"

@interface TravelVC ()<UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate>

@property (nonatomic, retain)NSMutableArray *userArr;
@property (nonatomic, retain)NSMutableArray *arr;
@property (nonatomic, retain)NSMutableArray *tempArr;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)UISegmentedControl *seg;
@property (nonatomic, retain)UILabel *label;
@property (nonatomic, retain)MBProgressHUD *HUD;

@end

@implementation TravelVC
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
        
        [self travelData];
        
        
    } completionBlock:^{
        [_HUD removeFromSuperview];
        [_HUD release];
       
    }];

    
}

- (void)dealloc
{
    [_userArr release];
    [_arr release];
    [_tempArr release];
    [_tableView release];
    [_seg release];
    
    [_cityID release];
    [_countryID release];
    
    [_HUD release];
    [_label release];
    [super dealloc];
}

- (void)createView
{
    self.width = self.view.frame.size.width;
    self.height = self.view.frame.size.height;

    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 2 * self.navigationItem.leftBarButtonItem.width, 80)];
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentLeft;
    title.text = @"推荐行程";
    self.navigationItem.titleView = title;
    [title release];
    
    self.tempArr = self.arr;
    NSArray *arr = [NSArray arrayWithObjects:@"官方推荐", @"用户推荐", nil];
  
    
    self.seg = [[UISegmentedControl alloc] initWithItems:arr];
    _seg.frame = CGRectMake(0, 0, self.width, self.height / 12);
    self.seg.selectedSegmentIndex = 0;
    _seg.backgroundColor = [UIColor colorWithRed:36.0 / 255 green:196.0 / 255 blue:145.0 / 255 alpha:1];
    _seg.tintColor = [UIColor whiteColor];
    _seg.layer.borderColor = [[UIColor clearColor] CGColor];
    [_seg addTarget:self action:@selector(segValueChanged) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_seg];
    [_seg release];
    
    UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.seg.frame.size.height, self.width, self.height / 10 * 9)];
    backView.userInteractionEnabled = YES;
    backView.image = [UIImage imageNamed:@"bgColor.png"];
    [self.view addSubview:backView];
    [backView release];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, self.width - 20, self.height - self.seg.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    [backView addSubview:self.tableView];
    [_tableView release];
    [self.tableView registerClass:[TravelTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    NSLog(@"self.tempArr = %@", self.tempArr);
    if (self.tempArr.count == 0) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height / 10 * 9)];
        _label.text = @"暂无推荐";
        _label.font = [UIFont systemFontOfSize:25];
        _label.backgroundColor = [UIColor whiteColor];
        _label.textColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:1];
        [backView addSubview:_label];
        _label.textAlignment = NSTextAlignmentCenter;
        [_label release];
    }
    
}

- (void)segValueChanged
{

    if (self.seg.selectedSegmentIndex == 0) {
        self.tempArr = self.arr;

    } else {
        self.tempArr = self.userArr;
      
    }
    
    if (self.tempArr.count == 0) {
        [self.tableView setHidden:YES];
        self.label.Frame = CGRectMake(0, 0, self.width, self.height / 10 * 9);
    } else {
        self.label.frame = CGRectMake(0, 0, 0, 0);
        [self.tableView setHidden:NO];
    }
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tempArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.height / 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TravelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.data = [self.tempArr objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CountryWebVC *web = [[CountryWebVC alloc] init];
    TravelData *data = [self.tempArr objectAtIndex:indexPath.row];
    web.idStr = data.travel_id;
    [self.navigationController pushViewController:web animated:YES];
    [web release];
}

- (void)travelData
{
    NSLog(@"countryID = %@", self.countryID);
    NSLog(@"cityID = %@", self.cityID);
    if (self.countryID != nil) {
        NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/place/common/get_recommend_plan_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=865424024133973&track_app_version=6.2&track_app_channel=xiaomi&track_device_info=armani&track_os=Android4.3&app_installtime=1426735827710&lat=38.883692&lon=121.545048&page=1&recommand=editor&countryid=%@&screensize=720&type=country", self.countryID];

        [NetWorkHandle postDataWithUrl:str completion:^(NSData *data) {
            
            NSError *error = nil;
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            NSArray *arr = [result objectForKey:@"data"];
            self.arr = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                TravelData *data = [[TravelData alloc] initWithDictionary:dic];
                [self.arr addObject:data];
                [data release];
            }
            self.tempArr = [NSMutableArray array];
            self.tempArr = self.arr;
        }];
        
        NSString *userStr = [NSString stringWithFormat:@"http://open.qyer.com/place/common/get_recommend_plan_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=865424024133973&track_app_version=6.2&track_app_channel=xiaomi&track_device_info=armani&track_os=Android4.3&app_installtime=1426735827710&lat=38.883692&lon=121.545048&page=1&recommand=user&countryid=%@&screensize=720&type=country", self.countryID];

        [NetWorkHandle postDataWithUrl:userStr completion:^(NSData *data) {
            
            NSError *error = nil;
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            NSArray *arr = [result objectForKey:@"data"];
    
            self.userArr = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                TravelData *data = [[TravelData alloc] initWithDictionary:dic];
                [self.userArr addObject:data];
                [data release];
            }
              [self createView];
        }];
        
    } else {
        NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/place/common/get_recommend_plan_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=865424024133973&track_app_version=6.2&track_app_channel=xiaomi&track_device_info=armani&track_os=Android4.3&app_installtime=1426735827710&lat=38.88368&lon=121.545038&page=1&recommand=editor&cityid=%@&screensize=720&type=city", self.cityID];

        [NetWorkHandle postDataWithUrl:str completion:^(NSData *data) {
            
            NSError *error = nil;
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            NSArray *arr = [result objectForKey:@"data"];
            self.arr = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                TravelData *data = [[TravelData alloc] initWithDictionary:dic];
                [self.arr addObject:data];
                [data release];
            }
            
        }];
        
        NSString *userStr = [NSString stringWithFormat:@"http://open.qyer.com/place/common/get_recommend_plan_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=865424024133973&track_app_version=6.2&track_app_channel=xiaomi&track_device_info=armani&track_os=Android4.3&app_installtime=1426735827710&lat=38.88368&lon=121.545038&page=1&recommand=user&cityid=%@&screensize=720&type=city", self.cityID];

        [NetWorkHandle postDataWithUrl:userStr completion:^(NSData *data) {
            
            NSError *error = nil;
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            NSArray *arr = [result objectForKey:@"data"];
            
            self.userArr = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                TravelData *data = [[TravelData alloc] initWithDictionary:dic];
                [self.userArr addObject:data];
                [data release];
            }
             [self createView];
        }];

    }
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
