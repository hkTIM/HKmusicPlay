//
//  HKRankViewController.m
//  HKmusicPlay
//
//  Created by 黄坤 on 2016/10/12.
//  Copyright © 2016年 黄坤. All rights reserved.
//

#import "HKRankViewController.h"
#import "TableViewCell.h"
#import "playViewController.h"
#import "NAKPlaybackIndicatorView.h"
#import "MusicListModel.h"
#import "DatabaseManager.h"
#import "AVPlayerManager.h"
#define kSCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
@interface HKRankViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NAKPlaybackIndicatorView *indicator;
@property (strong ,nonatomic)UITableView *musiclistTbale;

@property (strong ,nonatomic) AVPlayerManager*musicMnage;
@property (strong ,nonatomic)MusicListModel *manger;
@property (strong,nonatomic) DatabaseManager *dbManger;
@property (assign,nonatomic) BOOL databaseHasData;

@property (strong ,nonatomic)NSMutableArray *songList;
@property(assign ,nonatomic)NSInteger page;

@end

@implementation HKRankViewController
-(NSMutableArray *)songList
{
    if (!_songList) {
        _songList=[[NSMutableArray alloc]init];
    }
    return _songList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     NSLog(@"排行榜");
    self.dbManger=[DatabaseManager sharedDBManager];
    self.musiclistTbale=[[UITableView alloc]initWithFrame:CGRectMake(0,100, self.view.hk_width, self.view.hk_height-150)];
    self.musiclistTbale.delegate=self;
    self.musiclistTbale.dataSource=self;
    self.musiclistTbale.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    self.musiclistTbale.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    self.page=1;
    [self getdata];
  
  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(status:) name:@"playOrPasue" object:nil];
    // Do any additional setup after loading the view.
}
-(void)addIndicator
{
    self.indicator = [[NAKPlaybackIndicatorView alloc] initWithFrame:CGRectMake(self.view.hk_width-80, -20, 100, 80)];
    [self.navigationController.navigationBar addSubview:self.indicator];
    // 当停止时不隐藏
    self.indicator.hidesWhenStopped = NO;
    // 设置控件颜色
    self.indicator.tintColor = [UIColor blueColor];
    // 设置控件状态
    self.indicator.state =  NAKPlaybackIndicatorViewStateStopped;
    
    // 添加手势 ----- 点击控件触发
    UITapGestureRecognizer *tapInditator = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(musicStop)];
    tapInditator.numberOfTapsRequired = 1;
    [self.indicator addGestureRecognizer:tapInditator];
}
-(void)status:(NSNotification *)notify
{
    if ([[notify.userInfo valueForKey:@"播放状态"]  isEqual: @1]) {
        self.indicator.state =NAKPlaybackIndicatorViewStatePlaying;
    }else if([[notify.userInfo valueForKey:@"播放状态"]  isEqual: @0]){
        self.indicator.state =NAKPlaybackIndicatorViewStatePaused;
    }
}
-(void)musicStop
{
    playViewController *theVC=[[playViewController alloc]init];
    theVC.musicManager = [AVPlayerManager shareManager];
    if (self.songList==nil)
    {
        theVC.musicManager.listInto = YES;
    }
    else
    {
        theVC.musicManager.listInto = NO;
    }
    theVC.index=[theVC.musicManager getcurrentItem];
    theVC.songArray=self.songList;
    [self presentViewController:theVC animated:YES completion:nil];
}

-(void)getdata
{
       NSString *url=[NSString stringWithFormat:@"http://route.showapi.com/213-4"];
       NSDictionary *params=@{
                           @"showapi_appid":@"26406",
                           @"showapi_sign":@"758103f7053d416e95e1be38f6157732",
                           @"topid":@"26"
                           };
        [MBProgressHUD showMessage:@"正在加载中....."];
        [AppRequest postRequestInURL:url andParameters:params succes:^(id responseObject) {
        NSArray *list=[[NSArray alloc]init];
        list=responseObject[@"showapi_res_body"][@"pagebean"][@"songlist"];
        [MBProgressHUD hideHUD];
        [MBProgressHUD showInfo:@""];
        [self.view addSubview:self.musiclistTbale];
        [self addIndicator];
        for (int i=0; i<list.count; i++) {
            NSDictionary *dic=list[i];
            MusicListModel *thesong=[[MusicListModel alloc]init];
            thesong.songid=[dic objectForKey:@"songid"];
            thesong.albumpic_big=[dic objectForKey:@"albumpic_big"];
            thesong.singerid=[dic objectForKey:@"singerid"];
            thesong.downUrl=[dic objectForKey:@"downUrl"];
            thesong.url=[dic objectForKey:@"url"];
            thesong.singername=[dic objectForKey:@"singername"];
            thesong.albumid=[dic objectForKey:@"albumid"];
            thesong.seconds=[dic objectForKey:@"seconds"];
            thesong.albumpic_small=[dic objectForKey:@"albumpic_small"];
            thesong.songname=[dic objectForKey:@"songname"];
            thesong.albummid=[dic objectForKey:@"albummid"];
            [self.songList addObject:thesong];//将网络上的数据加载到可变数组－－由于我们所需是text文字信息，所以要在name后添加text
//            [self.dbManger addmusicList:thesong];
        }
        [self.musiclistTbale reloadData];
        } stateerror:^(id responseObject) {
    } error:^(NSError *error) {
    } controller:self];
}

-(void)refreshHeader
{
    self.page=1;
    [self getdata];
    [self.musiclistTbale reloadData];
    [self.musiclistTbale.mj_header endRefreshing];
    [self.musiclistTbale reloadData];
}
-(void)refreshFooter
{
    _page++;
    [self.musiclistTbale reloadData];
    [self.musiclistTbale.mj_footer endRefreshing];
    [MBProgressHUD showInfo:@""];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30*self.page;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TableViewCell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] lastObject];
     }
    MusicListModel *song;
    song =self.songList[indexPath.row]; //由于无法直接赋值 需要声明个字符串
    if (indexPath.row==0) {
        cell.heardimage.image=[UIImage imageNamed:@"music_tuijian"];
    }
    else if (indexPath.row==1)
    {
        cell.heardimage.image=[UIImage imageNamed:@"第二名"];
    }
    else if (indexPath.row==2)
    {
        cell.heardimage.image=[UIImage imageNamed:@"第三"];
    }
    NSURL *imageurl=[NSURL URLWithString:song.albumpic_small];
    [cell.songimage setImageWithURL:imageurl placeholderImage:[UIImage imageNamed:@"cm2_default_act_133"]];
    cell.name.text=song.songname;
    cell.number.text=song.singername;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    playViewController *theVC=[[playViewController alloc]init];
    theVC.musicManager = [AVPlayerManager shareManager];
    theVC.musicManager.listInto = YES;
    if (theVC.musicManager.musicArray.count <=0) {
        theVC.songArray = self.songList;
    }else{
        [theVC.musicManager removeObserver];
    }
    theVC.index=indexPath.row;
    theVC.songArray=self.songList;
    [self presentViewController:theVC animated:YES completion:nil];
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
