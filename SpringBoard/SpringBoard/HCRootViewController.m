//
//  HCRootViewController.m
//  SpringBoard
//
//  Created by wangpo on 2018/9/20.
//  Copyright © 2018年 wangpo. All rights reserved.
//

#import "HCRootViewController.h"
#import "HCAssistant.h"
#import "HCPreviousPage.h"
#import "ViewController.h"

@interface HCRootViewController ()<UIScrollViewDelegate>
{
  
}

@end

@implementation HCRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect scrollRect = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    UIScrollView *loveScrollView = [[UIScrollView alloc]initWithFrame:scrollRect];
    loveScrollView.bounces = NO;
    loveScrollView.pagingEnabled = YES;
    loveScrollView.backgroundColor = [UIColor clearColor];
    loveScrollView.showsHorizontalScrollIndicator = NO;
    loveScrollView.showsVerticalScrollIndicator = NO;
    loveScrollView.delegate = self;
    [self.view addSubview:loveScrollView];
    
    HCPreviousPage *preView = [[HCPreviousPage alloc] init];
    preView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [loveScrollView addSubview:preView];
    
    _nextViewController = [[ViewController alloc] init];
    UIView *nextView =_nextViewController.view;
    nextView.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight);
    [loveScrollView addSubview:nextView];
    
    loveScrollView.contentSize = CGSizeMake(ScreenWidth * 2, ScreenHeight);
    [loveScrollView setContentOffset:CGPointMake(ScreenWidth, 0)];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_nextViewController eCardHidden];
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
