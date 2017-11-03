//
//  Detail_RFViewController.m
//  YouWoYou
//
//  Created by dlios on 15-3-24.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "Detail_RFViewController.h"
#import "NetWorkHandle.h"
#import "RF_property.h"
#import "Image_RFCollectionViewCell.h"
#import "DoubleLabel.h"
#import "Detail_RFTableViewCell.h"
#import "PhotoWall_RFViewController.h"
@interface Detail_RFViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,UIScrollViewDelegate, UICollectionViewDelegateFlowLayout , UITableViewDataSource , UITableViewDelegate>
@property (nonatomic, retain) UILabel *label;

@end

@implementation Detail_RFViewController
- (void)dealloc
{
  
    [_label release];
    [_tableView release];
    [_address_doubleLabel release];
    [_type_doubleLabel release];
    [_opentime_doubleLabel release];
    [_arr_tag release];
    [_tag_doubleLabel release];
    [_BigscrollView release];
    [_arr_pic release];
    [_collectionView_pic release];
    [_desc_Label release];
    [_timer release];
    [_arr release];
    [_collectionView release];
    [_RF release];
    [_scrollView release];
    [_code release ];
    [super dealloc];
   
}
- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction:)] autorelease];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 2 * self.navigationItem.leftBarButtonItem.width, 80)];
    self.label.textColor = [UIColor whiteColor];

    self.label.textAlignment = NSTextAlignmentLeft;
    self.navigationItem.titleView = self.label;
    [_label release];

    //大的scrollView
    self.BigscrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    self.BigscrollView.backgroundColor =[UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:0.8];
    [self.view addSubview: self.BigscrollView ];
    [self.BigscrollView release];
    
    
    //小的scrollView
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200 )];
    [self.BigscrollView addSubview: self.scrollView];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.scrollView release];
    
    //collectionView的初始化和相关设置
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, 200);
    flowLayout.scrollDirection =UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    self.collectionView  = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200 ) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[Image_RFCollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
    [self.scrollView addSubview:self.collectionView];
    [_collectionView release];
    [flowLayout release];
    
  //简介
    self.desc_Label =[[UILabel alloc]init];
    self.desc_Label.numberOfLines = 0 ;
    [self.desc_Label sizeToFit];
    self.desc_Label.backgroundColor = [UIColor clearColor];
    [self.BigscrollView addSubview: self.desc_Label];
    [self.desc_Label release];
    

    [self handleData];
}


#pragma 数据处理
- (void)handleData
{
    //数组的初始化
    self.arr_tag = [NSMutableArray array];
    self.arr_pic = [NSMutableArray array];
    self.arr = [NSMutableArray array];
    
    NSString *str = [NSString stringWithFormat: @"http://mobileapp.roadqu.com/api/mobile/qunawan/poi/detail?uid=null&token=551005d1b4539&code=%@&a_t=1427187302574&sign=866255e6b0cfd8e678c16efe9c7a7f4f38dd8063",self.code];
    
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        id result= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableDictionary *dic = [result objectForKey:@"data"];
        
        self.RF = [[RF_property alloc]initinitWithDictionary:dic];
        
        [_RF release];
        
        //滚动的图片的地址加入到数组里
        NSMutableArray *Arr = self.RF.impress;
        for (NSMutableDictionary *dic in Arr) {
            
            [self.arr addObject:[dic objectForKey:@"url"]];
            
        }
        [self.arr insertObject:[self.arr lastObject] atIndex:0];
        [self.arr addObject:[self.arr objectAtIndex:1]];
        
        //照片的地址加入到数组里
        NSMutableArray *Arr_pic = self.RF.pic;
        for (NSMutableDictionary *dic in Arr_pic) {
            [self.arr_pic addObject:[dic objectForKey:@"url"]];
        }
        
        //标签name加入到标签的数组里
        
        NSMutableArray *Arr_ptags = self.RF.ptags;
        for (NSMutableDictionary *dic in Arr_ptags) {
            [self.arr_tag addObject:[dic objectForKey:@"name"]];
        }
        
        //简介的自适应
        NSDictionary *dic_des = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
        self.rect =   [self.RF.desc boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 40, 10000) options: NSStringDrawingUsesLineFragmentOrigin attributes:dic_des context:nil];
        
        
        [self initPicCollectionView];
        [self display]; 
        [self changeFram];
      
    }];
    
    
    
}


