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
#import "HCCardTableViewCell.h"
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
        
        _dataSource = @[@{@"title":@"头条新闻",
                          @"image":@"新闻",
                          @"url":@"https://www.toutiao.com/a6604606535190446596/",
                          @"content":@"IOS 12太给力，导致iPhone 5S都重新开售，全新版只要1000元"},
                        @{@"title":@"公积金",
                          @"image":@"公积金",
                          @"url":@"http://old.bjgjj.gov.cn",
                          @"content":@"￥3500"},
                        @{@"title":@"社保",
                          @"image":@"社保",
                          @"url":@"http://m.bjrbj.gov.cn",
                          @"content":@"￥1500元"},
                        @{@"title":@"水费",
                          @"image":@"水费",
                          @"url":@"",
                          @"content":@"￥35元"},
                       ];
     
        self.backgroundColor = [UIColor clearColor];
        self.mTableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height) style:UITableViewStyleGrouped];
        self.mTableView.delegate = self;
        self.mTableView.dataSource = self;
        self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.mTableView.tableFooterView = [UIView new];
        self.mTableView.tableHeaderView = [self tableHeaderView];
        self.mTableView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.mTableView];
        self.mTableView.rowHeight = 155;
    }
    return self;
}

- (UIView *)tableHeaderView
{
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 260)];
    tableHeaderView.backgroundColor = [UIColor clearColor];
    
    
    UIImageView *qrCodeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qrcode"]];
    qrCodeImageView.frame = CGRectMake((kScreenSize.width-150)/2, 60, 150, 150);
    [tableHeaderView addSubview:qrCodeImageView];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(CGRectGetMinX(qrCodeImageView.frame), CGRectGetMaxY(qrCodeImageView.frame)+10, 150, 20);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15.0f];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"一码通行";
    [tableHeaderView addSubview:titleLabel];
    
    
    return tableHeaderView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[HCCardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.backgroundColor = [UIColor clearColor];
        
    }
    
    NSDictionary *dict = _dataSource[indexPath.row];
    cell.titleLabel.text = [dict objectForKey:@"title"];
    cell.logoImageView.image = [UIImage imageNamed:[dict objectForKey:@"image"]];
    cell.contentLabel.text =  [dict objectForKey:@"content"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //卡片跳转
    NSDictionary *dict = _dataSource[indexPath.row];
    HCWebViewController *webVC = [[HCWebViewController alloc] init];
    webVC.title = [dict objectForKey:@"title"];
    webVC.url = [dict objectForKey:@"url"];
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [del.launcherController presentViewController:webVC animated:YES completion:nil];
}
@end
