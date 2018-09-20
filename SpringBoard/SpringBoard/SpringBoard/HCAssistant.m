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
    
    
    NSArray *iconItem = @[@"24小时图书馆",@"12345",@"不动产状况",@"车主服务",@"城市停车",@"电动车目录",@"电梯查询",@"电影娱乐",@"公积金",@"公园景区",@"惠民资金",@"机动车维修点",@"健康证查询",@"交警服务",@"交通出行",@"教育缴费",@"景点门票",@"看病就医",@"民生商品",@"农副商品",@"培训机构查询",@"平安管家",@"燃气",@"人事人才档案",@"三坊七巷",@"社保",@"社区服务",@"社区网点",@"失物招领",@"实时公交",@"市图书馆",@"水费",@"随手拍",@"台风路径",@"停车诱导",@"网上办事大厅",@"信用福州",@"信用商家",@"信用支付",@"信用租赁",@"药店支付",@"医保",@"医保药品目录",@"医疗网点查询",@"易办税",@"意见反馈",@"政民互动",@"职业健康查询"];
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    [iconItem enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              obj,kNodeName,
                              obj, kImage,
                              obj, kImageSeleted,
                              obj,kMenuListImage,
                              [NSNumber numberWithUnsignedInt:idx], kSortNum,
                              [NSString stringWithFormat:@"%ld",idx],kNodeIndex,
                              kWebNetwork, kNodeType,
                              @"PreferentialMerchant",kActionId,
                              [[NSNumber alloc]initWithBool:YES],kNeedLogin,
                              [[NSNumber alloc]initWithBool:YES],kIsDisplay,
                              [[NSNumber alloc]initWithBool:NO],kIsReadOnly,
                              @"CSIITabBarViewController>0|CSIIFirstViewController>1",kNavigationObject,
                              @"WebViewController",kSendController,
                              nil];
        [items addObject:dict];
    }];
    
    NSDictionary *root = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"添加我的最爱",kNodeName,
                          @"", kImage,
                          kMenuList, kNodeType,
                          [NSString string], kTarget,
                          items, kItems,
                          [[NSNumber alloc]initWithInt:40], @"sortMaxNum",
                          nil];
    
    NSString *path = DOCUMENT_FOLDER(kMenuFileName);
    [root writeToFile:path atomically:YES];
}

@end
