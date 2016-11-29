//
//  playViewController.m
//  HKmusicPlay
//
//  Created by 黄坤 on 2016/11/1.
//  Copyright © 2016年 黄坤. All rights reserved.
//

#import "playViewController.h"
//#import "musicManger.h"
#import "MenuView.h"
#import <AVFoundation/AVFoundation.h>
#define SCREEN_WIDTH ( [[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ( [[UIScreen mainScreen] bounds].size.height)
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f \
blue:(b)/255.0f alpha:1.0f]
@interface playViewController ()<MenuViewDelegate>

@property(nonatomic,assign) float currentPlayTime;
@property(nonatomic,assign)BOOL isPlay;

@property(nonatomic,strong)MenuView *menuView;
@property (nonatomic, weak) UIButton *cover;
@property(strong,nonatomic) MusicListModel *model;
@property (assign,nonatomic)NSInteger angle;

@end

@implementation playViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.musicManager = [AVPlayerManager shareManager];
//    self.model=[[MusicListModel alloc]init];
    self.model=self.songArray[self.index];
    self.angle=0;
    [self okTodisForView:self.model.songname];
    if (self.musicManager.listInto == YES) {
        [self loadData];
    }else{
        NSURL *Bigimageurl=[NSURL URLWithString:self.model.albumpic_big];
        NSURL *imageurl=[NSURL URLWithString:self.model.albumpic_small];
        [self.backgroudImageView setImageWithURL:Bigimageurl placeholderImage:[UIImage imageNamed:@""]];
        [self startAnimation];
        [self.albumImageView setImageWithURL:imageurl placeholderImage:[UIImage imageNamed:@"music_placeholder"]];
        self.musicTitleLabel.text=self.model.songname;
        self.singerLabel.text=self.model.singername;
        self.isPlay =YES;
        [self stopBtn:self.musicToggleButton];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playStutas:) name:@"playOrPasue" object:nil];
    
    [self.musicSlider setThumbImage:[UIImage imageNamed:@"music_slider_circle"] forState:UIControlStateNormal];
    [self.musicSlider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    
    __weak typeof(self) weekSelf = self;
    //获取进度条以及播放时间
    self.musicManager.block1 = ^(NSString *current,NSString *total,float max , float value){
        weekSelf.beginTimeLabel.text = current;
        weekSelf.endTimeLabel.text = total;
        weekSelf.musicSlider.maximumValue = max;
        weekSelf.musicSlider.minimumValue =0;
        weekSelf.musicSlider.value = value;
    } ;
    //获取缓冲状态
    self.musicManager.block = ^(NSString *loadTime){
        weekSelf.musicNameLabel.text = loadTime;
    };
    //修改背景图，歌名、歌手
    self.musicManager.block2 = ^(NSInteger index){
        [weekSelf okTodisForView:weekSelf.model.songname];
        weekSelf.model=weekSelf.songArray[index];
        NSURL *Bigimageurl=[NSURL URLWithString:weekSelf.model.albumpic_big];
        NSURL *imageurl=[NSURL URLWithString:weekSelf.model.albumpic_small];
        [weekSelf.backgroudImageView setImageWithURL:Bigimageurl placeholderImage:[UIImage imageNamed:@""]];
        [weekSelf startAnimation];
        [weekSelf.albumImageView setImageWithURL:imageurl placeholderImage:[UIImage imageNamed:@"music_placeholder"]];
        weekSelf.musicTitleLabel.text=weekSelf.model.songname;
        weekSelf.singerLabel.text=weekSelf.model.singername;;
//        [self okTodisForView:weekSelf.model.songname];
    };
    self.albumImageView.layer.cornerRadius=self.albumImageView.hk_height*0.5;
    self.albumImageView.layer.borderWidth=2;
    self.albumImageView.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    self.albumImageView.clipsToBounds =YES;
    [self.musicSlider setValue:0 animated:YES];
}
-(void)okTodisForView:(NSString *)name
{
    if ([self isFileExist:[NSString stringWithFormat:@"%@.mp3",name]]==YES) {
        [self.musicCycleButton setImage:[UIImage imageNamed:@"cm2_play_btn_dld_ok"] forState:UIControlStateNormal];
    }
    else
    {
        [self.musicCycleButton setImage:[UIImage imageNamed:@"cm2_play_btn_dld_dis"] forState:UIControlStateNormal];
    }

}
-(BOOL) isFileExist:(NSString *)fileName
{
    NSString *savePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"%@",savePath);
    savePath = [savePath stringByAppendingPathComponent:@"音乐"];
    NSFileManager *fm=[NSFileManager defaultManager];
    NSString *writePath = [savePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3", self.model.songname]];
    BOOL isWrite = [fm fileExistsAtPath:writePath];
    NSLog(@"这个文件已经存在：%@",isWrite?@"是的":@"不存在");
    return isWrite;
}
-(void)sliderValueChange:(UISlider *)slider{
    [self.musicManager playerProgressWithProgressFloat:slider.value];
}
-(void)startAnimation
{
    __block playViewController *play=self;
    [UIView animateWithDuration:10 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        play.albumImageView.transform=CGAffineTransformMakeRotation(play.angle);
    } completion:^(BOOL finished) {
        play.angle+=90;
        [play startAnimation];
    }];
}
- (IBAction)blackBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (IBAction)changePlayMode:(UIButton *)sender {//下载
    NSString *fileURLStr =self.model.downUrl;
    //编码操作；对应的解码操作是用 stringByRemovingPercentEncoding 方法
//    fileURLStr = [fileURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *fileURL = [NSURL URLWithString:fileURLStr];
    //创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:fileURL];
    //方法二：发送一个异步请求
    [MBProgressHUD showMessage:@"下载中...."];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (!connectionError) {
                                   [self saveDataToDisk:data];
                                   NSLog(@"保存成功----下载完成");
                                   [MBProgressHUD hideHUD];
                                    [MBProgressHUD showSuccess:@"下载完成"];
                                   [self.musicCycleButton setImage:[UIImage imageNamed:@"cm2_play_btn_dld_ok"] forState:UIControlStateNormal];
                               } else {
                                   NSLog(@"下载失败，错误信息：%@", connectionError.localizedDescription);
                                   NSLog(@"下载失败");
                                   [MBProgressHUD hideHUD];
                                   [MBProgressHUD showSuccess:@"下载失败"];
                               }
                           }];
}
- (void)saveDataToDisk:(NSData *)data {
    //数据接收完保存文件；注意苹果官方要求：下载数据只能保存在缓存目录（/Library/Caches）
    NSString *savePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"%@",savePath);
    savePath = [savePath stringByAppendingPathComponent:@"音乐"];
    
    NSFileManager *fm=[NSFileManager defaultManager];
    
    BOOL isExit = [fm fileExistsAtPath:savePath];
    
    if (!isExit) {
        //不存在
        if ([fm createDirectoryAtPath:savePath withIntermediateDirectories:YES attributes:nil error:nil]) {
            NSLog(@"文件夹创建成功");
        }
        else
        {
            NSLog(@"文件夹创建失败");
        }
        
    }
    //writeToFile: 方法：如果 savePath 文件存在，他会执行覆盖
    NSString *writePath = [savePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3", self.model.songname]];
    BOOL isWrite = [data writeToFile:writePath atomically:YES];
    if (isWrite) {
        NSLog(@"写成功。。。。");
    }
    else
    {
        NSLog(@"写入失败");
    }
}

