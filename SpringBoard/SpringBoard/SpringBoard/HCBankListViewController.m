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
    // Do any additional setup after loading the view.
    self.title = @"设置";
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
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    HCFavoriteIconModel *loveModel = [_mainMenuList objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:loveModel.menuListImage];
    
    CGSize itemSize = CGSizeMake(40, 40);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",loveModel.name];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HCFavoriteIconModel *loveModel = [_mainMenuList objectAtIndex:indexPath.row];
    HCPrivacyViewController *privacyVC = [[HCPrivacyViewController alloc] init];
    privacyVC.title = loveModel.name;
    [self.navigationController pushViewController:privacyVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0f;
}



@end
