//
//  HCRootViewController.h
//  SpringBoard
//
//  Created by wangpo on 2018/9/20.
//  Copyright © 2018年 wangpo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCViewController.h"
#import "HCLastViewController.h"
#import "HCPreviousViewController.h"

@interface HCRootViewController : UIViewController

@property (nonatomic, strong) HCPreviousViewController *preVC;
@property (nonatomic, strong) HCViewController *midVC;
@property (nonatomic, strong) HCLastViewController *lastVC;

@end
