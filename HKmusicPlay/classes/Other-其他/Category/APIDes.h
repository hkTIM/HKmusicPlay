//
//  APIDes.h
//  banjiayao
//
//  Created by gongbin on 14-9-28.
//  Copyright (c) 2014年 gongbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonCrypto/CommonCryptor.h"


@interface APIDes : NSObject

+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;
+(NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key;
+(NSData *)toJSONData:(id)theData;

@end
