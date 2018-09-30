//
//  HCLastViewController.m
//  SpringBoard
//
//  Created by wangpo on 2018/9/27.
//  Copyright © 2018年 wangpo. All rights reserved.
//

#import "HCLastViewController.h"
#import "HCInstalledListViewController.h"
#import "AppDelegate.h"
#import "HCWebViewController.h"

@interface HCLastViewController ()<HCInstalledListViewControllerDelegate,HCWebViewControllerDelegate>
@property(nonatomic, strong) NSMutableArray *mainMenuList;
@property(nonatomic, strong) HCFavoriteIconModel *dataModel;
@property(nonatomic, strong) HCWebViewController *webVC;
@property(nonatomic, strong) UIButton *addButton;

@end

@implementation HCLastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor = [UIColor clearColor];
    
    self.mainMenuList = [[NSMutableArray alloc] init];
    __weak typeof(self) weakSelf = self;
    [APP.launcherController.midVC.favoriteMainMenu.itemList enumerateObjectsUsingBlock:^(HCFavoriteIconModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.display) {
            [weakSelf.mainMenuList addObject:obj];
        }
        if (obj.isAddToPage) {
            self.dataModel = obj;
        }
    }];
    
    if (self.dataModel) {
        [self addSubViewOfWeb];
    }else {
        [self addSubViewOfAddBtn];
    }
}

- (void)closeWebView:(HCWebViewController *)webVC
{
    [self.webVC.view removeFromSuperview];
    [self.webVC removeFromParentViewController];
    self.webVC = nil;
    
    self.dataModel.isAddToPage = NO;
    [self addSubViewOfAddBtn];
    
    [self archiverLoveMenuMainModel];
}


- (void)addAppToPageDone:(HCInstalledListViewController *)vc
{
    if (vc.addToPageModel) {
        [self.addButton removeFromSuperview];
        self.addButton = nil;
        self.dataModel = vc.addToPageModel;
        [self addSubViewOfWeb];
        [self archiverLoveMenuMainModel];
        
    }
}

- (void)addSubViewOfAddBtn
{
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    _addButton.frame = CGRectMake((kScreenSize.width-100)/2, (kScreenSize.height-100)/2, 100, 100);
    [self.view addSubview:_addButton];
}

//序列化总菜单
- (void)archiverLoveMenuMainModel{
    NSDictionary *dict = [[APP.launcherController.midVC.favoriteMainMenu modelToJSONObject] mutableCopy];
    [dict writeToFile:DOCUMENT_FOLDER(kMenuFileName) atomically:YES];
}

- (void)addSubViewOfWeb
{
    self.webVC = [[HCWebViewController alloc] init];
    self.webVC.delegate = self;
    self.webVC.title = self.dataModel.name;

    [self.view addSubview:self.webVC.view];
    [self addChildViewController:self.webVC];
}


- (void)addBtnAction:(UIButton *)sender
{
    HCInstalledListViewController *menuListViewController = [[HCInstalledListViewController alloc] init];
    menuListViewController.delegate = self;
    menuListViewController.mainMenuList = self.mainMenuList;
    [APP.launcherController presentViewController:[[UINavigationController alloc] initWithRootViewController:menuListViewController] animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
