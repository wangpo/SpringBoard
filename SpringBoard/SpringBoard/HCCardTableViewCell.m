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
    
    _subtitleLabel = [[UILabel alloc] init];
    _subtitleLabel.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame)+10, 10, _backgroundImageView.bounds.size.width - (CGRectGetMaxX(_titleLabel.frame)+10) - 10, 20);
    _subtitleLabel.backgroundColor = [UIColor clearColor];
    _subtitleLabel.textAlignment = NSTextAlignmentRight;
    _subtitleLabel.textColor = [UIColor blackColor];
    _subtitleLabel.font = [UIFont systemFontOfSize:14];
    [topBgView addSubview:_subtitleLabel];
    
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.frame = CGRectMake(10, 50, _backgroundImageView.bounds.size.width - 20, 60);
    _contentLabel.numberOfLines = 2;
    _contentLabel.backgroundColor = [UIColor clearColor];
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.font = [UIFont boldSystemFontOfSize:16];
    [_backgroundImageView addSubview:_contentLabel];
    
    _accessoryLabel = [[UILabel alloc] init];
    _accessoryLabel.frame = CGRectMake(10, _backgroundImageView.bounds.size.height -  30, 100, 20);
    _accessoryLabel.backgroundColor = [UIColor clearColor];
    _accessoryLabel.textColor = [UIColor darkGrayColor];
    _accessoryLabel.font = [UIFont boldSystemFontOfSize:12];
    [_backgroundImageView addSubview:_accessoryLabel];
    
    
    _btn1 = [BFSPicTextButton buttonWithType:UIButtonTypeCustom];
    [_btn1 setImage:[UIImage imageNamed:@"查询"] forState:UIControlStateNormal];
    [_btn1 setTitle:@"查询" forState:UIControlStateNormal];
    [_btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _btn1.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [_contentLabel addSubview:_btn1];
    _btn1.frame = CGRectMake(10, 0, 60, 60);
    
    _btn2 = [BFSPicTextButton buttonWithType:UIButtonTypeCustom];
    [_btn2 setImage:[UIImage imageNamed:@"缴费"] forState:UIControlStateNormal];
    [_btn2 setTitle:@"缴费" forState:UIControlStateNormal];
    [_btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _btn2.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [_contentLabel addSubview:_btn2];
     _btn2.frame = CGRectMake(80, 0, 60, 60);
    
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
