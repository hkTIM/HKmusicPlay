//
//  HKMusicTabBarViewController.m
//  HKmusicPlay
//
//  Created by 黄坤 on 2016/10/12.
//  Copyright © 2016年 黄坤. All rights reserved.
//

#import "HKMusicTabBarViewController.h"
#import "HKMyMusicViewController.h"
#import "HKcommentViewController.h"
#import "HKPlayerIDViewController.h"
#import "HKFindMusicViewController.h"
#import "HKNavigationViewController.h"
@interface HKMusicTabBarViewController ()

@end

@implementation HKMusicTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /** 设置文字属性 */
    // 设置普通状态下
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    // 统一设置所有item
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    // 设置选中状态下
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blueColor];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    
    [self setUpChildViewWith:[[HKNavigationViewController alloc] initWithRootViewController:[[HKFindMusicViewController alloc]init]]Image:@"cm2_btm_icn_discovery" SelectedImage:@"cm2_btm_icn_discovery_prs" Title:@"发现音乐"];
    
    [self setUpChildViewWith:[[HKNavigationViewController alloc] initWithRootViewController:[[HKMyMusicViewController alloc]init]] Image:@"cm2_btm_icn_music" SelectedImage:@"cm2_btm_icn_music_prs" Title:@"我的音乐"];
    
    [self setUpChildViewWith:[[HKNavigationViewController alloc] initWithRootViewController:[[HKcommentViewController alloc]init]] Image:@"cm2_btm_icn_friend" SelectedImage:@"cm2_btm_icn_friend" Title:@"朋友"];
    
    [self setUpChildViewWith:[[HKNavigationViewController alloc] initWithRootViewController:[[HKPlayerIDViewController alloc]init]] Image:@"cm2_btm_icn_account" SelectedImage:@"cm2_btm_icn_account_prs" Title:@"账号"];

    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
}

// TabBarController添加子控制器
-(void)setUpChildViewWith:(UIViewController *)vc Image:(NSString *)image SelectedImage:(NSString *)selectedImage Title:(NSString *)title
{
    vc.tabBarItem.title = title;
    if (image.length) {
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    [self addChildViewController:vc];
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
