//
//  DiscountDetailVC.m
//  YouWoYou
//
//  Created by dlios on 15-3-26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "DiscountDetailVC.h"
#import "NetWorkHandle.h"
#import "DiscountDetail_property.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "AFNetworkReachabilityManager.h"
@interface DiscountDetailVC ()
@property(nonatomic ,retain)UIScrollView *scrollView;
@property(nonatomic , retain)UILabel*title_label;
@property(nonatomic , assign)CGFloat widch;
@property(nonatomic , assign)CGFloat height;
@property(nonatomic , retain)DiscountDetail_property *DCD;
@property(nonatomic , retain)UIImageView *imageView;
@property(nonatomic , retain)UILabel*price_dis;
@property(nonatomic , retain)UILabel *list_price_label;
@property(nonatomic , retain)UILabel *end_date_label;
@property(nonatomic , retain)UILabel * detail_label;
@property(nonatomic , retain)UILabel * deal_info_label;
@property(nonatomic , retain)UILabel *label;
@end

@implementation DiscountDetailVC
- (void)dealloc
{
    
    
    [_id_discount release];
    [_deal_info_label release];
    [_detail_label release];
    [_end_date_label release];
    [_list_price_label release];
    [_price_dis release];
    [_imageView release];
    [_DCD release];
    [_scrollView release];
    [_title_label release];
    [_label release];
    [super dealloc];
    
}

- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 2 * self.navigationItem.leftBarButtonItem.width, 80)];
    [_label release];
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction:)] autorelease];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.widch = self.view.bounds.size.width;
    self.height = self.view.bounds.size.height;
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0 ,self.widch , self.height - 64)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    [_scrollView release];
    
    self.title_label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10 ,self.widch - 40, 50)];
    self.title_label.font = [UIFont systemFontOfSize:15];
    self.title_label.textAlignment  =NSTextAlignmentLeft ;
    self.title_label.numberOfLines = 0 ;
    [self.scrollView addSubview:self.title_label];
    [self.title_label release];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 70 ,self.widch  - 20 , 200)];
    [self.scrollView addSubview:self.imageView ];
    [self.imageView release];
    
   
    
    
    self.price_dis = [[UILabel alloc]initWithFrame:CGRectMake(10, 280,self.widch / 2 - 10 , 30)];
    self.price_dis.font = [UIFont systemFontOfSize:18];
    self.price_dis.textColor = [UIColor redColor];
    self.price_dis.textAlignment = NSTextAlignmentLeft;
    [self.scrollView addSubview:self.price_dis];
    [self.price_dis release];
    
    
    
    self.list_price_label = [[UILabel alloc]initWithFrame:CGRectMake(self.widch / 2 , 280 ,self.widch / 2 - 10 ,30)];
    self.list_price_label.font = [UIFont systemFontOfSize:18];
    self.list_price_label.textColor = [UIColor redColor];
    self.list_price_label.textAlignment = NSTextAlignmentLeft;
    [self.scrollView addSubview:self.list_price_label];
    [self.list_price_label release];

    
    self.end_date_label = [[UILabel alloc]initWithFrame:CGRectMake(10 , 320 ,self.widch - 10 ,30)];
    self.end_date_label.font = [UIFont systemFontOfSize:15];
    self.end_date_label.alpha = 0.74;
    self.end_date_label.textAlignment = NSTextAlignmentLeft;
    [self.scrollView addSubview:self.end_date_label];
    [self.end_date_label release];

    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(10 ,360 ,self.widch / 2 - 20 ,30)];
    label4.font = [UIFont systemFontOfSize:18];
    label4.textAlignment = NSTextAlignmentLeft;
    label4.text = @"相关信息";
    [self.scrollView addSubview:label4];
    [label4 release];
    
  
   
   
    
  
    
    
    
    [self handleData];
}
#pragma 数据处理
- (void)handleData
{
    
    NSLog(@"*******%@", self.id_discount);
    NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/lastminute/get_detail?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=354765051111862&track_app_version=6.1.0.2&track_app_channel=baidu&track_device_info=dlxu&track_os=Android4.1.1&app_installtime=1426750876938&lat=38.883789&lon=121.544987&id=%@&oauth_token=&source=DealAllActivity",self.id_discount];
      [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        id result= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableDictionary *dic = [result objectForKey:@"data"];
          self.DCD = [[DiscountDetail_property alloc]initinitWithDictionary:dic];
          [self display];
      }];
}

- (void)display
{
    self.label.text = self.DCD.title;
    self.label.textAlignment = NSTextAlignmentLeft;
    self.label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.label;
    
    self.title_label.text = self.DCD.title;
    [self.imageView setImageWithURLStr:self.DCD.pic];

    NSString *str = @"折扣价 : ";
    self.price_dis.text =[ str stringByAppendingString:self.DCD.price];
    NSString *str2 = [@"原价 : " stringByAppendingString: self.DCD.list_price];
    self.list_price_label.text= [str2 stringByAppendingString:@"元"];
    
    self.end_date_label.text = [ @"结束时间 : " stringByAppendingString:self.DCD.end_date];
    
    
    
    
    NSDictionary *dic = @{NSFontAttributeName :[UIFont systemFontOfSize:18]};
    
    CGRect rect1 = [self.DCD.deal_info boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    

    //简介
    
    self.deal_info_label = [[UILabel alloc]initWithFrame:CGRectMake(10 ,400 ,self.widch  - 20 ,rect1.size.height)];
    self.deal_info_label.font = [UIFont systemFontOfSize:18];
    self.deal_info_label.textAlignment = NSTextAlignmentLeft;
    self.deal_info_label.text = self.DCD.deal_info;
    self.deal_info_label.numberOfLines = 0;
    [self.scrollView addSubview: self.deal_info_label];
    [self.deal_info_label release];
   

    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(10 ,rect1.size.height + 410 ,self.widch / 2 - 20 ,20)];
    label5.text = @"详细信息 ";
    label5.textAlignment = NSTextAlignmentLeft;
    label5.font = [UIFont systemFontOfSize:18];
    [self.scrollView addSubview:label5];
    [label5 release];
    
    
    //详情
    
    
        
    UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(20, rect1.size.height + 410 + 30, self.widch - 40 , 200)];
    text.text = self.DCD.detail;
    text.font = [UIFont systemFontOfSize:15];
    text.editable = NO;
    [self.scrollView addSubview:text];
    text.layer.borderColor = [[UIColor blackColor] CGColor];
    text.layer.borderWidth = 1.0f;
    [text release];
    self.scrollView.contentSize = CGSizeMake(self.widch, rect1.size.height + 410 + 30 + 210);
    
    
    
    
    
    
    
    
    
    
}

//- (void)reach
//{
//    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
//    
//    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//         NSLog(@"%ld",status);
//        if (status > 0 ) {
//           
//            [self handleData];
//        }
//        else{
//            NSLog(@"dsfsdfsfg");
//        
//        
//        }
//        
//        
//        
//    }];
//    
//}
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
