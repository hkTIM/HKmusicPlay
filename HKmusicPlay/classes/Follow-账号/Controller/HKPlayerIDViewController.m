//
//  HKPlayerIDViewController.m
//  HKmusicPlay
//
//  Created by 黄坤 on 2016/10/12.
//  Copyright © 2016年 黄坤. All rights reserved.
//

#import "HKPlayerIDViewController.h"
#import "HKLoginViewController.h"
@interface HKPlayerIDViewController ()

@end

@implementation HKPlayerIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"账号";
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.hk_width, self.view.hk_height)];
    imageview.image=[UIImage imageNamed:@"cm2_guide_start8"];
    [self.view addSubview:imageview];
    UIButton *Btn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width -200)/ 2,self.view.frame.size.height-150,200, 60)];

    [Btn setTitle:@"立即登录" forState:UIControlStateNormal];
    Btn.backgroundColor=[UIColor darkGrayColor];
    Btn.layer.borderColor = [[UIColor whiteColor] CGColor];
    Btn.layer.borderWidth = 1.0f;
    [Btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(gologin) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:Btn];
    // Do any additional setup after loading the view.
}
-(void)gologin
{
    HKLoginViewController *LoginRegisterVC=[[HKLoginViewController alloc]init];
    [self presentViewController:LoginRegisterVC animated:YES completion:nil];
//    [self.navigationController pushViewController:LoginRegisterVC animated:YES];
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
