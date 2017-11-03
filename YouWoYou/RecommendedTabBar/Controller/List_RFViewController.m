//
//  List_RFViewController.m
//  YouWoYou
//
//  Created by dlios on 15-3-24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "List_RFViewController.h"
#import "RF_property.h"
#import "NetWorkHandle.h"
#import "List_RFTableViewCell.h"
#import "Detail_RFViewController.h"

@interface List_RFViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)NSMutableArray *arr;
@property(nonatomic, retain)UIScrollView *scrollView;
@end

@implementation List_RFViewController
- (void)dealloc{
    [_scrollView release];
    [_arr release];
    [_issue release];
    [_RF release];
    [_tableView release];
    [_mtid release];
    [_name release];
    [super dealloc];
    
}
- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction:)] autorelease];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 2 * self.navigationItem.leftBarButtonItem.width, 80)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = self.name;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    self.navigationItem.titleView = titleLabel;
    [titleLabel release];
   
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:0.8];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[List_RFTableViewCell class] forCellReuseIdentifier:@"resue"];
//    self.tableView.separatorColor = [UIColor clearColor];

    [self.view addSubview: self.tableView];
    [_tableView release];
    [self handleData];

}
#pragma tableView 的协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arr count]  ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    List_RFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resue" ];
    RF_property *RF = [self.arr objectAtIndex:indexPath.row];
    cell.RF = RF;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RF_property *RF = [self.arr objectAtIndex:indexPath.row];

    NSString *str = RF.desc;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
    CGRect rect =   [str boundingRectWithSize:CGSizeMake(self.tableView.frame.size.width, 10000) options: NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    CGFloat height = rect.size.height + 280;
    
    return  height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
       // 清除选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    Detail_RFViewController *DetailVC = [[Detail_RFViewController alloc]init];
    RF_property *RF = [self.arr objectAtIndex:indexPath.row];
   DetailVC.code = RF.code;
   [self.navigationController pushViewController: DetailVC animated:YES];
   
    [DetailVC release];
    
    
}



#pragma 数据处理
- (void)handleData
{
    self.arr = [NSMutableArray array];
  
    NSString *str = [NSString stringWithFormat: @"http://mobileapp.roadqu.com/api/mobile/qunawan/tour/seasonfunplacelist?startpos=0&mtid=%@&token=551005d1b4539&eachpage=20&issue=%@&a_t=1427159237304&sign=41e88110830761f94c626c8c89695d9705c8a894",self.mtid,self.issue];
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        id result= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray *ArrData = [result objectForKey:@"data"];
        for (NSMutableDictionary *dic in ArrData) {
        
            self.RF = [[RF_property alloc]initinitWithDictionary:dic];
            
           [self.arr addObject:self.RF];
            [_RF release];
        
        }
        
        
        [self display];
    }];
    

}

- (void)display
{
    [self.tableView reloadData];
    //加边界
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
 
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

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
