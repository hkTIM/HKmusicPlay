//
//  HKLoginViewController.m
//  HKmusicPlay
//
//  Created by 黄坤 on 2016/10/14.
//  Copyright © 2016年 黄坤. All rights reserved.
//

#import "HKLoginViewController.h"

@interface HKLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end

@implementation HKLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.numberTextField.keyboardType=UIKeyboardTypeNumberPad;
    self.nameTextField.keyboardType=UIKeyboardTypeDefault;
    self.nameTextField.returnKeyType=UIReturnKeyDone;
    // Do any additional setup after loading the view from its nib.
}
//设置🔋栏颜色
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view  endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginBtn:(UIButton *)sender {
    NSLog(@"进来了");
}
- (IBAction)HKLogindismissBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)showLoginOrRegister:(id)sender {
    NSLog(@"进来了");
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
