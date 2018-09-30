//

//  HCSpringBoard
//
//  Created by 刘海川 on 16/3/7.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCInstalledListViewController.h"

@implementation HCInstalledListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加应用";
    self.tableView.rowHeight = 60;
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 40, 40);
    [rightButton setTitle:@"关闭"  forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [rightButton setTitleColor:[UIColor colorWithRed:0.02f green:0.45f blue:0.88f alpha:1.00f] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(doneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;
}

-(void)doneButtonAction:(UIButton*)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(addAppToPageDone:)]) {
        [_delegate addAppToPageDone:self];
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
    NSString *cellIdentifier = [NSString stringWithFormat:@"cellIdentifier"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    HCFavoriteIconModel *loveModel = [_mainMenuList objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:loveModel.image];
    
    CGSize itemSize = CGSizeMake(40, 40);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",loveModel.name];
    
    if (cell.accessoryView) {
        UIButton *installBtn = (UIButton *)cell.accessoryView;
        installBtn.tag = indexPath.row;
        if (loveModel.isAddToPage) {
            [installBtn setTitle:@"已添加" forState:UIControlStateNormal];
        }else{
            [installBtn setTitle:@"添加" forState:UIControlStateNormal];
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
        if (loveModel.isAddToPage) {
            [installBtn setTitle:@"已添加" forState:UIControlStateNormal];
        }else{
            [installBtn setTitle:@"添加" forState:UIControlStateNormal];
        }
        cell.accessoryView = installBtn;
        installBtn.tag = indexPath.row;
    }
    return cell;
    
}


- (void)accessoryBtnAction:(UIButton *)installBtn
{
    HCFavoriteIconModel *loveModel = [_mainMenuList objectAtIndex:installBtn.tag];
    [_mainMenuList enumerateObjectsUsingBlock:^(HCFavoriteIconModel *obj, NSUInteger idx, BOOL * _Nonnull stop){
        if (loveModel == obj) {
            obj.isAddToPage = !obj.isAddToPage;
            
            if (obj.isAddToPage) {
                self.addToPageModel = obj;
            }else{
                self.addToPageModel = nil;
            }
        }else{
            obj.isAddToPage = NO;
        }
        
    }];
    [self.tableView reloadData];
}


@end
