//
//  CommentTableViewController.m
//  YouWoYou
//
//  Created by dlios on 15-3-26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "CommentTableViewController.h"
#import "KitsDetailTableViewCell.h"
#import "CommentListData1.h"
#import "NetWorkHandle.h"
#import "MJRefresh.h"
@interface CommentTableViewController ()

@property (nonatomic, retain) NSMutableArray *arr;

@end

@implementation CommentTableViewController
- (void)dealloc
{
    [_idNumber release];
    [_arr release];
    [super dealloc];
}

#pragma mark 请求网络
- (void)handleData
{
    NSString *str = [NSString stringWithFormat:@"http://open.qyer.com/poi/comment/get_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=865424024133973&track_app_version=6.1.0.2&track_app_channel=xiaomi&track_device_info=armani&track_os=Android4.3&app_installtime=1426735827710&lat=38.883704&lon=121.544973&client_id=qyer_android&poiid=%@&uid=&count=20&page=&since_id=&max_id=", self.idNumber];
    
    [NetWorkHandle postDataWithUrl:str completion:^(NSData *data) {
        
        NSError *error = nil;
        self.arr = [NSMutableArray array];
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSArray *arr = [[result objectForKey:@"data"] objectForKey:@"list"];
        for (NSDictionary *dic in arr) {
            CommentListData1 *commdata = [[CommentListData1 alloc] initWithDictionary:dic];
            [self.arr addObject:commdata];
            [commdata release];
        }
        [self.tableView reloadData];

        [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(handleNewData)];
        [self.tableView.footer beginRefreshing];
    }];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction:)] autorelease];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 2 * self.navigationItem.leftBarButtonItem.width, 80)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"全部点评";
    self.navigationItem.titleView = titleLabel;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [titleLabel release];
    


    [self handleData];

    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[KitsDetailTableViewCell class] forCellReuseIdentifier:@"12345"];
    
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    // 消除分区县线条
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 返回按钮
- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentListData1 *comment = [self.arr objectAtIndex:indexPath.row];
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    
    CGRect rect = [comment.comment boundingRectWithSize:CGSizeMake(self.tableView.frame.size.width - 70, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height + 80;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KitsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"12345" forIndexPath:indexPath];
    cell.comment = [self.arr objectAtIndex:indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
- (void)handleNewData
{
    CommentListData1 *commdata = [self.arr lastObject];
    NSString *str = commdata.idNumber;
    NSInteger n = [str integerValue] - 1;
    str = [NSString stringWithFormat:@"%ld",n];
    NSString *str1 = [NSString stringWithFormat:@"http://open.qyer.com/poi/comment/get_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=865424024133973&track_app_version=6.1.0.2&track_app_channel=xiaomi&track_device_info=armani&track_os=Android4.3&app_installtime=1426735827710&lat=38.883704&lon=121.544973&client_id=qyer_android&poiid=%@&uid=&count=20&page=&since_id=&max_id=%@", self.idNumber,str];
    
    [NetWorkHandle postDataWithUrl:str1 completion:^(NSData *data) {
        
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSArray *arr = [[result objectForKey:@"data"] objectForKey:@"list"];
        if (arr.count == 0) {
            [self.tableView removeFooter];
        }
        NSLog(@"评论页面");
        for (NSDictionary *dic in arr) {
            CommentListData1 *commdata = [[CommentListData1 alloc] initWithDictionary:dic];
            [self.arr addObject:commdata];
            [commdata release];
        }
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
    }];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
