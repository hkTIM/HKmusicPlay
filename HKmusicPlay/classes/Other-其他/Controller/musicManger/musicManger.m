//
//  musicManger.m
//  musicPlay
//
//  Created by 1403812 on 16/3/4.
//  Copyright (c) 2016年 huangkun. All rights reserved.
//

#import "musicManger.h"
//#import <MediaPlayer/MediaPlayer.h>
@interface musicManger ()

@property(strong,nonatomic)AVPlayer *player;//播放器

@end

@implementation musicManger

+(instancetype) defaultManger
{
    static musicManger *manger=nil;
    @synchronized(self)
    {
        if (!manger) {
            manger=[[musicManger alloc]init];
        }
    }
    return manger;

}
-(BOOL)playMusic:(NSString *)musicFileName
{
    NSString *str=[NSString stringWithFormat:@"%@.mp3",musicFileName];
    NSURL *musicUrl = [[NSURL alloc]initWithString:str];
//    NSURL *musicUrl=[[NSBundle mainBundle]URLForResource:musicFileName withExtension:@"mp3"];//本地文件
    if (!musicUrl) {
        return NO;
    }
   self.player = [[AVPlayer alloc] initWithURL:musicUrl];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mediaPlayerPlaybackFinished:)name:AVPlayerItemTimeJumpedNotification object:nil];

   [self.player play];
    return YES;
}
//- (void)mediaPlayerPlaybackFinished:(NSNotification *)notify
//{
//    NSLog(@"播放完成");
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    [center postNotificationName:@"wancheng" object:nil userInfo:nil];
//}
-(void)pause
{
    [self.player pause];
}
-(void)play
{
     [self.player play];
}

//-(BOOL)isplaying
//{
//    if (self.player.status==AVPlayerStatusReadyToPlay) {
//        return YES;
//    }
//    else{
//        return NO;
//    }
//}
-(void)playModel
{
   
}
@end
