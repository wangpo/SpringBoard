//
//  BFSPicTextButton.m
//  BFSports
//
//  Created by wangpo on 2017/3/18.
//  Copyright © 2017年 BaoFeng. All rights reserved.
//

#import "BFSPicTextButton.h"

@implementation BFSPicTextButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(15, 15, 30, 30);
    self.titleLabel.frame = CGRectMake(0,  50, 60, 10);

}


@end
