//
//  HCLastViewController.m
//  SpringBoard
//
//  Created by wangpo on 2018/9/27.
//  Copyright © 2018年 wangpo. All rights reserved.
//

#import "HCLastViewController.h"
#import "HCInstalledListViewController.h"
#import "AppDelegate.h"

@interface HCLastViewController ()

@end

@implementation HCLastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor = [UIColor clearColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 150, 150);
    button.center = self.view.center;
    [self.view addSubview:button];
}

- (void)add
{
    HCInstalledListViewController *menuListViewController = [[HCInstalledListViewController alloc] initWithMainMenu:APP.launcherController.midVC.favoriteMainMenu.itemList];
    [APP.launcherController presentViewController:[[UINavigationController alloc] initWithRootViewController:menuListViewController] animated:YES completion:nil];
    
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