#pragma 简介以下控件的初始化

- (void)initPicCollectionView
{
    
    //初始化照片墙的CollectionView
    
    UICollectionViewFlowLayout *flowLayout_pic = [[UICollectionViewFlowLayout alloc]init];
    flowLayout_pic.itemSize = CGSizeMake( self.view.bounds.size.width * 1 / 4 ,110 );
    flowLayout_pic.scrollDirection =UICollectionViewScrollDirectionHorizontal;
    flowLayout_pic.minimumLineSpacing = 5;
    flowLayout_pic.sectionInset = UIEdgeInsetsMake(5 , 5 , 5, 5);
    self.collectionView_pic = [[UICollectionView alloc]initWithFrame:CGRectMake(20, 220 + self.rect.size.height + 20 , self.view.bounds.size.width  *3 / 4, 120) collectionViewLayout:flowLayout_pic];
    self.collectionView_pic.delegate = self;
    self.collectionView_pic.dataSource = self;
    self.collectionView_pic.backgroundColor = [UIColor clearColor];
    self.collectionView_pic.scrollEnabled = NO;
    [self.collectionView_pic registerClass:[Image_RFCollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
    [self.BigscrollView addSubview:self.collectionView_pic];
    [_collectionView_pic release];
    [flowLayout_pic release];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame =CGRectMake(self.view.bounds.size.width - 40, 220 + self.rect.size.height + 20 + 40 ,40 ,50 );
    [button setBackgroundImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.BigscrollView addSubview: button];

    
    // "基本信息"
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20,220 + self.rect.size.height + 20  + 140, 70, 30)];
    label.text = @"基本信息";
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    label.textColor = [UIColor whiteColor];
    [self.BigscrollView addSubview: label];
    [label release];
    
   //标签
    self.tag_doubleLabel = [[DoubleLabel alloc]initWithFrame:CGRectMake(20,220 + self.rect.size.height + 20  + 140 + 50, self.view.bounds.size.width - 40, 30)];
    [self.BigscrollView addSubview:self.tag_doubleLabel];
    [_tag_doubleLabel release];
    
    //类型
    self.type_doubleLabel=[ [DoubleLabel alloc]initWithFrame:CGRectMake(20,220 + self.rect.size.height + 20  + 140 + 50 + 40 , self.view.bounds.size.width - 40, 30)];
    [self.BigscrollView addSubview:self.type_doubleLabel];
    [_type_doubleLabel release];
   
    //开放时间
    self.opentime_doubleLabel = [[DoubleLabel alloc]initWithFrame:CGRectMake(20,220 + self.rect.size.height + 20  + 140 + 50 + 40 + 40 , self.view.bounds.size.width - 40, 30)];
    [self.BigscrollView addSubview:self.opentime_doubleLabel];
    [_opentime_doubleLabel release];
    
    //地址
    self.address_doubleLabel = [[DoubleLabel alloc]initWithFrame:CGRectMake(20,220 + self.rect.size.height + 20  + 140 + 50 + 40 + 40 + 40  , self.view.bounds.size.width - 40, 50)];
    
    [self.BigscrollView addSubview: self.address_doubleLabel];
    [_address_doubleLabel release];
    
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(20,220 + self.rect.size.height + 20  + 140 + 50 + 40 + 40 + 40 + 70, 70, 30)];
    label2.text = @"相关资讯";
    label2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    label2.textColor = [UIColor whiteColor];
    [self.BigscrollView addSubview: label2];
    [label2 release];
    
    //资讯
    self.tableView  =[[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
   [self.tableView registerClass:[Detail_RFTableViewCell class] forCellReuseIdentifier:@"A"];
    [self.BigscrollView addSubview:self.tableView];
    [self.tableView release];
    
}


#pragma 修改坐标

- (void)changeFram
{  //scrollView的偏移量
    self.scrollView.contentOffset = CGPointMake(self.collectionView.contentSize.width, 0);
    
    //简介
    self.desc_Label.frame = CGRectMake(20, 220, self.view.bounds.size.width - 40, self.rect.size.height );
    
    //照片墙
    self.collectionView_pic.frame =CGRectMake(20, 220 + self.rect.size.height + 20 , self.view.bounds.size.width - 60, 120);
    
    
    //大的scrollView
    self.BigscrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 220 + self.rect.size.height + 20  + 140 + 50 + 40 + 150 + 40 + 50  + self.tableView.contentSize.height );
    NSLog(@"%lf    22222222", self.tableView.contentSize.height);

}



