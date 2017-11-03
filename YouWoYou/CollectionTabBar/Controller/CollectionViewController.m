//
//  CollectionViewController.m
//  YouWoYou
//
//  Created by dlios on 15-3-22.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "CollectionViewController.h"
#import "DataBaseHandle.h"
#import "AllCityData.h"
#import "CityCollect_CollectionViewCell.h"
#import "City_InfoVC.h"
@interface CollectionViewController ()<UICollectionViewDataSource , UICollectionViewDelegate>
@property (nonatomic , retain) UICollectionView *collectionView;
@property (nonatomic , retain) NSMutableArray *arr;
@property (nonatomic, retain) UILabel *label;
@end

@implementation CollectionViewController
- (void)dealloc
{
    [_arr release];
    [_label release];
    [_collectionView release];
    [super dealloc];

    
}

- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 2 * self.navigationItem.leftBarButtonItem.width, 80)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"收藏";
    self.navigationItem.titleView = titleLabel;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [titleLabel release];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction:)] autorelease];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.arr = [[DataBaseHandle shareInstanse] selectAll];
   
    self.label = [[UILabel alloc]init];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.text=@" 还没有收藏的城市!";
    self.label.textColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:1];
    [self.view addSubview:_label];
    [_label release];


    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width - 40, self.view.frame.size.height / 4);
    flowLayout.minimumLineSpacing = 20;
    flowLayout.sectionInset = UIEdgeInsetsMake(20 , 20 , 20, 20);
    self.collectionView  = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 113) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[CityCollect_CollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
    [self.view addSubview:self.collectionView];
    [_collectionView release];
    [flowLayout release];
   
    
    
  
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [self.arr count];
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CityCollect_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    AllCityData *city = [self.arr objectAtIndex:indexPath.item];
    [cell setCity:city];
    return cell;
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    City_InfoVC *CityVC = [[City_InfoVC alloc]init];
    AllCityData *city = [self.arr objectAtIndex:indexPath.item];
    CityVC.cityID = city.city_id;
    
    [self.navigationController pushViewController:CityVC animated:YES];
   
    [CityVC  release];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor whiteColor];
    [[DataBaseHandle shareInstanse] openDB];
    self.arr = [[DataBaseHandle shareInstanse] selectAll];
    [self.collectionView reloadData];
    if (self.arr.count != 0) {
        self.label.hidden = YES;

    } else {
        self.label.hidden = NO;
        self.label.frame =  CGRectMake(20, self.view.frame.size.height / 2 - 69, self.view.bounds.size.width - 40, 50);
    }
  
    self.tabBarController.tabBar.hidden = NO;
    
}

// 状态栏常亮状态
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
