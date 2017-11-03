//
//  MyViewController.m
//  YouWoYou
//
//  Created by dlios on 15-4-3.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "MyViewController.h"
#import "CollectionViewController.h"
#import "MessegeViewController.h"
#import "SDImageCache.h"
@interface MyViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain)UITableView *table;

@end
@implementation MyViewController
- (void)dealloc
{
    [_table release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 2 * self.navigationItem.leftBarButtonItem.width, 80)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"我的";
    self.navigationItem.titleView = titleLabel;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel release];
    
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
    [self.view addSubview:self.table];
    [_table release];
    self.table.scrollEnabled = NO;
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *str = [NSString string];
    if (section == 0) {
    str = @"收藏";
    } else  {
        str = @"关于";
    }
    return str;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger num = 0;
    if (section == 0) {
        num = 1;
    } else  {
        num = 3;
    }
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath ];
    if (indexPath.section == 0) {
         cell.textLabel.text = @"我的收藏";
    } else {
        if (indexPath.section == 1 && indexPath.row == 0) {
            cell.textLabel.text = @"清除缓存";
        } else if (indexPath.section == 1 && indexPath.row == 1){
            cell.textLabel.text = @"意见反馈";
        } else if (indexPath.section == 1 && indexPath.row == 2){
            cell.textLabel.text = @"关于我们";
        }
    }
    cell.textLabel.textColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [self pushCollection];
    } else {
        if (indexPath.section == 1 && indexPath.row == 0) {
            NSString *number = [NSString stringWithFormat:@"清理总共%0.2lfMB内存",[[SDImageCache sharedImageCache] checkTmpSize] + [self jisuanhuancun]];
            
            UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:number delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [aler show];
            [aler release];
        } else if (indexPath.section == 1 && indexPath.row == 1){
            [self messegeaction];
       } else if (indexPath.section == 1 && indexPath.row == 2){
            UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"我们" message:@"人生还在继续, 我们仍需努力!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [aler show];
            [aler release];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{   if (buttonIndex == 1){
    [[SDImageCache sharedImageCache] clearDisk];
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    docPath = [docPath stringByAppendingString:@"/youwoyou"];
    [[NSFileManager defaultManager] removeItemAtPath:docPath error:nil]; // 删除整个文件夹
    [[NSFileManager defaultManager] createDirectoryAtPath:docPath      // 再重新建立
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:NULL];
      }

}


- (CGFloat)jisuanhuancun // 计算指定位置缓存
{
    
        float totalSize = 0;
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        docPath = [docPath stringByAppendingString:@"/youwoyou"];
        NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:docPath];
        for (NSString *fileName in fileEnumerator) {
            NSString *filePath = [docPath stringByAppendingPathComponent:fileName];
            NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
            unsigned long long length = [attrs fileSize];
            totalSize += length / 1024.0 / 1024.0;
        }
        
        return totalSize;

}
- (void)pushCollection
{
    CollectionViewController *collection = [[CollectionViewController alloc] init];
    [self.navigationController pushViewController:collection animated:YES];
    [collection release];
}
- (void)messegeaction
{
    MessegeViewController *messege = [[MessegeViewController alloc] init];
    [self.navigationController pushViewController:messege animated:YES];
    [messege release];
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
