//
//  HCPlaceholderViewController.m
//  SpringBoard
//
//  Created by wangpo on 2018/9/30.
//  Copyright © 2018年 wangpo. All rights reserved.
//

#import "HCPlaceholderViewController.h"
#import "HCAssistant.h"
@interface HCPlaceholderViewController ()

@end

@implementation HCPlaceholderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 40, 40);
    [rightButton setTitle:@"关闭"  forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [rightButton setTitleColor:[UIColor colorWithRed:0.02f green:0.45f blue:0.88f alpha:1.00f] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(doneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"p%@",self.title]];
    imageView.image = image;
    imageView.frame = CGRectMake((ScreenWidth-image.size.width)/2, (IPhoneX ? 88 : 64), image.size.width, image.size.height);
    [self.view addSubview:imageView];
   
   
}

-(void)doneButtonAction:(UIButton*)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
