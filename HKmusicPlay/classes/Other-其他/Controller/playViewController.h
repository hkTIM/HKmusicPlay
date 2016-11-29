//
//  playViewController.h
//  HKmusicPlay
//
//  Created by 黄坤 on 2016/11/1.
//  Copyright © 2016年 黄坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicListModel.h"
#import "MusicSlider.h"
#import "AVPlayerManager.h"

@interface playViewController : UIViewController
@property(nonatomic,strong)AVPlayerManager *musicManager;
@property(nonatomic,strong)NSMutableArray *songArray;
//@property(nonatomic,strong)NSMutableArray *imageArray;
//@property(nonatomic,strong)NSMutableArray *singerArray;
//@property(nonatomic,strong)NSMutableArray *songNameArray;
@property(nonatomic,assign)NSInteger index;


/*背景*/
@property (weak, nonatomic) IBOutlet UIImageView *backgroudImageView;
@property (weak, nonatomic) IBOutlet UIView *backgroudView;

/*最上行*/
@property (weak, nonatomic) IBOutlet UILabel *musicTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

/*中心图片*/
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *albumImageLeftConstraint;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *albumImageRightConstraint;

/*收藏行*/
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UILabel *musicNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;

/*进度条*/
@property (weak, nonatomic) IBOutlet UILabel *beginTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet MusicSlider *musicSlider;

/*最下行按钮*/
@property (weak, nonatomic) IBOutlet UIButton *musicCycleButton;
@property (weak, nonatomic) IBOutlet UIButton *previousMusicButton;
@property (weak, nonatomic) IBOutlet UIButton *musicToggleButton;
@property (weak, nonatomic) IBOutlet UIButton *nextMusicButton;
@property (weak, nonatomic) IBOutlet UIButton *otherButton;

- (IBAction)stopBtn:(UIButton *)sender;
- (IBAction)changePlayMode:(UIButton *)sender ;
- (IBAction)begenBtn:(UIButton *)sender;
- (IBAction)nextBtn:(UIButton *)sender;

@end
