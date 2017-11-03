//
//  Discount_List_RFViewController.m
//  YouWoYou
//
//  Created by dlios on 15-3-26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//
#import "Discount_List_RFViewController.h"
#import "DiscountList_Property.h"
#import "NetWorkHandle.h"
#import "DiscountLIstCollectionViewCell.h"
#import "DiscountDetailVC.h"
#import "AFNetworking.h"
#import "AFNetworkReachabilityManager.h"
@interface Discount_List_RFViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>

@end

@implementation Discount_List_RFViewController
- (void)dealloc
{
    [_country_id release];
    [_label release];
    [_arr_screen release];
    [_seg release];
    [_arr_departure release];
    [_arr_times_drange release];
    [_arr_poi release];
    [_arr_type release];
    [_arr_country release];
    [_departure release];
    [_times release];
    [_tableView_right release];
    [_tableView_left release];
    [_tableView_type release];
    [_tableView_times release];
    [_tableView_departure release];
    [_product_type release];
    [_continent_id release];
    [_num_id release];
    [_arr release];
    [_discount release];
    [_collectionView release];
    [super dealloc];
    
    
    
}

- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction:)] autorelease];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 2 * self.navigationItem.leftBarButtonItem.width, 80)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"折扣列表";
    self.navigationItem.titleView = titleLabel;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [titleLabel release];
    // Do any additional setup after loading the view.
    self.arr = [NSMutableArray array];
    self.product_type = @"0";
    self.continent_id = @"0";
    self.country_id = @"0";
    self.departure = @"";
    self.times = @"";
    //collectionView的初始化和相关设置
    self.seg = [[UISegmentedControl alloc]initWithItems:@[@"折扣类型",@"出发地",@"目的地",@"旅行时间"]];
    
    self.seg.frame = CGRectMake(0, 0, self.view.bounds.size.width,60);
    self.seg.tintColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:0.6];
    self.seg.momentary = YES;
    [self.seg addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged ];
    [self.view addSubview:self.seg];
    [self.seg release];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width,self.view.bounds.size.height - 60)];
    self.label.textAlignment = NSTextAlignmentCenter ;
    self.label.userInteractionEnabled = YES;
    self.label.backgroundColor =[UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:1];
    self.label.textColor = [UIColor whiteColor];
    self.label.text = @"抱歉,暂时还没有此类信息";
    [self.view addSubview: self.label];
    [self.label release];
    
    
    self.tableView_type = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width,200)];
    self.tableView_type.delegate = self;
    [self.tableView_type registerClass:[UITableViewCell class] forCellReuseIdentifier:@"A"];
    self.tableView_type.dataSource =self;
    [self.view addSubview:self.tableView_type];
    [self.tableView_type release];
    
    
    self.tableView_times = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width,200)];
    self.tableView_times.delegate = self;
    [self.tableView_times registerClass:[UITableViewCell class] forCellReuseIdentifier:@"B"];
    self.tableView_times.dataSource =self;
    [self.view addSubview:self.tableView_times];
    [self.tableView_times release];
    
    
    self.tableView_departure = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width,200)];
    self.tableView_departure.delegate = self;
    [self.tableView_departure registerClass:[UITableViewCell class] forCellReuseIdentifier:@"C"];
    self.tableView_departure.dataSource =self;
    [self.view addSubview:self.tableView_departure];
    [self.tableView_departure release];
    
    self.tableView_left = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width / 2 ,200)];
    self.tableView_left.delegate = self;
    [self.tableView_left registerClass:[UITableViewCell class] forCellReuseIdentifier:@"D"];
    self.tableView_left.dataSource =self;
    [self.view addSubview:self.tableView_left];
    [self.tableView_left release];
    
    self.tableView_right = [[UITableView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width / 2, 60, self.view.bounds.size.width / 2 ,200)];
    self.tableView_right.delegate = self;
    [self.tableView_right registerClass:[UITableViewCell class] forCellReuseIdentifier:@"E"];
    self.tableView_right.dataSource =self;
    [self.view addSubview:self.tableView_right];
    [self.tableView_right release];
    
    
    
    
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width - 40, 210);
    flowLayout.minimumLineSpacing = 20;
    flowLayout.sectionInset = UIEdgeInsetsMake(20 , 20 , 20, 20);
    self.collectionView  = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height - 113) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[DiscountLIstCollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
    [self.view addSubview:self.collectionView];
    [_collectionView release];
    [flowLayout release];
    [self handleDataScreen];
    [self handleData];
//    [self reach];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView_type) {
        return self.arr_type.count;
    }else if (tableView == self.tableView_departure)
    {
        return self.arr_departure.count;
        
    }else if (tableView == self.tableView_right)
    {
        return self.arr_country.count;
        
    }else if (tableView == self.tableView_left)
    {
        return self.arr_poi.count;
        
        
    }else if (tableView == self.tableView_times)
        
    {
        
        return self.arr_times_drange.count;
    }
    
    return 0 ;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.tableView_type) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"A" forIndexPath:indexPath];
        cell.textLabel.text = [[self.arr_type objectAtIndex:indexPath.row]objectForKey:@"catename"];
        
        return cell;
    }
    else if (tableView == self.tableView_departure)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"C" forIndexPath:indexPath];
        cell.textLabel.text = [[self.arr_departure objectAtIndex:indexPath.row]objectForKey:@"city_des"];
        
        return cell;
    }
    else if (tableView == self.tableView_right)
    {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"E" forIndexPath:indexPath];
        cell.textLabel.text = [[self.arr_country objectAtIndex:indexPath.row]objectForKey:@"country_name"];
        
        return cell;
    }
    else if (tableView == self.tableView_left)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"D" forIndexPath:indexPath];
        cell.textLabel.text = [[self.arr_poi objectAtIndex:indexPath.row]objectForKey:@"continent_name"];
        
        return cell;
    }
    else if (tableView == self.tableView_times)
        
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"B" forIndexPath:indexPath];
        
        cell.textLabel.text = [[self.arr_times_drange objectAtIndex:indexPath.row]objectForKey:@"description"];
        
        return cell;
    }
    
    return nil;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView_type) {
        
        if (indexPath.row == 0 ) {
            self.product_type = @"0";
            
        }else{
            self.product_type= [[self.arr_type objectAtIndex:indexPath.row]objectForKey:@"id"];
            [self.view bringSubviewToFront:self.collectionView];
          
        }
          [self.seg setTitle:[[self.arr_type objectAtIndex:indexPath.row]objectForKey:@"catename"] forSegmentAtIndex:0];
        [self handleDataChange];
        
    }
    else if (tableView == self.tableView_departure)
    {
        if (indexPath.row == 0 ) {
            self.departure= @"";
        }else{
            self.departure= [[self.arr_departure objectAtIndex:indexPath.row]objectForKey:@"city"];
            [self.view bringSubviewToFront:self.collectionView];
            
            
        }
        [self.seg setTitle:[[self.arr_departure objectAtIndex:indexPath.row]objectForKey:@"city_des"] forSegmentAtIndex:1];
        [self handleDataChange];
    }
    else if (tableView == self.tableView_left)
    {
        
        if (indexPath.row == 0 ) {
            self.continent_id= @"0";
        }else{
            
            NSNumber *num= [[self.arr_poi objectAtIndex:indexPath.row]objectForKey:@"continent_id"];
            NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
            self.continent_id= [numberFormatter stringFromNumber:num];
            [numberFormatter release];
         self.arr_country =[[self.arr_poi objectAtIndex:indexPath.row]objectForKey:@"country"];
            [self.tableView_right reloadData];
        }
        
    }
    else if (tableView == self.tableView_right)
    {
        
        
        if (indexPath.row == 0 ) {
            self.country_id= @"0";
        }else{
            NSNumber *num= [[self.arr_country objectAtIndex:indexPath.row]objectForKey:@"country_id"];
            NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
            self.country_id= [numberFormatter stringFromNumber:num];
            [numberFormatter release];
            [self.view bringSubviewToFront:self.collectionView];
            
            
            }
     [self.seg setTitle:[[self.arr_country objectAtIndex:indexPath.row]objectForKey:@"country_name"] forSegmentAtIndex:2];
        [self handleDataChange];
    }
  
    else if (tableView == self.tableView_times)
        
    {
        
        if (indexPath.row == 0 ) {
            self.times= @"";
        }else{
            self.times= [[self.arr_times_drange objectAtIndex:indexPath.row]objectForKey:@"times"];
            [self.view bringSubviewToFront:self.collectionView];
            
          
        }
          [self.seg setTitle:[[self.arr_times_drange objectAtIndex:indexPath.row]objectForKey:@"description"] forSegmentAtIndex:3];
        [self handleDataChange];
    }
    
    
    
    
    
    
    
}
#pragma 选择了哪一个分段
- (void)segmentAction:(UISegmentedControl *)seg
{
    
    if(self.flag == 0)
        switch (seg.selectedSegmentIndex) {
            case 0:
                [self.view bringSubviewToFront:self.tableView_type];
                
                break;
            case 1:
                
                [self.view bringSubviewToFront:self.tableView_departure];
                
                break;
            case 2:
                [self.view bringSubviewToFront:self.tableView_right];
                
                [self.view bringSubviewToFront:self.tableView_left];
                break;
            case 3:
                
                [self.view bringSubviewToFront:self.tableView_times];
                break;
            default:
                break;
        }else{
            
            [self.view bringSubviewToFront:self.collectionView];
        }
    self.flag = !self.flag;
}



