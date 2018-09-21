//
//  HCWebViewController.m
//  SpringBoard
//
//  Created by wangpo on 2018/9/20.
//  Copyright © 2018年 wangpo. All rights reserved.
//

#import "HCWebViewController.h"
#import "HCAssistant.h"
@interface HCWebViewController ()
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIView * navBarView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _navBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, (IPhoneX ? 88 : 64))];
    _navBarView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    [self.view addSubview:_navBarView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (IPhoneX ? 44 : 20), kScreenSize.width, 40)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = self.title;
    [_navBarView addSubview:_titleLabel];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(kScreenSize.width - 60, (IPhoneX ? 44 : 20), 40, 40);
    [closeBtn setImage:[UIImage imageNamed:@"app_close"] forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [_navBarView addSubview:closeBtn];
    
    
    [self.view addSubview:self.webView];
    self.webView.frame = CGRectMake(0, (IPhoneX ? 88 : 64), kScreenSize.width, kScreenSize.height -(IPhoneX ? 88 : 64) );
    
   
    [self requestData];
}

- (void)close:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
