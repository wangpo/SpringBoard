//
//  HCRootViewController.h
//  SpringBoard
//
//  Created by wangpo on 2018/9/20.
//  Copyright © 2018年 wangpo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "HCLastViewController.h"

@interface HCRootViewController : UIViewController
@property (nonatomic, strong)  ViewController *nextViewController;
@property (nonatomic, strong) HCLastViewController *lastVC;
@end
