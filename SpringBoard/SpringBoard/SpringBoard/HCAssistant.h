//
//  HCAssistant.h
//  HCSpringBoard
//
//  Created by 刘海川 on 16/3/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define angelToRandian(x) ((x)/180.0*M_PI)

#pragma mark - window
#define AppWindow ((AppDelegate *)[[UIApplication sharedApplication] delegate]).window


#pragma mark - UserDefaultKey
#define kUserDefaultSuiteNameLoveMenu @"kUserDefaultSuiteNameLoveMenu"
#define kUserDefaultLoveMenuKey @"kUserDefaultLoveMenuKey"
#define kIsFirst @"kIsFirst"

#pragma mark - 尺寸
#define kScreenSize [[UIScreen mainScreen] bounds].size
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define IPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define BFLStatusBarHeight      (IPhoneX ? 44 : 20)

#define ICONIMG_WIDTH ([[UIScreen mainScreen] bounds].size.width)/4
#define ICONIMG_HEIGHT ICONIMG_WIDTH
#define ICONIMG_WIDTH_Float ([[UIScreen mainScreen] bounds].size.width-60)/3
#define ICONIMG_HEIGHT_Float ICONIMG_WIDTH_Float

#define ICONIMG_VERTICAL 30

#pragma mark - 文件路径
#define kMenuFileName @"menu.json"
#define DOCUMENT_FOLDER(fileName) [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:fileName]

#pragma mark - 宏定义
#pragma mark - 菜单Key



#define kMenuList @"MenuList"
#define kViewcontroller @"Viewcontroller"

#define kNodeType @"kNodeType"

#define kNodeName @"kNodeName"
#define kImage @"kImage"
#define kNodeDesc @"kNodeDesc"

#define kNodeUrl @"kNodeUrl"

#define kItems @"kItems"

#define kNeedLogin @"kNeedLogin"
#define kIsDisplay @"kIsDisplay"
#define kIsReadOnly @"kIsReadOnly"

#define kNodeIndex @"kNodeIndex"


@interface HCAssistant : NSObject
//生成菜单结构
+ (void)initMainMenu;

@end
