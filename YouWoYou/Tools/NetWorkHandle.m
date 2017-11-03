//
//  NetWorkHandle.m
//  YouWoYou
//
//  Created by dlios on 15-3-23.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import "NetWorkHandle.h"
#import "AFNetworking.h"


@implementation NetWorkHandle

+ (void)getDataWithUrl:(NSString *)str completion:(void (^)(NSData *))block
{
     str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 确定地址
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    docPath = [docPath stringByAppendingString:@"/youwoyou"];
    // 创建文件夹
    [[NSFileManager defaultManager] createDirectoryAtPath:docPath      // 再重新建立
                                   withIntermediateDirectories:YES
                                                    attributes:nil
                                                         error:NULL];
    
    NSString *path = [NSString stringWithFormat:@"%@/%ld.plist", docPath, (unsigned long)[str hash]];
//    NSLog(@"%@", path);

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [manager GET:str parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        NSLog(@"请求成功");
        
        NSString *requsetTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requsetTmp dataUsingEncoding:NSUTF8StringEncoding]];
        
       

        [resData writeToFile:path atomically:YES];
            block(resData);
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请求失败,请检查网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alter show];
        NSData *pickData = [NSData dataWithContentsOfFile:path];
        if (pickData != nil) {
            block(pickData);
        }
        [alter release];

     
    }];
}
+ (void)postDataWithUrl:(NSString *)str completion:(void(^)(NSData *data))block
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    //
    NSString *path = [NSString stringWithFormat:@"%@/%ld.plist", docPath, (unsigned long)[str hash]];
    NSLog(@"%@", path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:str parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
          NSString *requsetTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requsetTmp dataUsingEncoding:NSUTF8StringEncoding]];
        
        [resData writeToFile:path atomically:YES];
        block(resData);

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请求失败,请检查网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alter show];
        NSData *pickData = [NSData dataWithContentsOfFile:path];
        if (pickData != nil) {
            block(pickData);
        }
        [alter release];
    }];


}


@end
