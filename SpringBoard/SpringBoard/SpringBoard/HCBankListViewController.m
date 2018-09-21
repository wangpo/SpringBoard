//
//  HCBankListViewController.m
//  HCSpringBoard
//
//  Created by 刘海川 on 16/3/7.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCBankListViewController.h"
#import "HCFavoriteIconModel.h"
#import "HCFavoriteFolderModel.h"

@interface HCBankListViewController ()
{
    NSArray *_mainMenuList;
}
@end

@implementation HCBankListViewController

- (instancetype)initWithMainMenu:(NSArray *)mainMenu {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        _mainMenuList = mainMenu;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"菜单列表";
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 40, 40);
    [rightButton setTitle:@"完成"  forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [rightButton setTitleColor:[UIColor colorWithRed:0.02f green:0.45f blue:0.88f alpha:1.00f] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(doneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)doneButtonAction:(UIButton*)sender{
    
    if (_bankListDelegate && [_bankListDelegate respondsToSelector:@selector(addIconDone:)]) {
        [_bankListDelegate addIconDone:self];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_mainMenuList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"%ld %ld",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        HCFavoriteIconModel *loveModel = [_mainMenuList objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:loveModel.menuListImage];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",loveModel.name];
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        
        if ([loveModel.type isEqualToString:kViewcontroller]||
            [loveModel.type isEqualToString:kWebLocal]||
            [loveModel.type isEqualToString:kWebNetwork]) {
            if (loveModel.display) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *tableViewcell=[tableView cellForRowAtIndexPath:indexPath];
    [tableViewcell setSelected:NO animated:YES];
    
    HCFavoriteIconModel *loveModel = [_mainMenuList objectAtIndex:indexPath.row];
    if ([loveModel.type isEqualToString:kMenuList]||
        [loveModel.type isEqualToString:kMenuIcons]) {
        
       
        
    }else if ([loveModel.type isEqualToString:kViewcontroller] || [loveModel.type isEqualToString:kWebNetwork]){
        if (!loveModel.display) {
            [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
            
            loveModel.display = YES;
            [self.allMenuModels insertObject:loveModel atIndex:self.allMenuModels.count-1];
            
        }else{
            if (!loveModel.isReadOnly) {
                [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
                
                for (int i = 0; i < self.allMenuModels.count; i++) {
                    HCFavoriteIconModel *iconModel = self.allMenuModels[i];
                    if ([iconModel.nodeIndex isEqualToString:loveModel.nodeIndex]) {
                        [self.allMenuModels removeObject:iconModel];
                    }
                }
                
                for (int i = 0; i < self.allMenuModels.count; i++) {
                    id model = self.allMenuModels[i];
                    if ([model isKindOfClass:[HCFavoriteIconModel class]]) {
                        HCFavoriteIconModel *iconModel = model;
                        if ([iconModel.nodeIndex isEqualToString:loveModel.nodeIndex]) {
                            NSInteger index = [self.allMenuModels indexOfObject:iconModel];
                            [self.allMenuModels removeObjectAtIndex:index];
                        }
                    }
                    else if ([model isKindOfClass:[HCFavoriteFolderModel class]]) {
                        HCFavoriteFolderModel *folderModel = model;
                        for (int j = 0; j < folderModel.iconModelsFolderArray.count; j++) {
                            HCFavoriteIconModel *iconModel = folderModel.iconModelsFolderArray[j];
                            if ([iconModel.nodeIndex isEqualToString:loveModel.nodeIndex]) {
                                NSInteger index = [folderModel.iconModelsFolderArray indexOfObject:iconModel];
                                [folderModel.iconModelsFolderArray removeObjectAtIndex:index];
                                [folderModel.iconViewsFolderArray removeObjectAtIndex:index];
                                if (folderModel.iconModelsFolderArray.count == 0) {
                                    [self.allMenuModels removeObject:folderModel];
                                }
                            }
                        }
                    }
                }
                
                loveModel.display = NO;
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 100.0f;
    }
    return 0.1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section ==0){
        UIView *footViewOfSection = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 160)];
        
        //"温馨提示"标题
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(8,10, ScreenWidth-16, 20)];
        label.text = @"温馨提示:";
        label.font = [UIFont systemFontOfSize:14];
        [footViewOfSection addSubview:label];
        
        //"温馨提示"内容
        UILabel *heartAlert = [[UILabel alloc]initWithFrame:CGRectMake(8,30, ScreenWidth-16, 40)];
        heartAlert.font = [UIFont systemFontOfSize:14];
        heartAlert.text = @"您可以通过勾选常用功能来定制快捷菜单，方便今后使用。";
        heartAlert.numberOfLines = 0;
        [footViewOfSection addSubview:heartAlert];
        return footViewOfSection;
    }
    return nil;
}

@end
