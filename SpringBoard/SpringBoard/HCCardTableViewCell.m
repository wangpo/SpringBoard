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
@property (nonatomic, strong) UIImageView *backgroundImageView;
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
    _backgroundImageView.frame = CGRectMake(10, 0, ScreenWidth-20, 150);
    _backgroundImageView.layer.cornerRadius = 8;
    _backgroundImageView.layer.masksToBounds = YES;
    _backgroundImageView.userInteractionEnabled = YES;
    _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    _backgroundImageView.backgroundColor =  [UIColor colorWithWhite:0.9 alpha:0.5];
    [self.contentView addSubview:_backgroundImageView];

    UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _backgroundImageView.bounds.size.width, 40)];
    topBgView.backgroundColor =  [UIColor colorWithWhite:0.8 alpha:0.5];
    [_backgroundImageView addSubview:topBgView];
    
    //高斯模糊
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = topBgView.bounds;
    [topBgView addSubview:effectView];
    
    _logoImageView = [[UIImageView alloc] init];
    _logoImageView.frame = CGRectMake(10, 10, 20, 20);
    [topBgView addSubview:_logoImageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_logoImageView.frame)+10, 10, 100, 20);
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    [topBgView addSubview:_titleLabel];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.frame = CGRectMake(10, 10, _backgroundImageView.bounds.size.width - 20, _backgroundImageView.bounds.size.height -  20);
    _contentLabel.numberOfLines = 3;
    _contentLabel.backgroundColor = [UIColor clearColor];
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.font = [UIFont boldSystemFontOfSize:16];
    [_backgroundImageView addSubview:_contentLabel];
    
    _accessoryLabel = [[UILabel alloc] init];
    _accessoryLabel.frame = CGRectMake(10, 10, _backgroundImageView.bounds.size.width - 20, _backgroundImageView.bounds.size.height -  20);
    _accessoryLabel.backgroundColor = [UIColor clearColor];
    _accessoryLabel.textColor = [UIColor blackColor];
    _accessoryLabel.font = [UIFont boldSystemFontOfSize:16];
    [_backgroundImageView addSubview:_accessoryLabel];
    
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
