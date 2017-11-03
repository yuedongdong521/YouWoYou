//
//  SearchBarVC.m
//  UISearchBar2
//
//  Created by dllo on 15/3/21.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "SearchBarVC.h"
#import "NetWorkHandle.h"
#import "SearchResultVC.h"

@interface SearchBarVC ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, retain)NSString *resultStr;

@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, retain)NSString *searchStr;
@end

@implementation SearchBarVC
- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction:)] autorelease];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    self.width = self.view.frame.size.width;
    self.height = self.view.frame.size.height;
    
    
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width / 3 * 2, 35)];
    
    titleView.backgroundColor = self.navigationController.navigationBar.backgroundColor;
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.width / 3 * 2, 35)];
    self.searchBar.layer.cornerRadius = 18;
    self.searchBar.layer.masksToBounds = YES;
    
    self.searchBar.delegate = self;
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTitle:@"取消"];
    for (UIView *view in self.searchBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [view addSubview:titleView];
        }
    }
    self.navigationItem.titleView = self.searchBar;
    [_searchBar release];
    [titleView release];
    
    self.topSearch = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width / 3 * 2, 0) style:UITableViewStylePlain];
    self.topSearch.layer.borderColor = [[UIColor blackColor] CGColor];
    self.topSearch.layer.borderWidth = 1;
    self.topSearch.bounces = NO;
    self.topSearch.showsVerticalScrollIndicator = NO;
    self.topSearch.delegate = self;
    self.topSearch.dataSource = self;
    [self.view addSubview:self.topSearch];
    [_topSearch release];
    [self.topSearch registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
    
    
}


- (void)dealloc
{
    
    [_searchBar release];
    [_dataArr release];
    [_str release];
    [_topSearch release];
    
    
    [_resultStr release];
    [_searchStr release];
    [super dealloc];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.dataArr objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.searchBar endEditing:YES];
    
    self.resultStr = [self.dataArr objectAtIndex:indexPath.row];
    
    [self searchResult];
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.searchBar endEditing:YES];
}



- (void)setTopSearchViewHidden:(BOOL)hidden
{
    NSInteger height = hidden ? 0 : self.height / 2;
    self.topSearch.frame = CGRectMake(self.width / 5, 0, self.width / 3 * 2, height);
}

// 将要搜索
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"将要开始编辑");
    
    NSString *str = @"http://open.qyer.com/qyer/search/hot_history?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=865424024133973&track_app_version=6.1.0.2&track_app_channel=xiaomi&track_device_info=armani&track_os=Android4.3&app_installtime=1426735827710&lat=38.883782&lon=121.544985";
    
    [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        self.dataArr = [NSMutableArray array];
        self.dataArr = [result objectForKey:@"data"];
        [self setTopSearchViewHidden:NO];
        self.str = @"热门搜索";
        [self.topSearch reloadData];
        
        
    }];
    
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // 点击搜索
    self.resultStr = searchBar.text;
    
    [self searchResult];
    
}

// 点击Cancel按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar endEditing:YES];
    
    [self setTopSearchViewHidden:YES];
    
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // 已经开始编辑
    searchBar.showsCancelButton = YES;
}

// 搜索内容改变
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length > 0) {
        [self setTopSearchViewHidden:NO];
    }
    NSLog(@"searchText: %@", searchText);
    searchText = [searchText stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (searchText != nil && searchText.length > 0) {
        NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/qyer/search/autocomplate?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=865424024133973&track_app_version=6.1.0.2&track_app_channel=xiaomi&track_device_info=armani&track_os=Android4.3&app_installtime=1426735827710&lat=38.883782&lon=121.544985&keyword=%@", searchText];
        
        [NetWorkHandle getDataWithUrl:str completion:^(NSData *data) {
            NSError *error = nil;
            
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            self.dataArr = [NSMutableArray array];
            self.dataArr = [([result objectForKey:@"data"]) objectForKey:@"entry"];
            NSLog(@"=======%@", self.dataArr);
            self.str = nil;
            if (self.dataArr.count == 0) {
                [self setTopSearchViewHidden:YES];
            }
            [self.topSearch reloadData];
            
        }];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _str;
}

- (void)searchResult
{
    [self.searchBar endEditing:YES];
    SearchResultVC *SRVC = [[SearchResultVC alloc] init];
    self.resultStr = [self.resultStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (self.resultStr.length > 0) {
        SRVC.resultStr = self.resultStr;
        [self.navigationController pushViewController:SRVC animated:YES];
        self.searchStr = self.resultStr;
    }
    [self setTopSearchViewHidden:YES];
    
    [SRVC release];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
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
