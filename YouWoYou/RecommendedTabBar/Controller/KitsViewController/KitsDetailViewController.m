//
//  KitsDetailViewController.m
//  YouWoYou
//
//  Created by dlios on 15-3-25.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "KitsDetailViewController.h"
#import "NetWorkHandle.h"
#import "DetailData.h"
#import "UIImageView+WebCache.h"
#import "StarView.h"
#import "KitsListTableViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "MBProgressHUD.h"




#import "PhotoMainViewController.h"

#import "KitsDetailTableViewCell.h"
static NSString *const reuseComent = @"coment";

#import "Comment_listData.h"
#import "CommentTableViewController.h"
@interface KitsDetailViewController () <UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate>
@property (nonatomic, retain) MBProgressHUD *HUD;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIScrollView *scroll;
// 照片
@property (nonatomic, retain) UIImageView *bigImage;
@property (nonatomic, retain) UILabel *numberOfPhotos;
@property (nonatomic, retain) UILabel *photoName;

// 标题
@property (nonatomic, retain) UILabel *chineseName;
@property (nonatomic, retain) UILabel *englishname;

@property (nonatomic, retain) StarView *starView;
@property (nonatomic, retain) UILabel *beentocounts;

// 简介
@property (nonatomic, retain) UILabel *jianjie;
@property (nonatomic, retain) UILabel *introduction;
@property (nonatomic, assign) BOOL jianFlag;

// 地址
@property (nonatomic, retain) UILabel *addressName;
@property (nonatomic, retain) UILabel *address;

// 路线
@property (nonatomic, retain) UILabel *waytoName;
@property (nonatomic, retain) UILabel *wayto;

// 电话
@property (nonatomic, retain) UILabel *phoneName;
@property (nonatomic, retain) UILabel *phone;

// 门票
@property (nonatomic, retain) UILabel *priceName;
@property (nonatomic, retain) UILabel *price;

// 时间
@property (nonatomic, retain) UILabel *opentime;
@property (nonatomic, retain) UILabel *opentimeName;

// 网站
@property (nonatomic, retain) UILabel *site;
@property (nonatomic, retain) UILabel *siteName;

// 小贴士
@property (nonatomic, retain) UILabel *tipsName;
@property (nonatomic, retain) UILabel *tips;
@property (nonatomic, assign) BOOL tipsFlag;


// 评论数组
@property (nonatomic, retain) NSMutableArray *comment_list;
@property (nonatomic, retain) UITableView *comment_listTable;
@property (nonatomic, retain) UIButton *commentButton;
@property (nonatomic, retain) NSString *commentcounts;

// 景点, 美食购物按钮 周边
@property (nonatomic, retain) UILabel *label1;
@property (nonatomic, retain) UIButton *jingdian;
@property (nonatomic, retain) UIButton *meishi;
@property (nonatomic, retain) UIButton *gouwu;

// 跳转下一页面所需参数

@property (nonatomic, retain) NSString *cateId;

@property (nonatomic, retain) NSString *imageURL;

@property (nonatomic, retain) UIAlertView *altvlert;

@end

@implementation KitsDetailViewController


- (void)dealloc
{
    NSLog(@"dierye");

     _altvlert.delegate = nil;
    [_idNumber release];
    [_countryname release];
    [_cityname release];
    [_titleLabel release];
    [_imageURL release];
    [_label release];
    [_HUD release];
    [_scroll release];
    // 照片
    [_bigImage release];
    [_numberOfPhotos release];
    [_photoName release];
    
    // 标题
    [_chineseName release];
    [_englishname release];
    
    [_starView release];
    [_beentocounts release];
    
    // 简介
    [_jianjie release];
    [_introduction release];
    
    // 地址
    [_addressName release];
    [_address release];
    
    // 路线
    [_waytoName release];
    [_wayto release];
    
    // 电话
    [_phoneName release];
    [_phone release];
    
    // 门票
    [_priceName release];
    [_price release];
    
    // 时间
    [_opentime release];
    [_opentimeName release];
    
    // 网站
    [_site release];
    [_siteName release];
    
    // 小贴士
    [_tipsName release];
    [_tips release];
    
    // 评论数组
    [_comment_list release];
    [_comment_listTable release];
    [_commentButton release];
    [_commentcounts release];
    
    // 景点, 美食购物按钮 周边
    [_label1 release];
    [_jingdian release];
    [_meishi release];
    [_gouwu release];

    [_lat release];
    [_lon release];
    [_cateId release];
   
    [_altvlert release];
    [super dealloc];
}