#pragma 数据处理

-(void)handleDataScreen
{
    self.arr_country =[NSMutableArray array];
    self.arr_type =[NSMutableArray array];
    self.arr_poi =[NSMutableArray array];
    self.arr_departure =[NSMutableArray array];
    self.arr_times_drange =[NSMutableArray array];
    
    NSString *str = @"http://open.qyer.com/lastminute/get_all_categorys?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=354765051111862&track_app_version=6.1.0.2&track_app_channel=baidu&track_device_info=dlxu&track_os=Android4.1.1&app_installtime=1426750876938&lat=38.883792&lon=121.544921";
    
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableDictionary *dic = [result objectForKey:@"data"];
        self.arr_type = [dic objectForKey:@"type"];
        
        self.arr_poi = [dic objectForKey:@"poi"];
        self.arr_departure = [dic objectForKey:@"departure"];
        self.arr_times_drange = [dic objectForKey:@"times_drange"];
        
        [self.tableView_type reloadData];
        [self.tableView_departure reloadData];
        [self.tableView_times reloadData];
        [self.tableView_left reloadData];
        
    }];
    
    
    
    
    
}

- (void)handleDataChange

{
     self.arr_screen = [NSMutableArray array];
    NSString *str2 =[NSString stringWithFormat: @"http://open.qyer.com/lastminute/get_lastminute_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=354765051111862&track_app_version=6.1.0.2&track_app_channel=baidu&track_device_info=dlxu&track_os=Android4.1.1&app_installtime=1426750876938&lat=38.883789&lon=121.544987&max_id=%@&page_size=10&product_type=%@&continent_id=%@&country_id=%@&departure=%@&times=%@&is_show_pay=1",self.num_id,self.product_type,self.continent_id, self.country_id, self.departure,self.times];
    [NetWorkHandle getDataWithUrl:str2 completion:^(NSData *data) {
        id result= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray *ArrData = [result objectForKey:@"data"];
        for (NSMutableDictionary *dic in ArrData) {
            self.discount = [[DiscountList_Property alloc]initinitWithDictionary:dic];
            [self.arr_screen addObject:self.discount];
            [_discount release];
            
        }
        if (self.arr_screen.count == 0) {
           
            [self.view bringSubviewToFront:self.label];
        
        }
        else{
        self.arr = self.arr_screen;
        [self.view bringSubviewToFront:self.collectionView];
        [self.collectionView reloadData];
        }
        
    }];
    
    
    
    
}

