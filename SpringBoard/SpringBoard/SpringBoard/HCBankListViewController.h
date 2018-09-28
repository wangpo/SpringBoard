//
//  HCBankListViewController.h
//  HCSpringBoard
//
//  Created by 刘海川 on 16/3/7.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCAssistant.h"
@interface HCBankListViewController : UITableViewController

@property(nonatomic, assign) BOOL isAppList;
- (instancetype)initWithMainMenu:(NSArray *)mainMenu;

@end