#pragma mark 加载数据
- (void)loadData:(NSDictionary *)dic
{
    DetailData *detail = [[DetailData alloc] initWithDictionary:dic];
    self.comment_list = [NSMutableArray array];
    for (NSDictionary *dic in detail.comment_list) {
        Comment_listData *com = [[Comment_listData alloc] initWithDictiony:dic];
        [self.comment_list addObject:com];
        [com release];
    }
#warning 赋值
    // 赋值
    self.lat = detail.lat;
    self.lon = detail.lng;
    self.commentcounts = detail.commentcounts;
    self.photoName.text = @"照片";
    
    [self.bigImage setImageWithURLStr:detail.photo Photo:@"loading.jpg"];
    self.numberOfPhotos.text = detail.img_count;
    self.imageURL = detail.photo;
    
    // 判断姓名的是否有
    if (detail.chinesename.length == 0) {
        self.chineseName.text = detail.firstname;
    } else {
        self.chineseName.text = detail.chinesename;
    }
    if (detail.englishname.length == 0) {
        self.englishname.text = detail.secnodname;
    } else {
        self.englishname.text = detail.englishname;
    }
    self.englishname.numberOfLines = 0;
    [self.englishname sizeToFit];
    
    
    self.starView.starNumber = [detail.gradeN integerValue] * 5;
    self.beentocounts.text = [NSString stringWithFormat:@"%@人去过",detail.beentocounts];
    
    self.introduction.text = detail.introduction;
    self.introduction.numberOfLines = 3;
    [self.introduction sizeToFit];
    [self makeFrame1];
    [self chanedetail:detail];
    [self.comment_listTable reloadData];
    [self makeScrollFrame];
}
#pragma mark 判断是否各个数据有值
- (void)chanedetail:(DetailData *)detail
{
//    CGFloat width = self.scroll.frame.size.width - 40;
#pragma mark 创建标题
  
    self.titleLabel.textColor = [UIColor whiteColor];
    
    if (detail.chinesename.length != 0) {
        self.titleLabel.text = detail.chinesename;
    } else {
        self.titleLabel.text = detail.firstname;
    }
    self.navigationItem.titleView = self.titleLabel;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    // 地址
    if ((detail.address.length != 0) && (detail.address != nil)) {
        self.addressName.text = @"地址";
        self.address.text = detail.address;
        self.address.numberOfLines = 0;
        
    } else{
        self.addressName.text = @"";
        self.address.text = @"";
    }
    // 路线
    if ((detail.wayto.length != 0) && (detail.wayto != nil))
    {
        self.waytoName.text = @"路线";
        self.wayto.text = detail.wayto;
        self.wayto.numberOfLines = 0;
    } else {
        self.waytoName.text = @"";
        self.wayto.text = @"";

    }
    // 电话
    if ((detail.phone.length != 0) && (detail.phone != nil)) {
        self.phoneName.text = @"电话";
        self.phone.text = detail.phone;
        self.phone.numberOfLines = 0;
    } else {
        self.phoneName.text = @"";
        self.phone.text = @"";
        }
    // 门票
    if ((detail.price.length != 0) && (detail.price != nil)) {
        self.priceName.text = @"门票";
        self.price.text = detail.price;
        self.price.numberOfLines = 0;
    } else {
        self.priceName.text = @"";
        self.price.text = @"";

    }
    // 开放时间
    if ((detail.opentime.length != 0) && (detail.price != nil)) {
        self.opentimeName.text = @"时间";
        self.opentime.text = detail.opentime;
        self.opentime.numberOfLines = 0;
        [self.opentime sizeToFit];
    } else {
        self.opentimeName.text = @"";
        self.opentime.text = @"";

    }
    
    // 小贴士
    if ((detail.tips.length != 0) && (detail.tips != nil) ){
        self.tipsName.text = @"小贴士";
        self.tips.text = [detail.tips stringByReplacingOccurrencesOfString:@"<br>"withString:@""];
       
        self.tips.numberOfLines = 3;
    } else {
        self.tipsName.text = @"";
        self.tips.text = @"";
    }
    [self.commentButton setTitle:[NSString stringWithFormat:@"查看全部%@评论", self.commentcounts] forState:UIControlStateNormal];

}

