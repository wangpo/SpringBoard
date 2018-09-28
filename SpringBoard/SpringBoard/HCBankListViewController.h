//
//  HCBankListViewController.h
//  HCSpringBoard
//
//  Created by 刘海川 on 16/3/7.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCAssistant.h"
@class HCBankListViewController;
@protocol BankListDelegate <NSObject>

- (void)addIconDone:(HCBankListViewController *)bankListViewController;

@end
@interface HCBankListViewController : UITableViewController

@property (nonatomic, weak) id <BankListDelegate> bankListDelegate;
@property (nonatomic, strong) NSMutableArray *allMenuModels;//已安装app(icon+folder)
@property (nonatomic, strong) NSArray *mainMenuList;//初始化全部app数据（安装+未安装）

@end
