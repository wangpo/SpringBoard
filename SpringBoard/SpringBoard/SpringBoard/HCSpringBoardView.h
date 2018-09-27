//
//  HCSpringBoardView.h
//  HCSpringBoard
//
//  Created by 刘海川 on 16/3/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCAssistant.h"
#import "HCIndexRect.h"
#import "HCFavoriteFolderModel.h"
#import "HCFavoriteFolderView.h"
#import "HCFavoriteIconModel.h"
#import "HCFavoriteIconView.h"
@class HCSpringBoardView;

@protocol HCSpringBoardDelegate <NSObject>
- (void)springBoardDidScroll:(HCSpringBoardView *)springBoard;

@end

extern const NSInteger drawIconTag;
@interface HCSpringBoardView : UIView<
UIScrollViewDelegate,
HCFavoriteIconDelegate,
HCLoveFolderDelegate,
HCFavoriteIconLongGestureDelegate,
HCLoveFolderLongGestureDelegate
>

@property (nonatomic, strong) NSMutableArray *favoriteModelArray;
@property (nonatomic, strong) NSMutableArray *favoriteViewArray;
@property (nonatomic, strong) HCFavoriteIconModel *favoriteMainMenu;
@property (nonatomic, weak) id <HCSpringBoardDelegate> springBoardDelegate;
//拖动状态
@property (nonatomic, assign) BOOL isDraw;
@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, assign) NSInteger currentPage;

- (instancetype)initWithFrame:(CGRect)frame modes:(NSMutableArray *)models;
- (void)showEditButton;
- (void)archiverIconModelsArray;
- (void)archiverLoveMenuMainModel;
- (void)pushPageOfLoveIconView:(HCFavoriteIconView *)iconView;

- (void)updateMenuIconsFrame;
- (void)updateIconModelDisplay:(HCFavoriteIconModel *)allModel nodeIndex:(NSString *)nodel;

- (void)updateMenuUIWithLoveIconArray;
- (void)doneButtonAction;
@end