#pragma mark 重新绘制frame
- (void)makeFrame1
{
    self.label.frame = CGRectMake(20, self.scroll.frame.size.height / 4 - 20, 90, 30);
    self.label.backgroundColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:0.8];
    self.label.alpha = 0.5;
    self.starView.frame = CGRectMake(20, self.englishname.frame.origin.y + self.englishname.frame.size.height, 100, 40);
    self.beentocounts.frame = CGRectMake(100, self.englishname.frame.origin.y + self.englishname.frame.size.height + 5, 100, 30);
    

}

#pragma mark 重新绘制ScrollFrame
- (void)makeScrollFrame
{
    CGFloat width = self.scroll.frame.size.width - 40;
    
    self.jianjie.frame = CGRectMake(20, self.beentocounts.frame.origin.y + self.beentocounts.frame.size.height, 100, 30);
    self.jianjie.text = @"简介";
    
    self.introduction.frame = CGRectMake(20, self.jianjie.frame.size.height + self.jianjie.frame.origin.y, self.scroll.frame.size.width - 40, self.introduction.frame.size.height);
    [self.introduction sizeToFit];

    // 地址
    self.addressName.frame = CGRectMake(20, self.introduction.frame.size.height + self.introduction.frame.origin.y + 10, width, 0);
    [self.addressName sizeToFit];

    self.address.frame = CGRectMake(20, self.addressName.frame.size.height + self.addressName.frame.origin.y, width, 0);
    [self.address sizeToFit];
    
    // 路线
    
    self.waytoName.frame = CGRectMake(20, self.address.frame.size.height + self.address.frame.origin.y + 5, width, 0);
    [self.waytoName sizeToFit];

    self.wayto.frame = CGRectMake(20, self.waytoName.frame.size.height + self.waytoName.frame.origin.y, width, 0);
    [self.wayto sizeToFit];
    // 电话
  
    self.phoneName.frame = CGRectMake(20, self.wayto.frame.size.height + self.wayto.frame.origin.y + 10, width, 0);
    [self.phoneName sizeToFit];

    self.phone.frame = CGRectMake(20, self.phoneName.frame.size.height + self.phoneName.frame.origin.y, width, 0);
    [self.phone sizeToFit];
    // 门票
    self.priceName.frame = CGRectMake(20, self.phone.frame.size.height + self.phone.frame.origin.y + 10, width, 0);
    [self.priceName sizeToFit];

    self.price.frame = CGRectMake(20, self.priceName.frame.size.height + self.priceName.frame.origin.y, width, 0);
    [self.price sizeToFit];


    
    // 开放时间
    self.opentimeName.frame = CGRectMake(20, self.price.frame.size.height + self.price.frame.origin.y + 10, width, 0);
    [self.opentimeName sizeToFit];

    self.opentime.frame = CGRectMake(20, self.opentimeName.frame.size.height + self.opentimeName.frame.origin.y, width, 0);
    [self.opentime sizeToFit];


    
    // 小贴士
    self.tipsName.frame = CGRectMake(20, self.opentime.frame.size.height + self.opentime.frame.origin.y + 10, width, 0);
    [self.tipsName sizeToFit];

    self.tips.frame = CGRectMake(20, self.tipsName.frame.size.height + self.tipsName.frame.origin.y , width, 0);
    [self.tips sizeToFit];


    self.label1.frame = CGRectMake(20, self.tips.frame.size.height + self.tips.frame.origin.y, width, 30);
    self.jingdian.frame = CGRectMake(20, self.label1.frame.size.height + self.label1.frame.origin.y, (width - 20) / 3, 30);
    self.meishi.frame = CGRectMake(width / 3 + 20, self.label1.frame.size.height + self.label1.frame.origin.y, (width - 20) / 3, 30);
     self.gouwu.frame = CGRectMake(width * 2 / 3 + 20, self.label1.frame.size.height + self.label1.frame.origin.y, (width - 20) / 3, 30);
    

    if (self.comment_list.count == 0) {
        
        self.comment_listTable.frame = CGRectMake(0, self.gouwu.frame.origin.y + self.gouwu.frame.size.height, 0, 0);
        self.commentButton.frame = CGRectMake(0, self.comment_listTable.frame.origin.y + self.comment_listTable.frame.size.height, 0, 0);

    } else {
    
    self.comment_listTable.frame = CGRectMake(0, self.gouwu.frame.origin.y + self.gouwu.frame.size.height + 20, self.scroll.frame.size.width, self.comment_listTable.contentSize.height);
//        if ( [self.commentcounts integerValue] < self.comment_list.count) {
        
            self.commentButton.frame = CGRectMake(0, self.comment_listTable.frame.origin.y + self.comment_listTable.frame.size.height, self.scroll.frame.size.width, 50);
            
//        } else {
//            
//            self.commentButton.frame = CGRectMake(0, self.comment_listTable.frame.origin.y + self.comment_listTable.frame.size.height,  self.scroll.frame.size.width, 50);
//        }
    }

    // scroll视图
    self.scroll.contentSize = CGSizeMake(0, self.commentButton.frame.origin.y + self.commentButton.frame.size.height + 49 + 64);
    
    
//    UIImageView *image = (UIImageView *)[self.view viewWithTag:1001];
//    image.frame = self.scroll.bounds;
}



