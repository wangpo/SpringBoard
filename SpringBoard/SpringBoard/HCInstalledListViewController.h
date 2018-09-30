//
//  HCSpringBoard
//
//  Created on 16/3/7.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCFavoriteIconModel.h"

@class HCInstalledListViewController;

@protocol HCInstalledListViewControllerDelegate <NSObject>

- (void)addAppToPageDone:(HCInstalledListViewController *)vc;

@end

@interface HCInstalledListViewController : UITableViewController

@property (nonatomic, weak) id <HCInstalledListViewControllerDelegate> delegate;
@property(nonatomic, strong) NSMutableArray *mainMenuList;
@property(nonatomic, strong) HCFavoriteIconModel *addToPageModel;

@end
