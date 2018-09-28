//
//  HCCardTableViewCell.h
//  SpringBoard
//
//  Created by wangpo on 2018/9/21.
//  Copyright © 2018年 wangpo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCCardTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *accessoryLabel;
@end