#pragma mark 处理数据

- (void)handleData
{
    NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/qyer/footprint/poi_detail?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=865424024133973&track_app_version=6.1.0.2&track_app_channel=xiaomi&track_device_info=armani&track_os=Android4.3&app_installtime=1426735827710&lat=38.883509&lon=121.544836&client_id=qyer_android&poi_id=%@&oauth_token=&screensize=1280", self.idNumber];
    
    [NetWorkHandle postDataWithUrl:str completion:^(NSData *data) {
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSDictionary *dic = [result objectForKey:@"data"];
        if (dic.allKeys.count > 0) {
        [self loadData:dic];
        }
    }];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share.png"] style:UIBarButtonItemStylePlain  target:self action:@selector(rightBarButtonAction:)] autorelease];
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeView];
    [self handleData];
    
    
  
    
    
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
        
        [self makeView];
        [self handleData];
        
    } completionBlock:^{
        
        
        
        [_HUD removeFromSuperview];
        [_HUD release];
    }];

    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction:)] autorelease];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 2 * self.navigationItem.leftBarButtonItem.width, 80)];
    [_titleLabel release];

}


#pragma mark 返回按钮
- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightBarButtonAction:(UIBarButtonItem *)button
{
    
    NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageURL]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths firstObject];
    NSString  *imagePath = [path stringByAppendingString:@"/11.jpg"];
    // 把newImage 写入本地
    [imageData writeToFile:imagePath atomically:YES];

    NSLog(@"%@", imagePath);
    NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/qyer/footprint/poi_detail?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=865424024133973&track_app_version=6.1.0.2&track_app_channel=xiaomi&track_device_info=armani&track_os=Android4.3&app_installtime=1426735827710&lat=%@&lon=%@&client_id=qyer_android&poi_id=%@&oauth_token=&screensize=1280", self.lat, self.lon, self.idNumber];
    NSString *str1 = [NSString string];
    if (self.introduction.text.length <= 80) {
        str1 = self.introduction.text;
    } else {
        str1 = [self.introduction.text substringToIndex:80];
        str1 = [str1 stringByAppendingString:@"......."];
    }
    NSString *content = [NSString stringWithFormat:@"%@,%@,%@-%@:%@", self.countryname, self.cityname,self.chineseName.text, self.englishname.text,str1];
    
    
    
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:@"请输入分享信息"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"由我游"
                                                  url:str
                                          description:@"感谢你的分享"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:nil arrowDirect:UIPopoverArrowDirectionUp];
    
    
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                 NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                    self.altvlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"分享成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                                    [self.altvlert show];
                                    [self.altvlert release];
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                    self.altvlert = [[UIAlertView alloc] initWithTitle:@"提示" message:[error errorDescription] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                                    [self.altvlert show];
                                    [self.altvlert release];
                                }
                            }];
    
}

