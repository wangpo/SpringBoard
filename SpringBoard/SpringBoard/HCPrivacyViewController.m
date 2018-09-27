//
//  HCPrivacyViewController.m
//  SpringBoard
//
//  Created by wangpo on 2018/9/26.
//  Copyright © 2018年 wangpo. All rights reserved.
//

#import "HCPrivacyViewController.h"

@interface HCPrivacyViewController ()
{
    NSArray *_dataSource;
}
@end

@implementation HCPrivacyViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        _dataSource = @[ @{@"title":@"位置",@"image":@"位置"},
                         @{@"title":@"通讯录",@"image":@"通讯录"},
                         @{@"title":@"照片",@"image":@"照片"},
                         @{@"title":@"麦克风",@"image":@"麦克风"},
                         @{@"title":@"相机",@"image":@"相机"},
                         @{@"title":@"无线数据",@"image":@"无线数据"},
                       ];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.rowHeight = 44.0f;
}


#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"%ld %ld",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dict = _dataSource[indexPath.row];
    NSString *text = dict[@"title"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",text];
    cell.imageView.image = [UIImage imageNamed:dict[@"image"]];
    
    if ([text isEqualToString:@"位置"]) {
        cell.detailTextLabel.text = @"使用期间";
    } else if ([text isEqualToString:@"通讯录"]){
        UISwitch *accessoryView = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        accessoryView.on = YES;
        cell.accessoryView = accessoryView;
    } else if ([text isEqualToString:@"照片"]){
        cell.detailTextLabel.text = @"读取和写入";
        
    } else if ([text isEqualToString:@"麦克风"]){
        UISwitch *accessoryView = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        accessoryView.on = NO;
        cell.accessoryView = accessoryView;
        
    }else if ([text isEqualToString:@"相机"]){
        UISwitch *accessoryView = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        accessoryView.on = NO;
        cell.accessoryView = accessoryView;
    }else if ([text isEqualToString:@"无线数据"]){
        cell.detailTextLabel.text = @"WLAN与蜂窝移动网";
    }
    
    
    CGSize itemSize = CGSizeMake(32, 32);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   UITableViewHeaderFooterView *sectionHeader =  [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"sectionHeaderID"];
    if (!sectionHeader) {
        sectionHeader = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"sectionHeaderID"];
    }
    sectionHeader.textLabel.text = [NSString stringWithFormat:@"允许“%@”访问",self.title];
    sectionHeader.textLabel.font = [UIFont systemFontOfSize:14.0f];
    return sectionHeader;
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
