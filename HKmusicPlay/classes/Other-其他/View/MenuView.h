//
//  MenuView.h
//  WYMusic
//
//  Created by ios on 16/9/22.
//  Copyright © 2016年 wy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVPlayerManager.h"

typedef NS_ENUM(NSInteger, playerOfType) {
    PlayerTypeNormal = 0,           //正常循环播放状态
    PlayerTypeRandom,                 //随机播放
    PlayerTypeSingle,                 //单曲循环
};

@protocol MenuViewDelegate <NSObject>

@optional
-(void)ClickSongsOfIndex:(NSInteger )index;

-(void)changPlayerType:(playerOfType )type;

@end

@interface MenuView : UIView<UITableViewDelegate,UITableViewDataSource,MenuViewDelegate>
@property (nonatomic,weak)id<MenuViewDelegate>delegate;
@property(nonatomic,strong)UITableView *wTableView;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)NSMutableArray *name;
@property (strong ,nonatomic) AVPlayerManager*manger;

@property(nonatomic,strong)UIButton *playTypeBtn;
@property(nonatomic,assign)playerOfType type;


-(instancetype)initWithFrame:(CGRect)frame SongsArray:(NSArray *)songsArray  playerTyper:(playerOfType )type;

@end
