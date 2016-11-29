//
//  MusicListModel.h
//  HKmusicPlay
//
//  Created by 黄坤 on 2016/11/1.
//  Copyright © 2016年 黄坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicListModel : NSObject
@property (strong ,nonatomic) NSString *songid;
@property (strong ,nonatomic) NSString *singerid;
@property (strong ,nonatomic) NSString *albumpic_big;
@property (strong ,nonatomic) NSString *downUrl;
@property (strong ,nonatomic) NSString *url;
@property (strong ,nonatomic) NSString *singername;
@property (strong ,nonatomic) NSString *albumid;
@property (strong ,nonatomic) NSString *seconds;
@property (strong ,nonatomic) NSString *albumpic_small;
@property (strong ,nonatomic) NSString *songname;
@property (strong ,nonatomic) NSString *albummid;
@end
