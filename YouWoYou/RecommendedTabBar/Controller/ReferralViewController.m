//
//  ReferralViewController.m
//  YouWoYou
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "ReferralViewController.h"
#import "NetWorkHandle.h"
#import "RF_property.h"
#import "RFCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "List_RFViewController.h"
@interface ReferralViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic , retain)NSMutableArray *arr;
@property(nonatomic ,retain)UICollectionView *collectionView;
@property(nonatomic ,retain)RF_property *RF;
@end

@implementation ReferralViewController
- (void)dealloc{
    [_RF release];
    [_arr release];
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
    // Do any additional setup after loading the view.
    //设置视图控制器的背景图
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BG.jpg"]];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 2 * self.navigationItem.leftBarButtonItem.width, 80)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"主题推荐";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    self.navigationItem.titleView = titleLabel;
    [titleLabel release];
    //collectionView的初始化和相关设置
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width - 40, 150);
    flowLayout.minimumLineSpacing = 20;
    flowLayout.sectionInset = UIEdgeInsetsMake(20 , 20 , 20, 20);
    self.collectionView  = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 10) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[RFCollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
    [self.view addSubview:self.collectionView];
    [_collectionView release];
    [flowLayout release];
    [self handleData];
    
}
#pragma 数据处理
- (void)handleData
{
    self.arr = [NSMutableArray array];
    NSString *str = @"http://mobileapp.roadqu.com/api/mobile/qunawan/tour/featuredthemeslist?token=551005d1b4539&a_t=1427114218661&sign=d0db3d0949e37456565ac7d192685e4701b824e7";
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        id result= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
         NSMutableArray *ArrData = [result objectForKey:@"data"];
     for (NSMutableDictionary *dic in ArrData) {
           self.RF = [[RF_property alloc]initinitWithDictionary:dic];
            [self.arr addObject:self.RF];
            [_RF release];
            [self.collectionView reloadData];
        }

    }];
  
}



#pragma collectionView 的协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.arr count] - 2 ;
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    RFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    //给cell赋值
    RF_property *RF = [self.arr objectAtIndex:indexPath.item];
    
    cell.RF = RF;
    
    
    return cell;
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    List_RFViewController *ListVC = [[List_RFViewController alloc]init];
    
    RF_property *RF  = [self.arr objectAtIndex:indexPath.item];
    ListVC.mtid = RF.mtid;
    ListVC.name = RF.name;
    ListVC.issue = RF.issue;
    [self.navigationController pushViewController:ListVC animated:YES];
    [ListVC release];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
