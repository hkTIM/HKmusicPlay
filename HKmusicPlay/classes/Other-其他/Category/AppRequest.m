//
//  AppRequest.m
//  HKmusicPlay
//
//  Created by 黄坤 on 2016/10/31.
//  Copyright © 2016年 黄坤. All rights reserved.
//

#import "AppRequest.h"
#import "AFHTTPSessionManager.H"

@interface AppRequest ()

@end

@implementation AppRequest

static AFHTTPSessionManager *manegr;
static AppRequest *apprequest=nil;

float count=0;
+(BOOL)netWorkStatus
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    __block BOOL netWorkStatus = YES;
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         if (status == AFNetworkReachabilityStatusUnknown || status == AFNetworkReachabilityStatusNotReachable)
         {
             netWorkStatus = NO;
         }
         else
         {
             netWorkStatus = YES;
         }
     }];
    return netWorkStatus;
}
+(AppRequest *)ShareManger{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (apprequest == nil) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            manegr = [AFHTTPSessionManager manager];
            
            //#warning 我在AFN的源文件也加了这句话的。在AFURLResponseSerialization.m的223行
            manegr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
            //加上这句代码后台返回的时html 或者是 plain类型的时候就不会报错了  返回的类型一共有 @"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml" 这么多种
            
            //设置连接超时
            manegr.requestSerializer.timeoutInterval = 20.0;
            manegr.securityPolicy.allowInvalidCertificates = YES;
            //连接超时和连接成功的通知
            [[NSNotificationCenter defaultCenter] addObserver:manegr selector:@selector(networkRequestDidFinish:) name:AFNetworkingTaskDidCompleteNotification object:nil];
            apprequest = [self new];
            
        }
        
    });
    return apprequest;
}
//网络连接成功后 获取数据 并将数据打印
-(void)networkRequestDidFinish:(NSNotification *) notification{
    
    NSError *error = [notification.userInfo objectForKey:AFNetworkingTaskDidCompleteErrorKey];
    
    id responseObject = [notification.userInfo objectForKey:AFNetworkingTaskDidCompleteSerializedResponseKey];
    
    NSHTTPURLResponse *httpResponse = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
    
    if ([responseObject isKindOfClass:[NSDictionary class]] && error != nil) {
        
        NSString *description =  error.userInfo[@"NSLocalizedDescription"];
        NSLog(@"error.code ====== %ld",(long)error.code);
        NSLog(@"description %@",description);
        NSLog(@"httpResponse %@",httpResponse);
        NSLog(@"===========");
        
    }
}
+(void)postRequestInURL:(NSString *)url andParameters:(NSDictionary *)parameters succes:(void (^)(id))success stateerror:(void (^)(id))stateerror error:(void (^)(NSError *))error1 controller:(UIViewController *)controller1
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.requestSerializer.timeoutInterval = 5.f;
    controller1.navigationController.view.userInteractionEnabled = NO;
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [MBProgressHUD hideHUD];
        controller1.navigationController.view.userInteractionEnabled = YES;
        [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
        //        responseObject = [APIClient xxdata_de:responseObject[@"alldata"]];
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"url:%@ parameters_post   %@ ＝＝＝＝＝＝＝＝＝ responseObject%@",url,parameters,jsonString);
        NSString *state=[NSString stringWithFormat:@"%@",responseObject[@"showapi_res_code"]];
        if ([state isEqualToString:@"0"]) {
            success(responseObject);
        }
        else{
            if (![state isEqualToString:@"1000"]) {
                NSString *msg=[NSString stringWithFormat:@"%@", responseObject[@"showapi_res_error"]];
                stateerror(responseObject);
                //            [GuBaseController mbProgressHUDModeTextstyle:MBProgressHUDModeStyle_text showview:controleer1.navigationController.view labletext:msg];
                [MBProgressHUD showInfo:msg toView:controller1.navigationController.view];
            }else{
                success(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        controller1.navigationController.view.userInteractionEnabled = YES;
        error1(error);
        [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
        //        [GuBaseController mbProgressHUDModeTextstyle:MBProgressHUDModeStyle_text showview:controleer1.navigationController.view labletext:@"请检查网络后重试"];
        NSLog(@"AAAA:%@",error);
        [MBProgressHUD hideHUD];
        [MBProgressHUD showInfo:@"请检查网络后重试" toView:controller1.navigationController.view];
        //              [SVProgressHUD showErrorWithStatus:@"请检查网络后重试"];
    }];

}
@end
