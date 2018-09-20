//
//  ViewController.m
//  HCSpringBoard
//
//  Created by 刘海川 on 16/3/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "ViewController.h"
#define isIPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define BFLStatusBarHeight      (isIPhoneX ? 44 : 20)
@interface ViewController () {
    
    NSMutableArray *_iconModelsArray;
    
    HCSpringBoardView *_springBoard;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, (isIPhoneX ? 88 : 64))];
    topView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    [self.view addSubview:topView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (isIPhoneX ? 44 : 20), kScreenSize.width, 44)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"自然人";
    [topView addSubview:_titleLabel];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[[UIImage imageNamed:@"bg"] stretchableImageWithLeftCapWidth:320 topCapHeight:568]];
    //获取序列化到本地的所有菜单
    NSDictionary *mainMenuDict = [[NSDictionary alloc]initWithContentsOfFile:DOCUMENT_FOLDER(kMenuFileName)];
    _favoriteMainMenu = [HCFavoriteIconModel modelWithDictionary:mainMenuDict];
    [self displayMenu];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_springBoard) {
        if (_springBoard.isEdit) {
            [_springBoard showEditButton];
        }
    }
}

- (void)displayMenu {
    _iconModelsArray = [[NSMutableArray alloc]init];
    //取出要显示的数据
    NSUserDefaults *userDefaultsLoveMenu = [[NSUserDefaults alloc]initWithSuiteName:kUserDefaultSuiteNameLoveMenu];
    NSArray *userDefaultsLoveMenuArray = [userDefaultsLoveMenu objectForKey:kUserDefaultLoveMenuKey];
    if (userDefaultsLoveMenu && userDefaultsLoveMenuArray) {
        NSData *modelsArrayData = [userDefaultsLoveMenu objectForKey:kUserDefaultLoveMenuKey];
        NSArray *modelsArray = [NSKeyedUnarchiver unarchiveObjectWithData:modelsArrayData];
        NSLog(@"modelsArray:%@",modelsArray);
        _iconModelsArray = [modelsArray mutableCopy];
    }
    else {
        [self getDisplayIcon:_favoriteMainMenu];
        HCFavoriteIconModel *addModel = [[HCFavoriteIconModel alloc]init];
        addModel.name = @"添加";
        addModel.image = @"tj";
        addModel.imageSeleted = @"tj";
        addModel.type = kViewcontroller;
        addModel.nodeIndex = @"-1";
        addModel.display = YES;
        addModel.isReadOnly = YES;
        addModel.targetController = @"";
        
        [_iconModelsArray addObject:addModel];
        
        NSData *iconModelsArrayData = [NSKeyedArchiver archivedDataWithRootObject:_iconModelsArray];
        [userDefaultsLoveMenu setObject:iconModelsArrayData forKey:kUserDefaultLoveMenuKey];
        [userDefaultsLoveMenu synchronize];
    }
    
    NSLog(@"displayMenu 显示数据：%@",_iconModelsArray);
    if ([self.view viewWithTag:90]) {
        [_springBoard removeFromSuperview];
    }
    
    //根据数据显示菜单
    CGRect sbRect = CGRectMake(0,  64, kScreenSize.width, [self getOnePageRomByDevice]*(ICONIMG_HEIGHT+0.5)+40);
    _springBoard = [[HCSpringBoardView alloc]initWithFrame:sbRect modes:_iconModelsArray];
    
    _springBoard.springBoardDelegate = self;
    _springBoard.tag = SpringBoardTag;
    [self.view addSubview:_springBoard];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenSize.height - 100, kScreenSize.width, 100)];
    bottomView.backgroundColor  = [UIColor clearColor];
    [self.view addSubview:bottomView];
    
    CGFloat width  = (kScreenSize.width - 100)/ 4;
    
    UIButton *pButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [pButton1 setImage:[UIImage imageNamed:@"随手拍"] forState:UIControlStateNormal];
    pButton1.frame = CGRectMake(20, (100-(width))/2, width, width);
    [bottomView addSubview:pButton1];
    
    UIButton *pButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [pButton2 setImage:[UIImage imageNamed:@"交警服务"] forState:UIControlStateNormal];
    pButton2.frame = CGRectMake(40+width, (100-(width))/2, width, width);
    [bottomView addSubview:pButton2];
    
    UIButton *pButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [pButton3 setImage:[UIImage imageNamed:@"农副商品"] forState:UIControlStateNormal];
    pButton3.frame = CGRectMake(60+width*2, (100-(width))/2, width, width);
    [bottomView addSubview:pButton3];
    
    UIButton *pButton4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [pButton4 setImage:[UIImage imageNamed:@"公园景区"] forState:UIControlStateNormal];
    pButton4.frame = CGRectMake(80+width *3,(100-(width))/2, width, width);
    [bottomView addSubview:pButton4];
    
}

#pragma mark - BankListDelegate
//显示在列表页勾选图标
- (void)addIconDone:(HCBankListViewController *)bankListViewController {
    CGRect sbRect = CGRectMake(0, 64, kScreenSize.width, [self getOnePageRomByDevice]*(ICONIMG_HEIGHT+0.5)+40);
    
    [_springBoard removeFromSuperview];
    _springBoard = [[HCSpringBoardView alloc]initWithFrame:sbRect modes:_iconModelsArray];
    _springBoard.springBoardDelegate = self;
    _springBoard.tag = SpringBoardTag;
    [self.view addSubview:_springBoard];
    
    //序列化
    [_springBoard archiverIconModelsArray];
    [_springBoard archiverLoveMenuMainModel];
}

//递归查找需要显示的图标
- (void)getDisplayIcon:(HCFavoriteIconModel *)favoroteModel
{
    if ([favoroteModel.type isEqualToString:kViewcontroller] || [favoroteModel.type isEqualToString:kWebLocal] || [favoroteModel.type isEqualToString:kWebNetwork]) {
        if (favoroteModel.display) {
            [_iconModelsArray addObject:favoroteModel];
        }
    }
    else if ([favoroteModel.type isEqualToString:kMenuList] || [favoroteModel.type isEqualToString:kMenuIcons]) {
        for (int i = 0; i < favoroteModel.itemList.count; i++) {
            [self getDisplayIcon:favoroteModel.itemList[i]];
        }
    }
}

- (NSInteger)getOnePageRomByDevice {
    NSInteger row = 5;
    if (IPHONE6Plus){
        row = 5;
    }
    return row;
}

@end