-(void)ClickSongsOfIndex:(NSInteger)index{
    [self.musicManager removeObserver];
    [self.musicManager musicPlayerWithIndex:index];
    
    self.isPlay =YES;
    [self.musicManager playMusic];
    
    [self returnMessage];
}

-(void)changPlayerType:(playerOfType)type{
    self.musicManager.playerType = type;
}
-(void)returnMessage{
    [self removeView:self.menuView];
}
-(void)removeView:(UIView *)view{
    [UIView animateWithDuration:0.5 animations:^{
        self.cover.alpha =0.0;
        view.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 200);
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
        [self.cover removeFromSuperview];
        self.cover  = nil;
    }];
}
- (IBAction)begenBtn:(UIButton *)sender {
    self.isPlay = YES;
    [self.musicSlider setValue:0 animated:YES];
    [self stopBtn:self.musicToggleButton];
    [self.musicManager lastSong];
}
#pragma 缓冲不足导致不能播放接受通知控制按钮状态
-(void)playStutas:(NSNotification *)notify{
    if ([[notify.userInfo valueForKey:@"播放状态"]  isEqual: @1]) {
        self.isPlay = YES;
        [self stopBtn:self.musicToggleButton];
    }else if([[notify.userInfo valueForKey:@"播放状态"]  isEqual: @0]){
        self.isPlay = NO;
        [self stopBtn:self.musicToggleButton];
    };
}

