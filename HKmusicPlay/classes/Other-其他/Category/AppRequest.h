//
//  AppRequest.h
//  HKmusicPlay
//
//  Created by 黄坤 on 2016/10/31.
//  Copyright © 2016年 黄坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppRequest : NSObject

#pragma mark - - 检测网络状态  可以先判断网络在进行网络请求
+(BOOL)netWorkStatus;

+(AppRequest *)ShareManger;


+(void)postRequestInURL:(NSString *)url andParameters:(NSDictionary *)parameters succes:(void (^)(id responseObject))success stateerror:(void (^)(id responseObject))stateerror error:(void (^)(NSError *error))error1 controller:(UIViewController *)controller1;
@end
