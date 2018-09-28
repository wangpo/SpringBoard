//
//  AppDelegate.h
//  SpringBoard
//
//  Created by wangpo on 2018/9/19.
//  Copyright © 2018年 wangpo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCRootViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) HCRootViewController *launcherController;

@end

extern AppDelegate *APP;
