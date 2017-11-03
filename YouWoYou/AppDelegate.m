//
//  AppDelegate.m
//  YouWoYou
//
//  Created by dlios on 15-3-21.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "AppDelegate.h"
#import "RecommendViewController.h"
#import "CollectionViewController.h"
#import "DesitinationViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "MyViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    [ShareSDK registerApp:@"6747f80ee270"];
    //添加新浪微博应用 注册网址 http://open.weibo.com
    [ShareSDK connectSinaWeiboWithAppKey:@"1761674017"
                               appSecret:@"987ab4a9229ec762894390c04bde8607"
                             redirectUri:@"https://api.weibo.com/oauth2/default.html"];
    
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [_window release];
    
    
    
    // 当行控制器背景图
    UIImage *naviBg = [UIImage imageNamed:@"taBAR.png"];
    naviBg = [naviBg imageWithAlignmentRectInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    
    // 推荐页面
    RecommendViewController *recommendVC = [[RecommendViewController alloc] init];
    
  
    //

    UINavigationController *recommendNC = [[UINavigationController alloc] initWithRootViewController:recommendVC];

    recommendVC.navigationController.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"旅游包" image:[UIImage imageNamed:@"tuijian1.png"] tag:1] autorelease];
    [recommendVC.navigationController.navigationBar setBackgroundImage:naviBg forBarMetrics:UIBarMetricsDefault];
    
    
    // 目的地页
    DesitinationViewController *desitinationVC = [[DesitinationViewController alloc] init];
       UINavigationController *desitinNC = [[UINavigationController alloc] initWithRootViewController:desitinationVC];
    desitinationVC.navigationController.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"出游" image:[UIImage imageNamed:@"mudidi.png"] tag:2] autorelease];
    [desitinationVC.navigationController.navigationBar setBackgroundImage:naviBg forBarMetrics:UIBarMetricsDefault];
 
    
   
    // 收藏页面
    MyViewController *collectionVC = [[MyViewController alloc] init];
     UINavigationController *collectiongNC = [[UINavigationController alloc] initWithRootViewController:collectionVC];
    collectionVC.navigationController.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"shoucang.png"] tag:3] autorelease];
    [collectionVC.navigationController.navigationBar setBackgroundImage:naviBg forBarMetrics:UIBarMetricsDefault];
   
    
    
    // 标签栏
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    
    UIImage *tabBarBg = [UIImage imageNamed:@"ibg.png"];
    tabBarBg = [tabBarBg imageWithAlignmentRectInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
//    tabBar.tabBar.backgroundImage = tabBarBg;
    tabBar.tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.tabBar.tintColor = [UIColor colorWithRed:(36.0 / 255.0) green:(196.0 / 255.0) blue:(145.0 / 255.0) alpha:1];
    tabBar.viewControllers = @[recommendNC, desitinNC, collectiongNC];
    self.window.rootViewController = tabBar;
    [tabBar release];
    [recommendNC release];
    [recommendVC release];
    [collectionVC release];
    [collectiongNC release];
    [desitinationVC release];
    [desitinNC release];
//   
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];

    return YES;
}


- (void)dealloc
{
    [_window release];
    [super dealloc];
}
- (void)applicationWillResignActive:(UIApplication *)application {

    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
