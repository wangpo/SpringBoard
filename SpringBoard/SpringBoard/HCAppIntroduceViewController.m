//
//  HCAppIntroduceViewController.m
//  SpringBoard
//
//  Created by wangpo on 2018/9/28.
//  Copyright © 2018年 wangpo. All rights reserved.
//

#import "HCAppIntroduceViewController.h"
#import "HCAssistant.h"
@interface HCAppIntroduceViewController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation HCAppIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 75, 30);
    rightButton.layer.cornerRadius = 15;
    rightButton.layer.masksToBounds = YES;
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [rightButton setBackgroundColor:[UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0]];
    [rightButton setTitleColor:[UIColor colorWithRed:21.0/255.0 green:90.0/255.0 blue:198.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(installButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    if (self.loveModel.display) {
        [rightButton setTitle:@"卸载" forState:UIControlStateNormal];
    }else{
        [rightButton setTitle:@"安装" forState:UIControlStateNormal];
    }
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;
    
    
    self.title = self.loveModel.name;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    self.webView.frame =  CGRectMake(0, (IPhoneX ? 88 : 64), kScreenSize.width, kScreenSize.height -(IPhoneX ? 88 : 64) );
    if ([self.loveModel.url length] > 0) {
        [self requestData];
    }
}

- (void)installButtonAction:(UIButton *)sender
{
    if (self.loveModel.display) {
        [sender setTitle:@"安装" forState:UIControlStateNormal];
    }else{
        [sender setTitle:@"卸载" forState:UIControlStateNormal];
    }
    [self.parentVC performSelector:@selector(installAppRelayoutList:) withObject:self.loveModel];
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        _webView.dataDetectorTypes = UIDataDetectorTypeNone;
        _webView.scalesPageToFit = YES;
        _webView.allowsInlineMediaPlayback = YES;
        if (@available(iOS 11, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _webView;
}

- (void)requestData
{
    NSString * urlString = self.loveModel.url;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:30.f]];
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
