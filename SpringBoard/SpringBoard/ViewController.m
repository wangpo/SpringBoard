//
//  ViewController.m
//  HCSpringBoard
//
//  Created by 刘海川 on 16/3/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "ViewController.h"
#import "HCAssistant.h"

@interface ViewController () {
    
    NSMutableArray *_iconModelsArray;
    
    HCSpringBoardView *_springBoard;
    
}


@property (nonatomic, strong)UIImageView *cardView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    _navBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, (IPhoneX ? 88 : 64))];
    _navBarView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
    [self.view addSubview:_navBarView];
    //高斯模糊
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = _navBarView.bounds;
    [_navBarView addSubview:effectView];
    
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (IPhoneX ? 44 : 20), kScreenSize.width, 40)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text =  @"公民";
    [_navBarView addSubview:_titleLabel];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor whiteColor];
    line.frame = CGRectMake(0, 0, 48, 3);
    line.center = CGPointMake(kScreenSize.width/2, CGRectGetMaxY(_titleLabel.frame));
    [_navBarView addSubview:line];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = _titleLabel.frame;
    [button addTarget:self action:@selector(showCard:) forControlEvents:UIControlEventTouchUpInside];
    [_navBarView addSubview:button];
    
    
    UIButton *appStoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    appStoreButton.frame = CGRectMake(kScreenSize.width - 50,  (IPhoneX ? 44 : 20), 40, 40);
    [appStoreButton setImage:[UIImage imageNamed:@"appStore"] forState:UIControlStateNormal];
    [appStoreButton addTarget:self action:@selector(showAppStore:) forControlEvents:UIControlEventTouchUpInside];
    [_navBarView addSubview:appStoreButton];
    
   
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[[UIImage imageNamed:@"bg"] stretchableImageWithLeftCapWidth:320 topCapHeight:568]];
    //获取序列化到本地的所有菜单
    NSDictionary *mainMenuDict = [[NSDictionary alloc]initWithContentsOfFile:DOCUMENT_FOLDER(kMenuFileName)];
    _favoriteMainMenu = [HCFavoriteIconModel modelWithDictionary:mainMenuDict];
    [self displayMenu];
    
}

- (UIImageView *)cardView
{
    if (!_cardView) {
        _cardView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"card"]];
    }
    return _cardView;
}

- (void)showAppStore:(UIButton *)sender
{
    HCBankListViewController *menuListViewController = [[HCBankListViewController alloc]initWithMainMenu:self.favoriteMainMenu.itemList];
    menuListViewController.allMenuModels = _springBoard.favoriteModelArray;
    menuListViewController.bankListDelegate = self;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:menuListViewController] animated:YES completion:nil];
}

- (void)showCard:(UIButton *)sender
{
    if (self.cardView.alpha == 0) {
        [UIView animateWithDuration:0.3 animations:^{
            self.cardView.alpha = 1;
            self.cardView.frame = CGRectMake(0,  (IPhoneX ? 88 : 64), kScreenSize.width, 150);
        }];
    }else if(self.cardView.alpha == 1){
        [UIView animateWithDuration:0.3 animations:^{
            self.cardView.alpha = 0;
            self.cardView.frame = CGRectMake(0,   (IPhoneX ? 88 : 64) -150, kScreenSize.width, 0);
        }];
    }
   
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
        _iconModelsArray = [modelsArray mutableCopy];
    }
    else {
        [self getDisplayIcon:_favoriteMainMenu];

        NSData *iconModelsArrayData = [NSKeyedArchiver archivedDataWithRootObject:_iconModelsArray];
        [userDefaultsLoveMenu setObject:iconModelsArrayData forKey:kUserDefaultLoveMenuKey];
        [userDefaultsLoveMenu synchronize];
    }
    
    if ([self.view viewWithTag:90]) {
        [_springBoard removeFromSuperview];
    }
    
    //根据数据显示菜单
    CGRect sbRect = CGRectMake(0,  (IPhoneX ? 88 : 64), kScreenSize.width, [self getOnePageRomByDevice]*(ICONIMG_HEIGHT+0.5)+40);
    _springBoard = [[HCSpringBoardView alloc]initWithFrame:sbRect modes:_iconModelsArray];
    _springBoard.springBoardDelegate = self;
    _springBoard.tag = SpringBoardTag;
    [self.view addSubview:_springBoard];
    
    self.cardView.frame =  CGRectMake(0,   (IPhoneX ? 88 : 64) -150, kScreenSize.width, 150);
    self.cardView.alpha = 0;
    [self.view addSubview:self.cardView];
    
    //底部Tabbar
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenSize.height - 90, kScreenSize.width, 90)];
    bottomView.backgroundColor  = [UIColor colorWithWhite:0.9 alpha:0.5];
    [self.view addSubview:bottomView];
    
    //高斯模糊
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = bottomView.bounds;
    [bottomView addSubview:effectView];

    CGFloat width  = (kScreenSize.width - 125)/ 4;
    for (int i = 1; i <= 4; i++) {
        UIButton *pButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [pButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab%@",@(i)]] forState:UIControlStateNormal];
        pButton.tag = i;
        pButton.frame = CGRectMake(25*i+width*(i-1), (90-(width))/2, width, width);
        [pButton addTarget:self action:@selector(bottomBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:pButton];
    }
}

- (void)bottomBtnClicked:(UIButton *)sender
{
    //底部按钮响应时间
}

#pragma mark - BankListDelegate
//显示在列表页勾选图标
- (void)addIconDone:(HCBankListViewController *)bankListViewController {
    CGRect sbRect = CGRectMake(0, (IPhoneX ? 88 : 64), kScreenSize.width, [self getOnePageRomByDevice]*(ICONIMG_HEIGHT+0.5)+40);
    
    [_springBoard removeFromSuperview];
    _springBoard = [[HCSpringBoardView alloc]initWithFrame:sbRect modes:_iconModelsArray];
    _springBoard.springBoardDelegate = self;
    _springBoard.tag = SpringBoardTag;
    [self.view addSubview:_springBoard];
    //序列化
    [_springBoard archiverIconModelsArray];
    [_springBoard archiverLoveMenuMainModel];
    
    [self.view bringSubviewToFront:self.cardView];
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
