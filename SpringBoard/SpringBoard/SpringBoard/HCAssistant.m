//
//  HCAssistant.m
//  HCSpringBoard
//
//  Created by 刘海川 on 16/3/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCAssistant.h"

@implementation HCAssistant

+ (void)initMainMenu;
{
    NSArray *iconItems = @[@"24小时图书馆",@"不动产状况",@"车主服务",@"城市停车",@"电动车目录",@"电梯查询",@"公积金",@"公园景区",@"惠民资金",@"机动车维修点",@"交警服务",@"交通出行",@"景点门票",@"看病就医",@"民生商品",@"培训机构查询",@"平安管家",@"燃气",@"人事人才档案",@"社区服务",@"社区网点",@"实时公交",@"市图书馆",@"台风路径",@"停车诱导",@"网上办事大厅",@"信用福州",@"信用商家",@"信用支付",@"医疗网点查询",@"易办税",@"政民互动",@"职业健康查询",@"中考查询",@"周边服务"];
    
    
    NSArray *appLists = @[@{@"name":@"城市管理",@"icon":@"城市管理",@"desc":@"城市一张网管理服务系统",@"url":@"http://storemarket.zhengtoon.com/app/index.html?phoneflag=1#/queryDetail?id=34"},
                          @{@"name":@"安全监控",@"icon":@"安全监控",@"desc":@"公共安全视频监控联网应用平台",@"url":@"http://storemarket.zhengtoon.com/app/index.html?phoneflag=1#/queryDetail?id=35"},
                          @{@"name":@"治安治理",@"icon":@"治安治理",@"desc":@"社会治安综合治理信息平台",@"url":@"http://storemarket.zhengtoon.com/app/index.html?phoneflag=1#/queryDetail?id=36"},
                          @{@"name":@"智慧交通",@"icon":@"智慧交通",@"desc":@"城市智慧交通管理系统",@"url":@"http://storemarket.zhengtoon.com/app/index.html?phoneflag=1#/queryDetail?id=37"},
                          @{@"name":@"政务服务",@"icon":@"政务服务",@"desc":@"互联网+政务服务平台",@"url":@"http://storemarket.zhengtoon.com/app/index.html?phoneflag=1#/queryDetail?id=38"},
                          @{@"name":@"智慧政务",@"icon":@"智慧政务",@"desc":@"智慧政务网站群系统",@"url":@"http://storemarket.zhengtoon.com/app/index.html?phoneflag=1#/queryDetail?id=39"},
                          @{@"name":@"社区管理",@"icon":@"社区管理",@"desc":@"社区管理平台",@"url":@"http://storemarket.zhengtoon.com/app/index.html?phoneflag=1#/queryDetail?id=40"},
                          @{@"name":@"养老平台",@"icon":@"养老平台",@"desc":@"养老平台",@"url":@"http://storemarket.zhengtoon.com/app/index.html?phoneflag=1#/queryDetail?id=41"},
                          @{@"name":@"水利治理",@"icon":@"水利治理",@"desc":@"水利治理管理平台",@"url":@"http://storemarket.zhengtoon.com/app/index.html?phoneflag=1#/queryDetail?id=42"},
                          @{@"name":@"数字报刊",@"icon":@"数字报刊",@"desc":@"数字报刊",@"url":@"http://storemarket.zhengtoon.com/app/index.html?phoneflag=1#/queryDetail?id=43"},
                          @{@"name":@"融媒小厨",@"icon":@"融媒小厨",@"desc":@"融媒体中央厨房平台",@"url":@"http://storemarket.zhengtoon.com/app/index.html?phoneflag=1#/categoryList"},
                          @{@"name":@"智慧旅游",@"icon":@"智慧旅游",@"desc":@"智慧旅游平台",@"url":@"http://storemarket.zhengtoon.com/app/index.html?phoneflag=1#/queryDetail?id=45"},
                          @{@"name":@"智慧教育",@"icon":@"智慧教育",@"desc":@"智慧教育",@"url":@"http://storemarket.zhengtoon.com/app/index.html?phoneflag=1#/queryDetail?id=46"},
                          @{@"name":@"智慧文博",@"icon":@"智慧文博",@"desc":@"智慧文博",@"url":@"http://storemarket.zhengtoon.com/app/index.html?phoneflag=1#/queryDetail?id=47"},
                          @{@"name":@"智慧医疗",@"icon":@"智慧医疗",@"desc":@"智慧医疗系统",@"url":@"http://storemarket.zhengtoon.com/app/index.html?phoneflag=1#/queryDetail?id=48"},
                          
                          ];
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    
    [appLists enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [obj objectForKey:@"name"],kNodeName,
                              [obj objectForKey:@"icon"],kImage,
                              [obj objectForKey:@"desc"],kNodeDesc,
                              [obj objectForKey:@"url"],kNodeUrl,
                              [NSString stringWithFormat:@"%ld",idx],kNodeIndex,
                              kViewcontroller, kNodeType,
                              [[NSNumber alloc]initWithBool:YES],kNeedLogin,
                              [[NSNumber alloc]initWithBool:NO],kIsDisplay,//默认不安装
                              [[NSNumber alloc]initWithBool:NO],kIsReadOnly,
                              nil];
        [items addObject:dict];
    }];
    
    
    [iconItems enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              obj,kNodeName,
                              obj,kImage,
                              obj,kNodeDesc,
                              [NSString stringWithFormat:@"%ld",idx],kNodeIndex,
                              kViewcontroller, kNodeType,
                              [[NSNumber alloc]initWithBool:YES],kNeedLogin,
                              [[NSNumber alloc]initWithBool:YES],kIsDisplay,//默认安装
                              [[NSNumber alloc]initWithBool:NO],kIsReadOnly,
                              nil];
        [items addObject:dict];
    }];
    
    
    NSDictionary *root = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"全部",kNodeName,
                          @"", kImage,
                          kMenuList, kNodeType,
                          items, kItems,
                          nil];
    
    NSString *path = DOCUMENT_FOLDER(kMenuFileName);
    [root writeToFile:path atomically:YES];
}

@end
