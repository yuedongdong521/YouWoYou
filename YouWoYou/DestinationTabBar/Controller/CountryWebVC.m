//
//  CountryWebVC.m
//  YouWoYou
//
//  Created by dllo on 15/3/28.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "CountryWebVC.h"
#import "MBProgressHUD.h"
@interface CountryWebVC () <MBProgressHUDDelegate>

@property (nonatomic, retain)UIWebView *webView;
@property (nonatomic, retain)MBProgressHUD *HUD;
@end

@implementation CountryWebVC

- (void)dealloc
{
    [_HUD release];
    [_webView release];
    [_countryName release];
    [_cityName release];
    [_idStr release];
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
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.webView.userInteractionEnabled = YES;
    [self.view addSubview:self.webView];
    [_webView release];
    
    NSString *str = [NSString string];
    
    if (self.countryName != nil) {
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 2 * self.navigationItem.leftBarButtonItem.width, 80)];
        title.textColor = [UIColor whiteColor];
        title.backgroundColor = [UIColor clearColor];
        title.textAlignment = NSTextAlignmentLeft;
        title.text = @"国家实用信息";
        self.navigationItem.titleView = title;
        [title release];
        self.title = @"国家实用信息";
        str = [NSString stringWithFormat:@"http://appview.qyer.com/place/%@/ctyprofile?spm=app", self.countryName];
    } else if (self.cityName != nil) {
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        title.textColor = [UIColor whiteColor];
        title.backgroundColor = [UIColor clearColor];
        title.textAlignment = NSTextAlignmentCenter;
        title.text = @"城市实用信息";
        self.navigationItem.titleView = title;
        [title release];
        self.title = @"城市实用信息";
        str = [NSString stringWithFormat:@"http://appview.qyer.com/place/%@/profile", self.cityName];
    } else {
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        title.textColor = [UIColor whiteColor];
        title.backgroundColor = [UIColor clearColor];
        title.textAlignment = NSTextAlignmentCenter;
        title.text = @"推荐行程";
        self.navigationItem.titleView = title;
        [title release];
        self.title = @"推荐行程";
        str = [NSString stringWithFormat:@"http://m.qyer.com/plan/tripapp/%@/", self.idStr];
    }
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    str = nil;

    
   }


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
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