- (void)handleData

{
    if (self.flag_netWork == NO) {
        
        self.flag_netWork = YES;
        NSString *str2 =[NSString stringWithFormat: @"http://open.qyer.com/lastminute/get_lastminute_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=354765051111862&track_app_version=6.1.0.2&track_app_channel=baidu&track_device_info=dlxu&track_os=Android4.1.1&app_installtime=1426750876938&lat=38.883789&lon=121.544987&max_id=%@&page_size=10&product_type=%@&continent_id=%@&country_id=%@&departure=%@&times=%@&is_show_pay=1",self.num_id,self.product_type,self.continent_id, self.country_id, self.departure,self.times];
        
        
        [NetWorkHandle getDataWithUrl:str2 completion:^(NSData *data) {
            id result= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSMutableArray *ArrData = [result objectForKey:@"data"];
            for (NSMutableDictionary *dic in ArrData) {
                self.discount = [[DiscountList_Property alloc]initinitWithDictionary:dic];
                [self.arr addObject:self.discount];
                [_discount release];
                
            }
            
            
            [self.collectionView reloadData];
           // self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 113, 0);
            self.flag_netWork = NO;
            
        }];
    }
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGPoint offect = self.collectionView.contentOffset;
    
    if (offect.y + collectionView.frame.size.height  + 113 > self.collectionView.contentSize.height) {
        
        DiscountList_Property *DL = [self.arr lastObject];
        NSInteger num = [ DL.id_Discount  integerValue];
        NSString *str_id = [NSString stringWithFormat:@"%ld", (num - 1 )];
        self.num_id = str_id;
        [self handleData];
        
        
    }
    
    
    
}

#pragma collectionView 的协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.arr count]  ;
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    DiscountLIstCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    //给cell赋值
    DiscountList_Property *DCL = [self.arr objectAtIndex:indexPath.item];
    
    cell.DCL = DCL;
    
    
    return cell;
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DiscountDetailVC *DDVC = [[DiscountDetailVC alloc]init];
    DiscountList_Property *discount = [self.arr objectAtIndex:indexPath.item];
    DDVC.id_discount = discount.id_Discount;
    [self.navigationController pushViewController:DDVC animated:YES];
    [DDVC release];
    
}

//判断网络情况
//- (void)reach
//{
//    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
//    
//    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        NSLog(@"%ld",status);
//        if (status == 0) {
//            UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请检查网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
//            [alerView show];
//            [alerView release];
//        }  else {
//            [self handleData];
//        }
//        
//    }];
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
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