- (IBAction)stopBtn:(UIButton *)sender {
    if (self.isPlay == YES) {
        [self.musicManager.player play];
        [self.musicToggleButton setImage:[UIImage imageNamed:@"big_pause_button"] forState:UIControlStateNormal];
    }else{
        [self.musicManager.player pause];
        [self.musicToggleButton setImage:[UIImage imageNamed:@"big_play_button"] forState:UIControlStateNormal];
        NSLog(@"暂停");
    }
    self.isPlay = !self.isPlay;

}
- (IBAction)nextBtn:(UIButton *)sender {
    self.isPlay = YES;
    [self.musicSlider setValue:0 animated:YES];
    [self stopBtn:self.musicToggleButton];
    [self.musicManager nextSong];

}
- (IBAction)mumeBtn:(UIButton *)sender {
    [self createcover];
    self.menuView = [[MenuView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT/2) SongsArray:self.songArray playerTyper:self.musicManager.playerType];
    self.menuView.delegate = self;
    [self.menuView.wTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[self.musicManager getcurrentItem] inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    [self.view addSubview:self.menuView];
    [UIView animateWithDuration:0.25 animations:^{
        self.cover.alpha = 0.5;
        self.menuView.frame = CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2);
    }];
}
#pragma mark - 创建阴影
-(void)createcover{
    UIButton *cover = [[UIButton alloc] init];
    cover.frame = self.view.bounds;
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.1;
    [cover addTarget:self action:@selector(returnMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cover];
    self.cover = cover;
}

-(void)loadData{
    if (self.musicManager.musicArray.count <= 0) {
        [self.musicManager musicPlayerWithArray:self.songArray andIndex:self.index];
        NSURL *Bigimageurl=[NSURL URLWithString:self.model.albumpic_big];
        NSURL *imageurl=[NSURL URLWithString:self.model.albumpic_small];
        [self.backgroudImageView setImageWithURL:Bigimageurl placeholderImage:[UIImage imageNamed:@""]];
        [self startAnimation];
        [self.albumImageView setImageWithURL:imageurl placeholderImage:[UIImage imageNamed:@"music_placeholder"]];
        self.musicTitleLabel.text=self.model.songname;
        self.singerLabel.text=self.model.singername;
    }else {
        
        if ([self.musicManager.musicArray indexOfObject:self.musicManager.player.currentItem] != self.index) {
            //让上一首歌播放时间回到起点！！！！ （搞死我了。）
            [self.musicManager.player.currentItem seekToTime:kCMTimeZero];
        }
        [self.musicManager musicPlayerWithIndex:self.index];
        NSURL *Bigimageurl=[NSURL URLWithString:self.model.albumpic_big];
        NSURL *imageurl=[NSURL URLWithString:self.model.albumpic_small];
        [self.backgroudImageView setImageWithURL:Bigimageurl placeholderImage:[UIImage imageNamed:@""]];
        [self startAnimation];
        [self.albumImageView setImageWithURL:imageurl placeholderImage:[UIImage imageNamed:@"music_placeholder"]];
        self.musicTitleLabel.text=self.model.songname;
        self.singerLabel.text=self.model.singername;
        self.isPlay =YES;
        [self stopBtn:self.musicToggleButton];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
