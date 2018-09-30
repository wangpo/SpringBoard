//
//  HCAppIntroduceViewController.h
//  SpringBoard
//
//  Created by wangpo on 2018/9/28.
//  Copyright © 2018年 wangpo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCFavoriteIconModel.h"


@interface HCAppIntroduceViewController : UIViewController

@property (nonatomic, strong) HCFavoriteIconModel *loveModel;
@property (nonatomic, weak) id parentVC;
@end
