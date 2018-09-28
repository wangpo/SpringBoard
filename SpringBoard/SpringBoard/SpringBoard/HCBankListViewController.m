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
#import "HCPrivacyViewController.h"

@interface HCBankListViewController ()
@property(nonatomic, strong) NSMutableArray *normalMenuList;
@property(nonatomic, strong) NSMutableArray *mainMenuList;
@end

@implementation HCBankListViewController

- (instancetype)initWithMainMenu:(NSArray *)mainMenu {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.mainMenuList = [[NSMutableArray alloc] init];
        __weak typeof(self) weakSelf = self;
        [mainMenu enumerateObjectsUsingBlock:^(HCFavoriteIconModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.display) {
                [weakSelf.mainMenuList addObject:obj];
            }
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isAppList) {
        self.title = @"添加应用";
        
        self.normalMenuList = @[];
        
        
    }else{
        self.title = @"设置";
        self.normalMenuList = @[@{@"image":@"tab2",@"title":@"账户"},
                                @{@"image":@"指纹",@"title":@"指纹"},
                                @{@"image":@"安全",@"title":@"安全"},
                                @{@"image":@"关于",@"title":@"关于"}];
    }
    
    
   
    // Do any additional setup after loading the view.
    
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [_normalMenuList count];
    }else{
         return [_mainMenuList count];
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"%ld %ld",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section == 0) {
        NSDictionary *dict = [self.normalMenuList objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[dict objectForKey:@"image"]];
        
        CGSize itemSize = CGSizeMake(40, 40);
        UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [cell.imageView.image drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        cell.textLabel.text = [dict objectForKey:@"title"];
        
        return cell;
    }else {
        HCFavoriteIconModel *loveModel = [_mainMenuList objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:loveModel.menuListImage];
        
        CGSize itemSize = CGSizeMake(40, 40);
        UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [cell.imageView.image drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@",loveModel.name];
        
        if (self.isAppList) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
            label.textAlignment = NSTextAlignmentRight;
            label.text = @"添加";
            cell.accessoryView = label;
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
    }else{
        if (self.isAppList) {
            
        }else{
            HCFavoriteIconModel *loveModel = [_mainMenuList objectAtIndex:indexPath.row];
            HCPrivacyViewController *privacyVC = [[HCPrivacyViewController alloc] init];
            privacyVC.title = loveModel.name;
            [self.navigationController pushViewController:privacyVC animated:YES];
        }
       
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0f;
}



@end
