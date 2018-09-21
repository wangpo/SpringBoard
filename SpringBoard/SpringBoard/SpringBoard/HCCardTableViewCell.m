//
//  HCCardTableViewCell.m
//  SpringBoard
//
//  Created by wangpo on 2018/9/21.
//  Copyright © 2018年 wangpo. All rights reserved.
//

#import "HCCardTableViewCell.h"
#import "HCAssistant.h"
@interface HCCardTableViewCell()

@end

@implementation HCCardTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self layoutSubView];
    }
    return self;
}

- (void)layoutSubView
{
    _backgroundImageView = [[UIImageView alloc] init];
    _backgroundImageView.frame = CGRectMake(20, 0, ScreenWidth-40, 80);
    _backgroundImageView.layer.cornerRadius = 8;
    _backgroundImageView.layer.masksToBounds = YES;
    _backgroundImageView.userInteractionEnabled = YES;
    _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_backgroundImageView];
    
    _logoImageView = [[UIImageView alloc] init];
    _logoImageView.frame = CGRectMake(20, 20, 40, 40);
    [_backgroundImageView addSubview:_logoImageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_logoImageView.frame)+10, 30, 100, 20);
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:18];
    [_backgroundImageView addSubview:_titleLabel];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
