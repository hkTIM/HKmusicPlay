//
//  DatabaseManager.h
//  clever
//
//  Created by 黄磊 on 16/5/13.
//  Copyright © 2016年 黄坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"
#import "MusicListModel.h"
@interface DatabaseManager : NSObject

+(DatabaseManager *)sharedDBManager;
-(DatabaseManager *)init;

//类别数据库接口
-(void)addmusicList:(MusicListModel *)Thesong; ///<添加音乐
-(NSMutableArray *)readusicList;///<跟据音乐id读取不同类别信息

@end
