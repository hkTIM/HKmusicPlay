//
//  HKMyMusicViewController.m
//  HKmusicPlay
//
//  Created by 黄坤 on 2016/10/12.
//  Copyright © 2016年 黄坤. All rights reserved.
//

#import "HKMyMusicViewController.h"
#import "HKMusicforMyTableViewCell.h"
@interface HKMyMusicViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *myMusicTable;
@property (strong,nonatomic) NSArray *namelist;
@property (strong,nonatomic) NSArray *imagelist;

@property (strong ,nonatomic) NSMutableArray *resultsArray;
@property (copy,nonatomic)NSIndexPath *selectIndexPath;//tableview的行号
@property (assign,nonatomic)BOOL isOpen;

@end

@implementation HKMyMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的音乐";
    self.myMusicTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.hk_width, self.view.hk_height) style:UITableViewStylePlain];
    self.myMusicTable.delegate=self;
    self.myMusicTable.dataSource=self;
    [self.view addSubview:self.myMusicTable];
    self.namelist=[[NSArray alloc]initWithObjects:@"下载音乐",@"最近播放",@"我的歌手", nil];
    self.imagelist=[[NSArray alloc]initWithObjects:@"cm2_lay_icn_dld_new",@"cm2_lay_icn_time",@"cm2_lay_order_artist_new", nil];
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.namelist.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isOpen==YES&&self.selectIndexPath.section==section) {
        return 5+1;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HKMusicforMyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"HKMusicforMyTableViewCell"];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"HKMusicforMyTableViewCell" owner:self options:nil] lastObject];
    }
    if (indexPath.row==0) {
    NSString *image=self.imagelist[indexPath.section];
    cell.HKheadImage.image=[UIImage imageNamed:image];
    cell.HKname.text=self.namelist[indexPath.section];
    cell.HKnumber.text=[NSString stringWithFormat:@"0"];
    [cell.HKnumber setTextColor:[UIColor lightGrayColor]];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if (indexPath.section==self.namelist.count-1)
    {
        if (self.isOpen==NO) {
             cell.separatorInset=UIEdgeInsetsMake(0, self.view.hk_width, 0, 0);
        }
        else{
             cell.separatorInset=UIEdgeInsetsMake(0, 54, 0, 0);
        }
    }
    else
    {
        tableView.separatorInset=UIEdgeInsetsMake(0, 54, 0, 0);
    }
    UIView *view=[UIView new];
    view.backgroundColor=[UIColor clearColor];
    [tableView setTableFooterView:view];
    }
    else
    {
        cell.HKheadImage.image=[UIImage imageNamed:@"cm2_skin_theme_white"];
        cell.HKname.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row-1];
        cell.HKnumber.text=[NSString stringWithFormat:@""];
        [cell.HKnumber setTextColor:[UIColor lightGrayColor]];
//        cell.textLabel.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row-1];
        if (indexPath.row==5)
        {
            cell.separatorInset=UIEdgeInsetsMake(0, self.view.hk_width, 0, 0);
        }
        else
        {
            cell.separatorInset=UIEdgeInsetsMake(0,20, 0, 0);
        }
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.isOpen) {
        if (indexPath.section==self.selectIndexPath.section) {
            if (indexPath.row==0) {
                self.isOpen=NO;
                
            }else{
                //处理跳转到bill详情
            }
        }else{
            self.selectIndexPath=indexPath;
//            self.resultsArray=[self.dbManger readBillMonth:_allkeys[indexPath.section]];
            self.isOpen=YES;
        }
    }else{
        self.selectIndexPath=indexPath;
//        self.resultsArray=[self.dbManger readBillMonth:_allkeys[indexPath.section]];
        self.isOpen=YES;
    }
    [tableView reloadData];
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