#pragma mark 创建视图
- (void)makeView
{
   
#pragma mark 添加返回按钮
    
    
    CGFloat width = self.scroll.frame.size.width - 40;

    self.view.backgroundColor = [UIColor whiteColor];
    self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + 49)];
    // 关掉回弹效果
    self.scroll.bounces = NO;

    [self.view addSubview:self.scroll];
    
    self.bigImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.scroll.frame.size.width, self.scroll.frame.size.height / 4 + 20)];
    self.bigImage.contentMode = UIViewContentModeScaleAspectFill;
    self.bigImage.clipsToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoAciton)];
    self.bigImage.userInteractionEnabled = YES;
    [self.bigImage addGestureRecognizer:tap];
    [tap release];
    
    [self.scroll addSubview:self.bigImage];
    [_bigImage release];
    
    self.label = [[UILabel alloc] init];
    
    [self.scroll addSubview:self.label];
    [_label release];
    
    self.photoName = [[UILabel alloc] initWithFrame:CGRectMake(20, self.scroll.frame.size.height / 4 - 20, 50, 30)];
    
    self.photoName.textAlignment = NSTextAlignmentCenter;
    self.photoName.font = [UIFont systemFontOfSize:13];

    self.photoName.textColor = [UIColor whiteColor];
    [self.scroll addSubview:self.photoName];
    [_photoName release];
    
    self.numberOfPhotos = [[UILabel alloc] initWithFrame:CGRectMake(60, self.scroll.frame.size.height / 4 - 20, 50, 30)];
    self.numberOfPhotos.textColor = [UIColor whiteColor];
    self.numberOfPhotos.font = [UIFont systemFontOfSize:13];
    self.numberOfPhotos.textAlignment = NSTextAlignmentCenter;

    [self.scroll addSubview:self.numberOfPhotos];
    [_numberOfPhotos release];
    
    self.chineseName  = [[UILabel alloc] initWithFrame:CGRectMake( 20,self.scroll.frame.size.height / 4 + 30,  200, 30)];
    [self.scroll addSubview:self.chineseName];
    [_chineseName release];
    
    self.englishname = [[UILabel alloc] initWithFrame:CGRectMake(20, self.scroll.frame.size.height / 4 + 30 + 30, 200, 30)];
    self.englishname.alpha = 0.5;
    [self.scroll addSubview:self.englishname];
    [_englishname release];
    
    self.starView = [[StarView alloc] initWithFrame:CGRectMake(20, self.englishname.frame.origin.y + self.englishname.frame.size.height, 100, 40)];
    [self.scroll addSubview:self.starView];
    [_starView release];
    
    self.beentocounts = [[UILabel alloc] initWithFrame:CGRectMake(100, self.englishname.frame.origin.y + 30, 200, 30)];
    self.beentocounts.font = [UIFont systemFontOfSize:15];
    self.beentocounts.alpha = 0.5;
    [self.scroll addSubview:self.beentocounts];
    [_beentocounts release];
    
    // 简介
    
    self.jianjie = [[UILabel alloc] initWithFrame:CGRectMake(20, self.beentocounts.frame.origin.y + self.beentocounts.frame.size.height, 100, 30)];
    [self.scroll addSubview:self.jianjie];
    [_jianjie release];
    
    self.introduction = [[UILabel alloc] initWithFrame:CGRectMake(20, self.jianjie.frame.origin.y + self.jianjie.frame.size.height, self.scroll.frame.size.width - 40, 100)];
    [self.scroll addSubview:self.introduction];
    self.introduction.font = [UIFont systemFontOfSize:13];
    self.introduction.alpha = 0.7;
    self.introduction.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(introduction:)];
    [self.introduction addGestureRecognizer:tap1];
    [tap1 release];
    self.jianFlag = YES;
    [_introduction release];
    CGFloat height = 0;
    // 地址
    self.addressName = [[UILabel alloc] initWithFrame:CGRectMake(20, self.introduction.frame.size.height + self.introduction.frame.origin.y, width, height)];
    [self.scroll addSubview:self.addressName];
    [_addressName release];
    self.address = [[UILabel alloc] initWithFrame: CGRectMake(20, self.addressName.frame.size.height + self.addressName.frame.origin.y, width, height)];
    [self.scroll addSubview:self.address];
    self.address.font = [UIFont systemFontOfSize:13];
    self.address.alpha = 0.7;
    [_address release];

    // 路线
    self.waytoName = [[UILabel alloc] initWithFrame:CGRectMake(20, self.address.frame.size.height + self.address.frame.origin.y, width, height)];
    [self.scroll addSubview:self.waytoName];
    [_waytoName release];
    
    self.wayto = [[UILabel alloc] initWithFrame:CGRectMake(20, self.waytoName.frame.size.height + self.waytoName.frame.origin.y, width, height)];
    [self.scroll addSubview:self.wayto];
    self.wayto.font = [UIFont systemFontOfSize:13];
    self.wayto.alpha = 0.7;
    [_wayto release];

    // 电话
   
    
    self.phoneName = [[UILabel alloc] initWithFrame:CGRectMake(20, self.wayto.frame.size.height + self.wayto.frame.origin.y, width, height)];
    [self.scroll addSubview:self.phoneName];
    [_phoneName release];
    
    self.phone = [[UILabel alloc] initWithFrame: CGRectMake(20, self.phoneName.frame.size.height + self.phoneName.frame.origin.y, width, height)];
    [self.scroll addSubview:self.phone];
    self.phone.font = [UIFont systemFontOfSize:13];
    self.phone.alpha = 0.7;
    [_phone release];
    // 门票
    self.priceName = [[UILabel alloc] initWithFrame:CGRectMake(20, self.phone.frame.size.height + self.phone.frame.origin.y, width, height)];
    [self.scroll addSubview:self.priceName];
    [_priceName release];
    
    self.price = [[UILabel alloc] initWithFrame:CGRectMake(20, self.priceName.frame.size.height + self.priceName.frame.origin.y, width, height)];
    [self.scroll addSubview:self.price];
    self.price.font = [UIFont systemFontOfSize:13];
    self.price.alpha = 0.7;
    [_price release];
    
    // 时间
    self.opentimeName = [[UILabel alloc] initWithFrame:CGRectMake(20, self.opentimeName.frame.size.height + self.opentimeName.frame.origin.y, width, height)];
    [self.scroll addSubview:self.opentimeName];
    [_opentimeName release];
    
    self.opentime = [[UILabel alloc] initWithFrame:CGRectMake(20, self.price.frame.size.height + self.price.frame.origin.y, width, height)];
    [self.scroll addSubview:self.opentime];
    self.opentime.font = [UIFont systemFontOfSize:13];
    self.opentime.alpha = 0.7;
    [_opentime release];
    

    // 小贴士
    self.tipsName = [[UILabel alloc] initWithFrame:CGRectMake(20, self.tipsName.frame.size.height + self.tipsName.frame.origin.y, width, height)];
    [self.scroll addSubview:_tipsName];
    [_tipsName release];

    self.tips = [[UILabel alloc] initWithFrame:CGRectMake(20, self.opentime.frame.size.height + self.opentime.frame.origin.y, width, height)];
    [self.scroll addSubview:self.tips];
    self.tips.font = [UIFont systemFontOfSize:13];
    self.tips.alpha = 0.7;
    [_tips release];
    self.tipsFlag = YES;
    self.tips.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tipsAction:)];
    [self.tips addGestureRecognizer:tap2];
    [tap2 release];
    
    self.label1 = [[UILabel alloc] init];
    self.label1.text = @"查看周边";
    [self.scroll addSubview:_label1];
    [_label1 release];
    
    self.jingdian = [UIButton buttonWithType:UIButtonTypeSystem];
    self.jingdian.backgroundColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:0.8];
    [self.jingdian setTitle:@"景点" forState:UIControlStateNormal];
    [self.jingdian setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.jingdian addTarget:self action:@selector(jingdian:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroll addSubview:_jingdian];
    
    self.meishi = [UIButton buttonWithType:UIButtonTypeSystem];
    self.meishi.backgroundColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:0.8];
    [self.meishi setTitle:@"美食" forState:UIControlStateNormal];
    [self.meishi setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.meishi addTarget:self action:@selector(meishi:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroll addSubview:_meishi];

    self.gouwu = [UIButton buttonWithType:UIButtonTypeSystem];
    self.gouwu.backgroundColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:0.8];
    [self.gouwu setTitle:@"购物" forState:UIControlStateNormal];
    [self.gouwu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.gouwu addTarget:self action:@selector(gouwu:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroll addSubview:_gouwu];

    
    
    self.comment_listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, self.tips.frame.size.height + self.tips.frame.origin.y + 30, self.scroll.frame.size.width, height) style:UITableViewStylePlain];
    [self.scroll addSubview:self.comment_listTable];
    [_comment_listTable release];
    self.comment_listTable.delegate = self;
    self.comment_listTable.dataSource = self;

    [self.comment_listTable registerClass:[KitsDetailTableViewCell class] forCellReuseIdentifier:reuseComent];
 
    self.commentButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.commentButton addTarget:self action:@selector(connment:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroll addSubview:self.commentButton];
    [self.commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.commentButton.backgroundColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:0.8];

    
