//
//  ViewController.h
//  HCSpringBoard
//
//  Created by 刘海川 on 16/3/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCAssistant.h"
#import "HCFavoriteIconModel.h"
#import "NSObject+YYModel.h"
#import "HCSpringBoardView.h"

@interface ViewController : UIViewController <HCSpringBoardDelegate> {
    HCFavoriteIconModel *_favoriteMainMenu;
}

@property (nonatomic, strong) HCFavoriteIconModel *favoriteMainMenu;
@property (nonatomic, strong) UIView * navBarView;
@property (nonatomic, strong) UILabel *titleLabel;
- (void)eCardHidden;
@end

