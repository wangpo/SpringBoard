//
//  HCFavoriteFolderFloatView.m
//  HCSpringBoard
//
//  Created by 刘海川 on 16/3/7.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCFavoriteFolderFloatView.h"
#import "ViewController.h"
#import "HCSpringBoardView.h"
#import "HCFavoriteFolderMenuView.h"

@interface HCFavoriteFolderFloatView ()
{
    UITextField *folderNameField;
    HCFavoriteFolderMenuView *folderMenuView;
}
@end

@implementation HCFavoriteFolderFloatView

- (instancetype)initWithModel:(HCFavoriteFolderModel *)model {
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    if (self) {
        self.loveFolderModel = model;
        self.backgroundColor =[UIColor colorWithWhite:0.9 alpha:0.5];
        //高斯模糊
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = self.bounds;
        [self addSubview:effectView];
        
        folderNameField = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, ScreenWidth-40, 40)];
        folderNameField.font = [UIFont systemFontOfSize:30];
        folderNameField.delegate = self;
        folderNameField.textAlignment = NSTextAlignmentCenter;
        folderNameField.returnKeyType = UIReturnKeyDone;
        folderNameField.textColor = [UIColor whiteColor];
        folderNameField.text = self.loveFolderModel.folderName;
        [self addSubview:folderNameField];
        
        folderMenuView = [[HCFavoriteFolderMenuView alloc]initWithFrame:
                          CGRectMake(30, CGRectGetMaxY(folderNameField.frame)+20, ScreenWidth-60, ScreenWidth-60+25)
                                                             menuModels:_loveFolderModel.iconModelsFolderArray
                                                              menuIcons:_loveFolderModel.iconViewsFolderArray];
        folderMenuView.folderMenuDelegate = self;
        folderMenuView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
        folderMenuView.layer.cornerRadius = 20;
        folderMenuView.clipsToBounds = YES;
        [self addSubview:folderMenuView];
      
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self                     action:@selector(hideFloatView)];
        [self addGestureRecognizer:tapGesture];
        
    }

    return self;
}

- (void)setMyControllerDelegate:(id )myControllerDelegate {
    _myControllerDelegate = myControllerDelegate;
}

- (void)setMySpringBoardDelegate:(id)mySpringBoardDelegate {
    _mySpringBoardDelegate = mySpringBoardDelegate;
    
    if ([_mySpringBoardDelegate isKindOfClass:[HCSpringBoardView class]]) {
        HCSpringBoardView *springBoard = _mySpringBoardDelegate;
        if (springBoard.isEdit) {
            [folderMenuView showEditButton];
        }
        folderMenuView.outsideFolderGestureDelegate = springBoard;
    }
}

- (void)hideFloatView
{
    if ([folderNameField.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"文件夹名字不能为空" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else {
        [self.mySpringBoardDelegate archiverIconModelsArray];
        [folderNameField resignFirstResponder];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.loveFolderModel.folderName = textField.text;
    self.loveFolderView.folderName = textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.loveFolderModel.folderName = textField.text;
    self.loveFolderView.folderName = textField.text;
    [textField resignFirstResponder];
    return YES;
}

@end
