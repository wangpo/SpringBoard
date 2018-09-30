//
//  HCPreviousPage.m
//  SpringBoard
//
//  Created by wangpo on 2018/9/20.
//  Copyright © 2018年 wangpo. All rights reserved.
//

#import "HCPreviousViewController.h"
#import "HCAssistant.h"
#import "HCWebViewController.h"
#import "AppDelegate.h"
#import "HCCardTableViewCell.h"

@interface HCPreviousViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView  *mTableView;
@property (strong, nonatomic) NSArray      *dataSource;

@end

@implementation HCPreviousViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    self.dataSource = @[@{@"title":@"头条新闻",
                          @"image":@"新闻",
                          @"url":@"http://baijiahao.baidu.com/s?id=1600415081824263444&wfr=spider&for=pc",
                          @"content":@"政务信息化市场的隐形独角兽 思源政通百亿估值逻辑",
                          @"accessory":@"评论345  1分钟前",
                          },
                    
                        @{@"title":@"燃气费",
                          @"image":@"燃气",
                          @"subTitle":@"￥500",
                          },
                    ];
    
    
    self.mTableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height) style:UITableViewStyleGrouped];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mTableView.tableFooterView = [UIView new];
    self.mTableView.tableHeaderView = [self tableHeaderView];
    self.mTableView.tableFooterView = [self tableFooterView];
    self.mTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mTableView];
    self.mTableView.rowHeight = 155;
    
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


- (UIView *)tableFooterView
{
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 60)];
    tableFooterView.backgroundColor = [UIColor clearColor];
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake((kScreenSize.width-40)/2, 10, 40, 40);
    editBtn.layer.cornerRadius = 20;
    editBtn.layer.masksToBounds = YES;
    [editBtn setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:0.5]];
    [editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    editBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [tableFooterView addSubview:editBtn];
    return tableFooterView;
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
    
    cell.subtitleLabel.text = [dict objectForKey:@"subTitle"];
    cell.accessoryLabel.text = [dict objectForKey:@"accessory"];
    
    if ([dict objectForKey:@"content"]) {
        cell.contentLabel.text =  [dict objectForKey:@"content"];
        cell.btn1.hidden = YES;
        cell.btn2.hidden = YES;
    }else{
        cell.btn1.hidden = NO;
        cell.btn2.hidden = NO;
    }
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
