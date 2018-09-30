//
//  HCWebViewController.h
//  SpringBoard
//
//  Created by wangpo on 2018/9/20.
//  Copyright © 2018年 wangpo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCWebViewController;

@protocol HCWebViewControllerDelegate <NSObject>

- (void)closeWebView:(HCWebViewController *)webVC;

@end


@interface HCWebViewController : UIViewController

@property (nonatomic, weak) id<HCWebViewControllerDelegate>delegate;
@property (nonatomic, copy) NSString *url;
- (void)requestData;
@end
