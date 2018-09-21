//
//  HCFavoriteIconView.m
//  HCSpringBoard
//
//  Created by 刘海川 on 16/3/6.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCFavoriteIconView.h"
#import "HCAssistant.h"

static const CGFloat iconButtonWitdh = 50.0f;
static const CGFloat iconDeleteButtonWitdh = 20.0f;
static const CGFloat iconLabelHeight = 20.0f;
static const CGFloat iconLabelFont = 13.0f;

@interface HCFavoriteIconView ()
{
    UIButton *menuButton;
    UILabel *menuLabel;
    UIButton *delButton;
    
}
@property (nonatomic, strong) CALayer *folderLayer;
@end

@implementation HCFavoriteIconView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        menuButton = [[UIButton alloc]initWithFrame:CGRectMake((frame.size.width-iconButtonWitdh)/2, 10, iconButtonWitdh, iconButtonWitdh)];
        [menuButton addTarget:self action:@selector(menuButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:menuButton];
        
        menuLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(menuButton.frame)+5.0/320.0*ScreenWidth, CGRectGetWidth(frame)-10, iconLabelHeight)];
        menuLabel.numberOfLines = 1;
        menuLabel.textAlignment = NSTextAlignmentCenter;
        menuLabel.font = [UIFont systemFontOfSize:iconLabelFont];
        menuLabel.textColor = [UIColor whiteColor];
        [self addSubview:menuLabel];
        
        delButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(frame)-22.5, 2.5, iconDeleteButtonWitdh, iconDeleteButtonWitdh)];
        delButton.backgroundColor = [UIColor blackColor];
        [delButton setImage:[UIImage imageNamed:@"del"] forState:UIControlStateNormal];
        delButton.alpha = 0.9;
        delButton.layer.cornerRadius = iconDeleteButtonWitdh/2;
        [delButton addTarget:self action:@selector(delButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:delButton];
        delButton.hidden = YES;
        
      
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self
              action:@selector(longGestureAction:)];
        [self addGestureRecognizer:longGesture];
        [self addTarget:self action:@selector(menuButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //文件夹layer
        CGFloat layerSize = 50;
        _folderLayer = [[CALayer alloc] init];
        _folderLayer.frame = CGRectMake((frame.size.width-layerSize)/2, 5, layerSize, layerSize);
        _folderLayer.borderWidth = .5f;
        _folderLayer.borderColor = [UIColor lightGrayColor].CGColor;
        _folderLayer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5].CGColor;
        _folderLayer.cornerRadius = 10;
        [self.layer addSublayer:_folderLayer];
        _folderLayer.hidden = YES;
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame model:(HCFavoriteIconModel *)model
{
    self = [self initWithFrame:frame];
    if (self) {
        self.loveIconModel = model;
    }
    return self;
}

- (void)setIsEditing:(BOOL)isEditing
{
    _isEditing = isEditing;
    delButton.hidden = !_isEditing;
}

- (void)setIsShowFolderFlag:(BOOL)isShowFolderFlag
{
    if (_isShowFolderFlag == isShowFolderFlag) {
        return;
    }
    _isShowFolderFlag = isShowFolderFlag;
 
    __weak typeof(self) weakSelf = self;
    if (_isShowFolderFlag) {
        self.folderLayer.hidden = NO;
        [UIView animateWithDuration:0.6 animations:^{
            [weakSelf.folderLayer setAffineTransform:CGAffineTransformMakeScale(1.2, 1.2)];
        }];
    }
    else {
        [UIView animateWithDuration:0.6 animations:^{
            [weakSelf.folderLayer setAffineTransform:CGAffineTransformIdentity];
        } completion:^(BOOL finished) {
            weakSelf.folderLayer.hidden = YES;
        }];
    }
}

- (void)setLoveIconModel:(HCFavoriteIconModel *)loveIconModel {
    _loveIconModel = loveIconModel;
    
    [menuButton setImage:[UIImage imageNamed:_loveIconModel.image] forState:UIControlStateNormal];
    [menuButton setImage:[UIImage imageNamed:_loveIconModel.imageSeleted] forState:UIControlStateHighlighted];
    menuLabel.text = _loveIconModel.name;
  
}

- (void)menuButtonAction:(UILongPressGestureRecognizer *)gesture {
    if (_favoriteIconDelegate && [_favoriteIconDelegate respondsToSelector:@selector(pushPageOfLoveIconView:)]) {
        [_favoriteIconDelegate pushPageOfLoveIconView:self];
    }
}

- (void)delButtonAction:(UIButton *)button {
    if (_favoriteIconDelegate && [_favoriteIconDelegate respondsToSelector:@selector(deleteIconOfLoveIconView:)]) {
        [_favoriteIconDelegate deleteIconOfLoveIconView:self];
    }
}

- (void)longGestureAction:(UILongPressGestureRecognizer *)gesture {
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            if (_favoriteIconDelegate && [_favoriteIconDelegate respondsToSelector:@selector(intoEditingModeOfLoveIconView:)]) {
                [_favoriteIconDelegate intoEditingModeOfLoveIconView:self];
            }
            if (_favoriteIconLongGestureDelegate && [_favoriteIconLongGestureDelegate respondsToSelector:@selector(longGestureStateBegin:forLoveView:)]) {
                [_favoriteIconLongGestureDelegate longGestureStateBegin:gesture forLoveView:self];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if (_favoriteIconLongGestureDelegate && [_favoriteIconLongGestureDelegate respondsToSelector:@selector(longGestureStateMove:forLoveView:)]) {
                [_favoriteIconLongGestureDelegate longGestureStateMove:gesture forLoveView:self];
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if (_favoriteIconLongGestureDelegate && [_favoriteIconLongGestureDelegate respondsToSelector:@selector(longGestureStateEnd:forLoveView:)]) {
                [_favoriteIconLongGestureDelegate longGestureStateEnd:gesture forLoveView:self];
            }
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            if (_favoriteIconLongGestureDelegate && [_favoriteIconLongGestureDelegate respondsToSelector:@selector(longGestureStateCancel:forLoveView:)]) {
                [_favoriteIconLongGestureDelegate longGestureStateCancel:gesture forLoveView:self];
            }
        }
            break;
            
        default:
            break;
    }
}

@end
