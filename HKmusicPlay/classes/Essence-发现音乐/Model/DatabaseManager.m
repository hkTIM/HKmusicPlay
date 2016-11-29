//
//  DatabaseManager.m
//  clever
//
//  Created by 黄磊 on 16/5/13.
//  Copyright © 2016年 黄坤. All rights reserved.
//

#import "DatabaseManager.h"
#import "FMDB.h"

#define dataBasePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) firstObject] stringByAppendingPathComponent:dataBaseName]

#define dataBaseName @"HKMusic.db"
#define KTableOfMusicList @"musicList"


@interface DatabaseManager ()

@property (nonatomic, strong) FMDatabase *database;

@end

@implementation DatabaseManager

+(DatabaseManager *)sharedDBManager
{
    static DatabaseManager *shareDBManager=nil;
    @synchronized (self) {
        if (shareDBManager==nil) {
            shareDBManager=[[DatabaseManager alloc]init];
        }
    }
    return shareDBManager;
}
-(DatabaseManager *)init
{
    if (self=[super init]) {
        self.database=[FMDatabase databaseWithPath:dataBasePath];
        if ([self.database open]==NO) {
            NSLog(@"打开数据库失败，数据库路径： %@",dataBasePath);
            return nil;
        }
        else{
            NSLog(@"打开数据库成功，数据库路径： %@",dataBasePath);
            
        }
        NSString *sqlStr=[NSString stringWithFormat:@"create table if not exists %@ (songid text primary key ,songname text,singerid text,albumpic_big text,downUrl text,url text,singername text,albumid text,seconds text,albumpic_small text,albummid text)",KTableOfMusicList];
        if (![self.database executeUpdate:sqlStr]) {
            NSLog(@"建类别表失败啊，SQL语句是：%@",sqlStr);
            return nil;
        }
    }
    return self;

}

-(void)addmusicList:(MusicListModel *)Thesong ///<添加音乐
{
    if (!Thesong) {
        return;
    }
    NSString *sqlStr=[NSString stringWithFormat:@"insert into %@ (songid,songname,singerid,albumpic_big,downUrl,url,singername,albumid,seconds,albumpic_small,albummid) values (?,?,?,?,?,?,?,?,?,?,?)",KTableOfMusicList];
    if (![self.database executeUpdate:sqlStr,Thesong.songid,Thesong.songname,Thesong.singerid,Thesong.albumpic_big,Thesong.downUrl,Thesong.url,Thesong.singername,Thesong.albumid,Thesong.seconds,Thesong.albumpic_small,Thesong.albummid])
    {
        NSLog(@"添加类别失败，sq语句是：%@",sqlStr);
    }
}
-(NSMutableArray *)readusicList///<跟据音乐id读取不同类别信息
{
    NSString *sqlStr=[NSString stringWithFormat:@"select * from %@" ,KTableOfMusicList];
    NSMutableArray *arry=[NSMutableArray array];
    FMResultSet *resultSet=[self.database executeQuery:sqlStr];
    while ([resultSet next]) {
        MusicListModel * aSong=[MusicListModel new];
        aSong.songid=[resultSet stringForColumn:@"songid"];
        aSong.songname=[resultSet stringForColumn:@"songname"];
        aSong.singerid=[resultSet stringForColumn:@"singerid"];
        aSong.albumpic_big=[resultSet stringForColumn:@"albumpic_big"];
        aSong.downUrl=[resultSet stringForColumn:@"downUrl"];
        aSong.url=[resultSet stringForColumn:@"url"];
        aSong.singername=[resultSet stringForColumn:@"singername"];
        aSong.albumid=[resultSet stringForColumn:@"albumid"];
        aSong.seconds=[resultSet stringForColumn:@"seconds"];
        aSong.albumpic_small=[resultSet stringForColumn:@"albumpic_small"];
        aSong.albummid=[resultSet stringForColumn:@"albummid"];
        [arry addObject:aSong];
    }
    return arry;
}
@end
