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
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    self.webView.frame =  CGRectMake(0, (IPhoneX ? 88 : 64), kScreenSize.width, kScreenSize.height -(IPhoneX ? 88 : 64) );
    if ([self.url length] > 0) {
        [self requestData];
    }
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
    NSString * urlString = _url;
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
