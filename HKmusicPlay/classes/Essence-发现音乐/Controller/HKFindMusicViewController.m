//
//  HKFindMusicViewController.m
//  HKmusicPlay
//
//  Created by 黄坤 on 2016/10/12.
//  Copyright © 2016年 黄坤. All rights reserved.
//

#import "HKFindMusicViewController.h"
#import "HKTitleBtn.h"
#import "HKrecommendViewController.h"//个性推荐
#import "HKradioViewController.h"//主播电台
#import "HKMusicListViewController.h"//歌单
#import "HKRankViewController.h"//排行榜
@interface HKFindMusicViewController ()<UIScrollViewDelegate>


// 选中按钮
@property(nonatomic,weak) HKTitleBtn *selectedButton;

// 底部指示条
@property(nonatomic,weak) UIView *indicatorView;

// scrollView
@property(nonatomic,weak) UIScrollView *scrollView;

// 标题栏
@property(nonatomic,weak) UIView *titlesView;

@end

@implementation HKFindMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"网易云音乐";
    NSLog(@"发现音乐");
  
    [self setUpTitlesView];
    [self setUpChildViewController];
    [self setUpScrollView];
    [self setUpTitlesView];
    [self addChildVcView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setUpChildViewController
{
    HKrecommendViewController *all = [[HKrecommendViewController alloc]init];
    [self addChildViewController:all];
    HKradioViewController *video = [[HKradioViewController alloc]init];
    [self addChildViewController:video];
    HKMusicListViewController *voice = [[HKMusicListViewController alloc]init];
    [self addChildViewController:voice];
    HKRankViewController *picture = [[HKRankViewController alloc]init];
    [self addChildViewController:picture];
}

// 添加子控制器
-(void)addChildVcView
{
    int index = self.scrollView.contentOffset.x / self.scrollView.hk_width;
    UIViewController *childVc = self.childViewControllers[index];
    //    childVc.view.frame = CGRectMake(index * self.scrollView.cl_width, 0, self.scrollView.cl_width, self.scrollView.cl_height);
    //可以化简成一句代码
    
    childVc.view.frame = self.scrollView.bounds;
    
    [self.scrollView addSubview:childVc.view];
    
}
// 设置scrollView
-(void)setUpScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.backgroundColor = CLCommonColor(206);
    [self.view addSubview:scrollView];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    NSInteger count = [self.childViewControllers count];
 
    scrollView.contentSize = CGSizeMake(self.view.hk_width * count, 0);
    scrollView.delegate = self;
    self.scrollView = scrollView;
}


// 设置标题view
-(void)setUpTitlesView
{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.hk_width, 35)];
    titleView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.6];
    
    self.titlesView = titleView;
    
    CGFloat buttonW = titleView.hk_width / 4.0;
    CGFloat buttonH = titleView.hk_height;
    
    NSArray *titlesArr = @[@"个性推荐",@"歌单",@"主播电台",@"排行榜"];
    NSInteger count = [titlesArr count];
    for (int i= 0; i < count ; i ++) {
        HKTitleBtn *titleButton = [HKTitleBtn buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        titleButton.frame = CGRectMake(i * buttonW, 0, buttonW, buttonH);
        [titleButton setTitle:titlesArr[i] forState:UIControlStateNormal];
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:titleButton];
    }
    [self.view addSubview:titleView];
    UIView *indicatorView = [[UIView alloc]init];
    // 也可以取出button selecter状态下的颜色
    //    UIButton *button = titleView.subviews.lastObject;
    //    indicatorView.backgroundColor = [button titleColorForState:UIControlStateSelected];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.hk_height = 2;
    indicatorView.hk_y = titleView.hk_height - 2;
    [titleView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    // 不想要动画
    HKTitleBtn *button = titleView.subviews.firstObject;
    [button.titleLabel sizeToFit];
    button.selected = YES;
    self.selectedButton = button;
    indicatorView.hk_width = button.titleLabel.hk_width + 6;
    indicatorView.hk_centerX = button.hk_centerX;
}

// 标题button点击事件
-(void)titleClick:(HKTitleBtn *)button
{
    // 某个标题按钮被重复点击了
//    if (button == self.selectedButton) {
//        
//    }
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    // 获取button title 的宽度
    // CGFloat titleW = [button.currentTitle sizeWithFont:button.titleLabel.font].width;
    // CGFloat titleW = [button.currentTitle sizeWithAttributes:@{NSFontAttributeName : button.titleLabel.font}].width;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.hk_width = button.titleLabel.hk_width + 6;
        self.indicatorView.hk_centerX = button.hk_centerX;
    }];
    
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = button.tag * self.view.hk_width;
    [self.scrollView setContentOffset:offset animated:YES];
}
#pragma mark UIScrollViewDelegate代理方法

// 滑动结束时，一定要调用[setcontentoffset animated ] 或者 [scrollerRactVisible animaated]方法让scroll产生滚动动画，动画结束时才会调用
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildVcView];
}

// 减速完成 也就是滑动完成
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 选中 点击对应的按钮
    int index = scrollView.contentOffset.x / scrollView.hk_width;
    // 添加子控制器
    [self addChildVcView];
    HKTitleBtn *button = self.titlesView.subviews[index];
    [self titleClick:button];
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
