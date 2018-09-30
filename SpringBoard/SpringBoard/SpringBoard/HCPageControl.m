//
//  HCPageControl.m
//  SpringBoard
//
//  Created by wangpo on 2018/9/30.
//  Copyright © 2018年 wangpo. All rights reserved.
//

#import "HCPageControl.h"
#import "HCAssistant.h"
#define kGap  9
#define kSize 7

@implementation HCPageControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init{
    
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
    }
    return self;
    
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    [super setNumberOfPages:numberOfPages];
    [self updateDots];
    
}

- (void)updateDots{
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            [subView removeFromSuperview];
        }
    }
    NSInteger count = self.subviews.count;
    if (count > 0) {

       
        if (count % 2 == 0) {
            //偶数
            UIImageView *preDot = [[UIImageView alloc] init];
            preDot.frame = CGRectMake(ScreenWidth/2.0 - (9*0.5+(count/2)*(16)+7), 6.5f, 7, 7);
            preDot.layer.cornerRadius = 3.5;
            preDot.layer.masksToBounds = YES;
            preDot.backgroundColor = [UIColor whiteColor];
            [self addSubview:preDot];
            
            
            UIImageView *lastDot = [[UIImageView alloc] init];
            lastDot.frame = CGRectMake(ScreenWidth/2.0 + (9*0.5+(count/2)*16), 6.5f, 7, 7);
            lastDot.layer.cornerRadius = 3.5;
            lastDot.layer.masksToBounds = YES;
            lastDot.backgroundColor = [UIColor whiteColor];
            [self addSubview:lastDot];
            
        }else {
            //奇数
            UIImageView *preDot = [[UIImageView alloc] init];
            preDot.frame = CGRectMake(ScreenWidth/2.0 - (7*0.5 + (count/2+1)*(16)), 6.5f, 7, 7);
            preDot.layer.cornerRadius = 3.5;
            preDot.layer.masksToBounds = YES;
            preDot.backgroundColor = [UIColor whiteColor];
            [self addSubview:preDot];
            
            
            UIImageView *lastDot = [[UIImageView alloc] init];
            lastDot.frame = CGRectMake(ScreenWidth/2.0 + (7*0.5 + (count/2)*(16)+9), 6.5f, 7, 7);
            lastDot.layer.cornerRadius = 3.5;
            lastDot.layer.masksToBounds = YES;
            lastDot.backgroundColor = [UIColor whiteColor];
            [self addSubview:lastDot];
            
        }
       
    }
   
    
}

@end
