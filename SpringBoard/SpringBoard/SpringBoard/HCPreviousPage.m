//
//  HCPreviousPage.m
//  SpringBoard
//
//  Created by wangpo on 2018/9/20.
//  Copyright © 2018年 wangpo. All rights reserved.
//

#import "HCPreviousPage.h"
#import "HCAssistant.h"
#import "HCWebViewController.h"
#import "AppDelegate.h"
@interface HCPreviousPage ()
{
    NSArray *_dataSource;
}
@end
@implementation HCPreviousPage

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _dataSource = @[
                        @[
                            @{@"title":@"公积金",@"image":@"医保",@"url":@"http://old.bjgjj.gov.cn"},
                            @{@"title":@"社保",@"image":@"社保",@"url":@"http://m.bjrbj.gov.cn"},
                         ],
                        @[
                            @{@"title":@"水费",@"image":@"水费",@"url":@"http://www.baidu.com"},
                            @{@"title":@"电费",@"image":@"12345",@"url":@"http://www.baidu.com"},
                            @{@"title":@"燃气费",@"image":@"燃气",@"url":@"http://www.baidu.com"},
                         ]
                       ];
     
         self.backgroundColor = [UIColor colorWithPatternImage:[[UIImage imageNamed:@"bg"] stretchableImageWithLeftCapWidth:320 topCapHeight:568]];
        self.mTableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height) style:UITableViewStyleGrouped];
        self.mTableView.delegate = self;
        self.mTableView.dataSource = self;
        self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.mTableView.tableFooterView = [UIView new];
        self.mTableView.tableHeaderView = [self tableHeaderView];
        self.mTableView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.mTableView];
        self.mTableView.rowHeight = 44;
    }
    return self;
}

- (UIView *)tableHeaderView
{
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 150)];
    tableHeaderView.backgroundColor = [UIColor clearColor];
    
    
    UIImageView *qrCodeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qrcode"]];
    qrCodeImageView.frame = CGRectMake((kScreenSize.width-100)/2, 10, 100, 100);
    [tableHeaderView addSubview:qrCodeImageView];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake((kScreenSize.width-100)/2, 115, 100, 30);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15.0f];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"一码通行";
    [tableHeaderView addSubview:titleLabel];
    
    
    return tableHeaderView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionArray = _dataSource[section];
    return sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    }
    
    

    
    NSDictionary *dict = _dataSource[indexPath.section][indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"title"];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.imageView.image = [UIImage imageNamed:[dict objectForKey:@"image"]];
    //2、调整大小
    CGSize itemSize = CGSizeMake(35, 35);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = _dataSource[indexPath.section][indexPath.row];
    HCWebViewController *webVC = [[HCWebViewController alloc] init];
    webVC.title = [dict objectForKey:@"title"];
    webVC.url = [dict objectForKey:@"url"];
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [del.launcherController presentViewController:webVC animated:YES completion:nil];
    
        
}



@end
