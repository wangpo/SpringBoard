//
//  HCFavoriteFolderFloatView.h
//  HCSpringBoard
//
//  Created by 刘海川 on 16/3/7.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCFavoriteFolderModel.h"
#import "HCFavoriteFolderView.h"
#import "HCAssistant.h"

@interface HCFavoriteFolderFloatView : UIView <UITextFieldDelegate>

@property (nonatomic, weak) id myControllerDelegate;
@property (nonatomic, weak) id mySpringBoardDelegate;
@property (nonatomic, strong) HCFavoriteFolderModel *loveFolderModel;
@property (nonatomic, strong) HCFavoriteFolderView *loveFolderView;

@property (nonatomic, strong) NSMutableArray *loveMainModels;

- (instancetype)initWithModel:(HCFavoriteFolderModel *)model;

- (void)hideFloatView;

@end
