//
//  HKrecommendViewController.m
//  HKmusicPlay
//
//  Created by 黄坤 on 2016/10/12.
//  Copyright © 2016年 黄坤. All rights reserved.
//

#import "HKrecommendViewController.h"

@interface HKrecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong ,nonatomic)UITableView *tableview;
@property(strong ,nonatomic)NSMutableArray *dataArray;
@property(assign ,nonatomic)NSInteger page;

@end

@implementation HKrecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"个性推荐");
    self.tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,100, self.view.hk_width, self.view.hk_height-150)];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
//    self.tableview.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:self.tableview];
    self.tableview.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    self.tableview.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    self.page=1;
    self.dataArray = [NSMutableArray arrayWithObjects:
                 @"Google", @"百　度", @"网　易", @"微 博", @"优 酷 网", @"淘 宝 网",
                 @"亚 马 逊",  @"天猫",nil];
    
    // Do any additional setup after loading the view.
}
-(void)refreshHeader
{
    self.page=1;
    self.dataArray = [NSMutableArray arrayWithObjects:
                      @"Google", @"百　度", @"网　易", @"微 博", @"优 酷 网", @"淘 宝 网",
                      @"亚 马 逊",  @"天猫",nil];
    [self.tableview reloadData];
    [self.tableview.mj_header endRefreshing];
    [MBProgressHUD showInfo:@""];

}
-(void)refreshFooter
{
    if (self.page==1) {
        NSArray *array=[NSArray arrayWithObjects:@"艺龙酒店", @"美 团 网", @"上品折扣", @"C N T V", @"腾  讯",@"新  浪", @"当　当", @"凤 凰 网", @"MSN中文网", @"猫　扑", nil];
        self.dataArray=[NSMutableArray arrayWithArray:[self.dataArray arrayByAddingObjectsFromArray:array]];
        [self.tableview reloadData];
        [self.tableview.mj_footer endRefreshing];
        self.page++;
    }
    else
    {
        [self.tableview.mj_footer endRefreshing];
        [MBProgressHUD showInfo:@""];
    }
}
/**
 *ios MJRefresh下拉刷新 动画
 *集成请求方法
 */
//- (void)prepareRefresh
//{
//    NSMutableArray *headerImages = [NSMutableArray array];
//    for (int i = 1; i <= 4; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"topload%d",i]];
//        [headerImages addObject:image];
//    }
//    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
//        //下拉刷新要做的操作.
//    }];
//    gifHeader.stateLabel.hidden = YES;
//    gifHeader.lastUpdatedTimeLabel.hidden = YES;
//    
//    [gifHeader setImages:@[headerImages[0]] forState:MJRefreshStateIdle];
//    [gifHeader setImages:headerImages forState:MJRefreshStateRefreshing];
//    self.tableview.header = gifHeader;
//    
//    
//    NSMutableArray *footerImages = [NSMutableArray array];
//    for (int i = 1; i <= 4; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"footerload%d",i]];
//        [footerImages addObject:image];
//    }
//    MJRefreshAutoGifFooter *gifFooter = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
//        //上拉加载需要做的操作.
//    }];
//    
//    gifFooter.stateLabel.hidden = YES;
//    gifFooter.refreshingTitleHidden = YES;
//    [gifFooter setImages:@[footerImages[0]] forState:MJRefreshStateIdle];
//    [gifFooter setImages:footerImages forState:MJRefreshStateRefreshing];
//    self.tableview.footer = gifFooter;
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text=self.dataArray[indexPath.row];
    
    UIView *view=[UIView new];//声明个view 将tableView 的FooterView 覆盖上
    view.backgroundColor=[UIColor clearColor];
    [tableView setTableFooterView:view];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    UIViewController *theVC=[[UIViewController alloc]init];
//    theVC.view.backgroundColor=[UIColor whiteColor];
//    [self presentViewController:theVC animated:YES completion:nil];
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
