//
//  NetWorkTool.m
//  MessageModel
//
//  Created by 胡超 on 2018/9/15.
//  Copyright © 2018年 胡超. All rights reserved.
//

#import "NetWorkTool.h"
#import "LoginVC.h"
#import "NSObject+HCCategory.h"
#import <AFNetworking.h>
#import "BaseNaviVC.h"

#define kTimeOutInterval 10

@implementation NetWorkTool
+(AFHTTPSessionManager *)manager{
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager=[AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain",nil];
        
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        
        manager.requestSerializer.timeoutInterval = kTimeOutInterval;
        
        [manager.requestSerializer setHTTPShouldHandleCookies:YES];
        
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        [self loadCookies];
        
    });
    
    return manager;
    
}

+ (void)requestWithURL:(NSString *)url
                params:(NSDictionary *)parmas
               toModel:(Class) modelClass
               success:(SuccessBlock)successBlock
               failure:(AFErrorBlock)errorBlock
           showLoading:(NSString *)showLoading
{
   NSString * phone = [[UserStorage shareInstance] getUserModel].phone;
    if (phone) {
        [[self manager].requestSerializer setValue: phone
    forHTTPHeaderField:@"JSESSIONID"];
    }
    NSArray<NSString *> * arr = [url componentsSeparatedByString:@"@"];
    NSString * URL = [NSString stringWithFormat:@"%@%@",kBaseUrl,arr.firstObject];
    if ([[arr.lastObject uppercaseString] isEqualToString:@"GET"]) {
        [self GETWithURL:URL params:parmas toModel:modelClass success:successBlock failure:errorBlock showLoading:showLoading];
    }else{
        [self POSTWithURL:URL params:parmas toModel:modelClass success:successBlock failure:errorBlock showLoading:showLoading];
    }
}

+ (void)GETWithURL:(NSString *)url
            params:(NSDictionary *)parmas
           toModel:(Class) modelClass
           success:(SuccessBlock)successBlock
           failure:(AFErrorBlock)errorBlock
       showLoading:(NSString *)showLoading
{
    MBProgressHUD *hub = nil;
    if (showLoading) {
        hub = [MBProgressHUD showMessage:showLoading];
    }
 [[NetWorkTool manager] GET:url parameters:parmas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (showLoading) {
            [hub hideAnimated:YES];
        }
       [self saveCookies];
        NSInteger code = [responseObject[@"flg"] integerValue];
        switch (code) {
            case 1:
            { ///成功就返回结果
                id model = nil;
                id data = responseObject[@"data"];
                 NSLog(@"请求结果：\n%@",data);
                if (modelClass != nil) {
                    if ([data isKindOfClass:[NSArray class]]) {
                        model = [NSArray modelArrayWithClass:modelClass json:data];
                    }else{
                        model = [modelClass modelWithJSON:data];
                    }
                  successBlock(model);
                }else{
                  successBlock(data);
                }
                break;
            }
            case -2:
            { ///用户信息失效
                 NSLog(@"请求结果：\n用户信息失效");
                if([[self getCurrentVC] isMemberOfClass:[LoginVC class]] == NO){
                    LoginVC *vc = [LoginVC new];
                    [[self getCurrentVC] presentViewController:[[BaseNaviVC alloc]initWithRootViewController:vc] animated:YES completion:nil];
                }
                errorBlock(responseObject[@"msg"], code);
                break;
            }

            default:///其他情况返回error
                NSLog(@"请求结果：\n%@",responseObject[@"msg"]);
                errorBlock(responseObject[@"msg"], code);
                break;
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (showLoading) {
            [hub hideAnimated:YES];
        }
        errorBlock(error.description, 1);
    }];
}


+ (void)POSTWithURL:(NSString *)url
            params:(NSDictionary *)parmas
           toModel:(Class) modelClass
           success:(SuccessBlock)successBlock
           failure:(AFErrorBlock)errorBlock
       showLoading:(NSString *)showLoading
{
    MBProgressHUD *hub = nil;
    if (showLoading) {
        hub = [MBProgressHUD showMessage:showLoading];
    }
    [[NetWorkTool manager] POST:url parameters:parmas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (showLoading) {
            [hub hideAnimated:YES];
        }
        [self saveCookies];
        NSInteger code = [responseObject[@"flg"] integerValue];
        NSLog(@"================%@请求=====================\n\n%@\n\n",url,parmas);
        switch (code) {
            case 1:
            { ///成功就返回结果
                id model = nil;
                id data = responseObject[@"data"];
                NSLog(@"请求结果：\n%@",data);
                if (modelClass != nil) {
                    if ([data isKindOfClass:[NSArray class]]) {
                        model = [NSArray modelArrayWithClass:modelClass json:data];
                    }else{
                        model = [modelClass modelWithJSON:data];
                    }
                    successBlock(model);
                }else{
                    successBlock(data);
                }
                break;
            }
            case -2:
            { ///用户信息失效
                 NSLog(@"请求结果：\n用户信息失效");
                if([[self getCurrentVC] isMemberOfClass:[LoginVC class]] == NO){
                    LoginVC *vc = [LoginVC new];
                    [[self getCurrentVC] presentViewController:[[BaseNaviVC alloc]initWithRootViewController:vc] animated:YES completion:nil];
                }
                errorBlock(responseObject[@"msg"], code);
                break;
            }
                
            default:///其他情况返回error
                NSLog(@"请求结果：\n%@",responseObject[@"msg"]);
                errorBlock(responseObject[@"msg"], code);
                break;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (showLoading) {
            [hub hideAnimated:YES];
        }
        errorBlock(error.description, 1);
    }];
}


//保存Cookie
+ (void)saveCookies
{
    NSData*cookiesData = [NSKeyedArchiver archivedDataWithRootObject:[[NSHTTPCookieStorage sharedHTTPCookieStorage]cookies]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:cookiesData forKey:@"org.skyfox.cookie"];
    [defaults synchronize];
}

//保存Cookie
 //加载Cookie 一般都是app刚刚启动的时候
+ (void)loadCookies
{
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"org.skyfox.cookie"]];
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie  in cookies) {
        [cookieStorage setCookie:cookie];
    }
}
@end