//
    
}
#pragma mark 3个按钮方法
- (void)jingdian:(UIButton *)button
{       KitsListTableViewController *kitslVC = [[KitsListTableViewController alloc] init];
    kitslVC.idNumber = self.idNumber;
    kitslVC.cateId = @"32"; // 32为景点编号
    kitslVC.lat = self.lat;
    kitslVC.lon = self.lon;
    kitslVC.titleName = @"景点";
    
    [self.navigationController pushViewController:kitslVC animated:YES];
    [kitslVC release];
}
- (void)meishi:(UIButton *)button
{
    KitsListTableViewController *kitslVC = [[KitsListTableViewController alloc] init];
    kitslVC.idNumber = self.idNumber;
    kitslVC.cateId = @"78"; // 78为美食编号
    kitslVC.titleName = @"美食";

    kitslVC.lat = self.lat;
    kitslVC.lon = self.lon;
    
    [self.navigationController pushViewController:kitslVC animated:YES];
    [kitslVC release];
    
}
- (void)gouwu:(UIButton *)button
{
    
    KitsListTableViewController *kitslVC = [[KitsListTableViewController alloc] init];
    kitslVC.idNumber = self.idNumber;
    kitslVC.cateId = @"147"; // 147为购物编号
    kitslVC.lat = self.lat;
    kitslVC.lon = self.lon;
    kitslVC.titleName = @"购物";

    
    [self.navigationController pushViewController:kitslVC animated:YES];
    [kitslVC release];
    
}
- (void)connment:(UIButton *)button
{
    CommentTableViewController *commentVC = [[CommentTableViewController alloc] init];
    [self.navigationController pushViewController:commentVC animated:YES];
    commentVC.idNumber = self.idNumber;
    [commentVC release];
    
    
}
#pragma mark 评论tableview必备的方法

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"点评";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Comment_listData *comment = [self.comment_list objectAtIndex:indexPath.row];
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};

    CGRect rect = [comment.comment boundingRectWithSize:CGSizeMake(self.scroll.frame.size.width - 70, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
                    
    return rect.size.height + 80;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.comment_list.count == 0) {
    return  0;
    } else {
        return  [self.comment_list count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KitsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseComent forIndexPath:indexPath];
    cell.comment =  [self.comment_list objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
#pragma mark 手势动作
- (void)introduction:(UITapGestureRecognizer *)tap
{
    if (self.jianFlag == YES) {
        self.introduction.numberOfLines = 0;
    } else {
        self.introduction.numberOfLines = 3;
    }
    self.jianFlag = !self.jianFlag;
    [self makeScrollFrame];
}

- (void)tipsAction:(UITapGestureRecognizer *)tap
{
    if (self.tipsFlag == YES) {
        self.tips.numberOfLines = 0;
    } else {
        self.tips.numberOfLines = 3;
    }
    self.tipsFlag = !self.tipsFlag;
    [self makeScrollFrame];

}
- (void)photoAciton
{
    PhotoMainViewController *photo =[[PhotoMainViewController alloc] init];
    [self.navigationController pushViewController:photo animated:YES];
    photo.idNmber = self.idNumber;
    [photo release];
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
