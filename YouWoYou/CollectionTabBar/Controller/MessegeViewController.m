//
//  MessegeViewController.m
//  YouWoYou
//
//  Created by dlios on 15-4-3.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "MessegeViewController.h"
#import "AFNetworking.h"
@interface MessegeViewController ()
@property (nonatomic, retain) UITextView *text;
@end

@implementation MessegeViewController
- (void)leftBarButtonAction:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction:)] autorelease];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    label.text = @"意见反馈";
    label.textColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:1];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    self.title = @"意见反馈";
    self.text = [[UITextView alloc] initWithFrame:CGRectMake(10, 70, self.view.frame.size.width - 20, 200)];
    self.text.backgroundColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:0.2];
//    self.text.layer.borderColor = [[UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:1] CGColor];
    self.text.layer.cornerRadius = 2.5;
    [self.view addSubview:self.text];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(10, self.text.frame.origin.y + 250, self.view.frame.size.width / 2 - 20, 50);
    [button1 setTitleColor:[UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:1] forState:(UIControlStateNormal)];
    [button1 setTitle:@"取消" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(button1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    button2.frame = CGRectMake(self.view.frame.size.width / 2 + 10, self.text.frame.origin.y + 250, self.view.frame.size.width / 2 - 20, 50);
    [button2 setTitle:@"发送" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:1] forState:(UIControlStateNormal)];
    [button2 addTarget:self action:@selector(button2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    [_text release];
    [label release];
    // Do any additional setup after loading the view.
}

- (void)button1:(UIButton *)button
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)button2:(UIButton *)button
{
    if (self.text.text.length != 0) {
        
        AFNetworkReachabilityManager *man =  [AFNetworkReachabilityManager sharedManager];
        if (man.networkReachabilityStatus != 0) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"@.@, >.<" message:@"感谢你的反馈" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            [alert release];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"@.@, >.<" message:@"亲们, 没网络哦" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            [alert release];
        }
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"@.@, >.<" message:@"你还没有填写建议" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{  if ([alertView.message isEqualToString:@"感谢你的反馈"]) {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
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
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];

     [self.view endEditing:YES];
}
- (void)dealloc
{
    [_text release];
    [super dealloc];
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