#pragma 显示

- (void)display
{
    self.desc_Label.text = self.RF.desc;
    self.label.text = self.RF.name;
    [self addtimer];
    
    //滚动图片大数据加载
    [self.collectionView reloadData];
    
    //照片墙图片大数据加载
    [self.collectionView_pic reloadData];
    
    //标签
    
    self.tag_doubleLabel.leftLabel.text = @"标签 :  ";
    self.tag_doubleLabel.rightLabel.text = [self.arr_tag componentsJoinedByString:@"  "];
    
    //类型
    self.type_doubleLabel.leftLabel.text = @"类型 :  ";
    self.type_doubleLabel.rightLabel.text = self.RF.type;
    
    //开放时间
    self.opentime_doubleLabel.leftLabel.text = @"开放时间 :  ";
    self.opentime_doubleLabel.rightLabel.text= self.RF.opentime;
    
    //地址
    self.address_doubleLabel.leftLabel.text = @"地址 :  ";
    self.address_doubleLabel.rightLabel.text = self.RF.address;
    self.address_doubleLabel.rightLabel.numberOfLines = 0 ;
    
 [self.tableView reloadData];
   self.tableView.frame = CGRectMake(20,220 + self.rect.size.height + 20  + 140 + 50 + 40 + 40 + 40 + 70 + 40 , self.view.bounds.size.width - 40, self.tableView.contentSize.height);
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return [self.RF.ext count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Detail_RFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"A" forIndexPath:indexPath];
    cell.name = [[self.RF.ext objectAtIndex:indexPath.row]objectForKey:@"name"];
    cell.content =[[self.RF.ext objectAtIndex:indexPath.row]objectForKey:@"content"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [[self.RF.ext objectAtIndex:indexPath.row]objectForKey:@"content"];

    NSDictionary *dic_des = @{NSFontAttributeName:[UIFont systemFontOfSize:20]};
    CGRect  rect2  = [str boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 40, 10000) options: NSStringDrawingUsesLineFragmentOrigin attributes:dic_des context:nil];
    
   
         return rect2.size.height + 30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)buttonAction:(UIButton *)button
{
    PhotoWall_RFViewController *photoWallVC = [[PhotoWall_RFViewController alloc]init];
    
    photoWallVC.arr = self.arr_pic;
    [self.navigationController pushViewController:photoWallVC animated:YES];
    [photoWallVC release];
   
}
#pragma 动画

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   if (_collectionView.contentOffset.x > self.view.bounds.size.width * (self.arr.count - 3) ) {
        [_collectionView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    
    if (_collectionView.contentOffset.x < 0) {
        [_collectionView setContentOffset:CGPointMake(self.view.bounds.size.width * (self.arr.count -3), 0) animated:NO];
    }
    
}


- (void)addtimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(time) userInfo:nil repeats:YES];
    // 循环播放
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}
static  NSInteger p = 0;


- (void)time
{
    if (p == ([self.arr count] - 3 )) {
        p = 0;
    } else {
        p++;
    }
    
    self.collectionView.contentOffset = CGPointMake(self.collectionView.bounds.size.width * p, 0);
}





#pragma collectionView 的协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.collectionView) {
         return   [self.RF.impress count];
    }else if(collectionView == self.collectionView_pic){
        if(self.arr_pic.count <= 3 )
        {
            return [self.arr_pic count];
        }else
        { return 3;}
    }
    
   
    return 0;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    Image_RFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    //给cell赋值

    if (collectionView == self.collectionView) {
        cell.imgStr = [self.arr objectAtIndex:indexPath.item + 1];

    }
    else if(collectionView == self.collectionView_pic)
    {
        
        cell.imgStr = [self.arr_pic objectAtIndex:indexPath.item];
        
    }
    
    return cell;
    
    
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
