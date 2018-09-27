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

@property (nonatomic, strong) UIView *blankView;//空白视图
@end

@implementation HCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _navBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, (IPhoneX ? 88 : 64))];
    _navBarView.backgroundColor = [UIColor colorWithRed:138.0/255.0 green:184.0/255.0 blue:250.0/255.0 alpha:1];
    [self.view addSubview:_navBarView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (IPhoneX ? 44 : 20), kScreenSize.width, 40)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:20.0f];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = self.title;
    [_navBarView addSubview:_titleLabel];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(kScreenSize.width - 40, (IPhoneX ? 44 : 20)+7, 30, 30);
    [closeBtn setImage:[UIImage imageNamed:@"app_close"] forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [_navBarView addSubview:closeBtn];
    
    [self.view addSubview:self.webView];
    self.webView.frame = CGRectMake(0, (IPhoneX ? 88 : 64), kScreenSize.width, kScreenSize.height -(IPhoneX ? 88 : 64) );
    if ([self.url length] > 0) {
         [self requestData];
    }else{
        self.blankView.frame = self.webView.bounds;
        [self.webView addSubview:self.blankView];
    }
}

- (void)close:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIView *)blankView
{
    if (!_blankView) {
        _blankView = [[UIView alloc] initWithFrame:CGRectZero];
        _blankView.backgroundColor = [UIColor whiteColor];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, kScreenSize.width,20)];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.textColor = [UIColor blackColor];
        contentLabel.font = [UIFont systemFontOfSize:20.0f];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.numberOfLines = 1;
        contentLabel.text = [NSString stringWithFormat:@"%@",@"*正在建设中...*"];
        [_blankView addSubview:contentLabel];
    }
    return _blankView;
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
