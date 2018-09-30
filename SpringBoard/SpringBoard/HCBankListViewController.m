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
#import "HCAppIntroduceViewController.h"

@implementation HCBankListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"应用超市";
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 40, 40);
    [rightButton setImage:[UIImage imageNamed:@"app_close"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(doneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;
    self.tableView.rowHeight = 80;
}

-(void)doneButtonAction:(UIButton*)sender{
    
    if (_bankListDelegate && [_bankListDelegate respondsToSelector:@selector(addIconDone:)]) {
        [_bankListDelegate addIconDone:self];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_mainMenuList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"%@",@"cellIdentifier"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:17];
    }
    
    HCFavoriteIconModel *loveModel = [_mainMenuList objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",loveModel.name];
    cell.detailTextLabel.text = loveModel.desc;
  
    cell.imageView.image = [UIImage imageNamed:loveModel.image];
    CGSize itemSize = CGSizeMake(50, 50);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    if (cell.accessoryView) {
        UIButton *installBtn = (UIButton *)cell.accessoryView;
        installBtn.tag = indexPath.row;
        if (loveModel.display) {
            [installBtn setTitle:@"卸载" forState:UIControlStateNormal];
        }else{
            [installBtn setTitle:@"安装" forState:UIControlStateNormal];
        }
    }else{
        UIButton *installBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        installBtn.frame = CGRectMake(0, 0, 75, 30);
        installBtn.layer.cornerRadius = 15;
        installBtn.layer.masksToBounds = YES;
        installBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [installBtn setBackgroundColor:[UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0]];
        [installBtn setTitleColor:[UIColor colorWithRed:21.0/255.0 green:90.0/255.0 blue:198.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [installBtn addTarget:self action:@selector(accessoryBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        if (loveModel.display) {
            [installBtn setTitle:@"卸载" forState:UIControlStateNormal];
        }else{
            [installBtn setTitle:@"安装" forState:UIControlStateNormal];
        }
        cell.accessoryView = installBtn;
        installBtn.tag = indexPath.row;
    }
    
    
    return cell;
}

- (void)accessoryBtnAction:(UIButton *)installBtn
{
    HCFavoriteIconModel *loveModel = [_mainMenuList objectAtIndex:installBtn.tag];
    if (!loveModel.display) {
        [installBtn setTitle:@"卸载" forState:UIControlStateNormal];
        loveModel.display = YES;
        [self.allMenuModels addObject:loveModel];
        
    }else{
        if (!loveModel.isReadOnly) {
            [installBtn setTitle:@"安装" forState:UIControlStateNormal];
            
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCFavoriteIconModel *loveModel = [_mainMenuList objectAtIndex:indexPath.row];
    HCAppIntroduceViewController *webVC = [[HCAppIntroduceViewController alloc] init];
    webVC.loveModel = loveModel;
    webVC.parentVC = self;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)installAppRelayoutList:(HCFavoriteIconModel *)model
{
    NSUInteger index = [_mainMenuList indexOfObject:model];
    if (index < [_mainMenuList count]) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        if (cell.accessoryView) {
            UIButton *installBtn = (UIButton *)cell.accessoryView;
            [self accessoryBtnAction:installBtn];
        }
    }
}

- (UIButton *)accessoryViewTypeOfInstall
{
    UIButton *installBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    installBtn.frame = CGRectMake(0, 0, 75, 30);
    installBtn.layer.cornerRadius = 15;
    installBtn.layer.masksToBounds = YES;
    [installBtn setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:0.5]];
    [installBtn setTitle:@"安装" forState:UIControlStateNormal];
    return installBtn;
}


@end
