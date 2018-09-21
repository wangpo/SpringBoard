//
//  HCFavoriteFolderView.m
//  HCSpringBoard
//
//  Created by 刘海川 on 16/3/6.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCFavoriteFolderView.h"
#import "HCFavoriteIconModel.h"
#import "HCAssistant.h"

static const CGFloat iconLabelFont = 13.0f;
static const CGFloat littleIconSpace = 3;

@interface HCFavoriteFolderView()
{
    UILabel *menuLabel;
   
}
@property (nonatomic, strong) NSMutableArray *littleIconViewArray;
@property (nonatomic, strong)  CALayer *folderLayer;
@end

@implementation HCFavoriteFolderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;

        self.littleIconViewArray = [[NSMutableArray alloc]initWithCapacity:4];
        //文件夹layer
        CGFloat layerSize = 50;
        _folderLayer = [[CALayer alloc] init];
        _folderLayer.frame = CGRectMake((frame.size.width-layerSize)/2, 10, layerSize, layerSize);
        _folderLayer.borderWidth = .5f;
        _folderLayer.borderColor = [UIColor lightGrayColor].CGColor;
        _folderLayer.cornerRadius = 10;
        _folderLayer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5].CGColor;
        [self.layer addSublayer:_folderLayer];
        
        //9宫格图标视图
        CGFloat iconWidthHeight = (CGRectGetWidth(_folderLayer.frame)-littleIconSpace*6)/3;
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                CGRect iconViewFrame = CGRectMake(littleIconSpace*2+(j*(littleIconSpace+iconWidthHeight)), littleIconSpace*2+(i*(littleIconSpace+iconWidthHeight)), iconWidthHeight, iconWidthHeight);
                UIImageView *littleIconView = [[UIImageView alloc]initWithFrame:iconViewFrame];
                [_folderLayer addSublayer:littleIconView.layer];
                [self.littleIconViewArray addObject:littleIconView];
            }
        }
        menuLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        menuLabel.frame =  CGRectMake(5, layerSize+10, CGRectGetWidth(frame)-10, 20);
        menuLabel.numberOfLines = 1;
        menuLabel.textAlignment = NSTextAlignmentCenter;
        menuLabel.font = [UIFont systemFontOfSize:iconLabelFont];
        menuLabel.textColor = [UIColor whiteColor];
        menuLabel.text = @"文件夹";
        [self addSubview:menuLabel];
        
        [self addTarget:self action:@selector(folderAction:) forControlEvents:UIControlEventTouchUpInside];
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self        action:@selector(longGestureAction:)];
        [self addGestureRecognizer:longGesture];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame model:(HCFavoriteFolderModel *)model {
    self = [self initWithFrame:frame];
    if (self) {
        self.loveFolderModel = model;
    }
    return self;
}

- (void)setFolderName:(NSString *)folderName {
    _folderName = folderName;
    menuLabel.text = _folderName;
}

- (void)setLoveFolderModel:(HCFavoriteFolderModel *)loveFolderModel {
    _loveFolderModel = loveFolderModel;
    menuLabel.text = _loveFolderModel.folderName;
    [self updateLittleIconImage];
}

- (void)setIsShowScaleFolderLayer:(BOOL)isShowScaleFolderLayer {
    if (_isShowScaleFolderLayer == isShowScaleFolderLayer) {
        return;
    }
    _isShowScaleFolderLayer = isShowScaleFolderLayer;
    //可加动画
     __weak typeof(self) weakSelf = self;
    if (_isShowScaleFolderLayer) {
        [UIView animateWithDuration:0.6 animations:^{
            [weakSelf.folderLayer setAffineTransform:CGAffineTransformMakeScale(1.2, 1.2)];
        }];
    }else {
        [UIView animateWithDuration:0.6 animations:^{
            [weakSelf.folderLayer setAffineTransform:CGAffineTransformIdentity];
        }];
    }
}

- (void)updateLittleIconImage {
    [self.littleIconViewArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *littleIconImageView = obj;
        littleIconImageView.image = nil;
    }];
    
    int count = 0;
    if (_loveFolderModel.iconModelsFolderArray.count > 9) {
        count = 9;
    }
    else {
        count = (int)_loveFolderModel.iconModelsFolderArray.count;
    }
    
    for (int i = 0; i < count ; i++) {
        UIImageView *littleIconImageView = self.littleIconViewArray[i];
        HCFavoriteIconModel *loveIconModel = _loveFolderModel.iconModelsFolderArray[i];
        littleIconImageView.image = [UIImage imageNamed:loveIconModel.image];
    }
}

- (void)folderAction:(id)sender{
    //进入文件夹页面
    if (_loveFolderDelegate && [_loveFolderDelegate respondsToSelector:@selector(openLoveFolderOfLoveFolderView:)]) {
        [_loveFolderDelegate openLoveFolderOfLoveFolderView:self];
    }
}

- (void)longGestureAction:(UILongPressGestureRecognizer *)gesture {
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            if (_loveFolderDelegate && [_loveFolderDelegate respondsToSelector:@selector(intoEditingModeOfLoveFolderView:)]) {
                [_loveFolderDelegate intoEditingModeOfLoveFolderView:self];
            }
            if (_loveFolderLongGestureDelegate && [_loveFolderLongGestureDelegate respondsToSelector:@selector(longGestureStateBegin:forLoveFolderView:)]) {
                [_loveFolderLongGestureDelegate longGestureStateBegin:gesture forLoveFolderView:self];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if (_loveFolderLongGestureDelegate && [_loveFolderLongGestureDelegate respondsToSelector:@selector(longGestureStateMove:forLoveFolderView:)]) {
                [_loveFolderLongGestureDelegate longGestureStateMove:gesture forLoveFolderView:self];
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if (_loveFolderLongGestureDelegate && [_loveFolderLongGestureDelegate respondsToSelector:@selector(longGestureStateEnd:forLoveFolderView:)]) {
                [_loveFolderLongGestureDelegate longGestureStateEnd:gesture forLoveFolderView:self];
            }
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            if (_loveFolderLongGestureDelegate && [_loveFolderLongGestureDelegate respondsToSelector:@selector(longGestureStateCancel:forLoveFolderView:)]) {
                [_loveFolderLongGestureDelegate longGestureStateCancel:gesture forLoveFolderView:self];
            }
        }
            break;
            
        default:
            break;
    }
}

@end
