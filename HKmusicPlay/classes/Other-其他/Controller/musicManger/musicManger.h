//
//  musicManger.h
//  musicPlay
//
//  Created by 1403812 on 16/3/4.
//  Copyright (c) 2016年 huangkun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface musicManger : NSObject

+(instancetype) defaultManger;

-(BOOL)playMusic:(NSString *)musicFileName;
-(void)pause;
-(void)play;
-(BOOL)isplaying;
-(void)playModel;
@end
