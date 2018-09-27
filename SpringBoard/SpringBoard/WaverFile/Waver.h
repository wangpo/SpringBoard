//
//  Waver.h
//  Waver
//
//  Created by kevinzhow on 14/12/14.
//  Copyright (c) 2014年 Catch Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Waver : UIButton

@property (nonatomic, copy) void (^waverLevelCallback)(Waver * waver);

//波浪数量
@property (nonatomic) NSUInteger numberOfWaves;

//波浪颜色
@property (nonatomic) UIColor * waveColor;

//波浪水平
@property (nonatomic) CGFloat level;

//主波浪宽
@property (nonatomic) CGFloat mainWaveWidth;

//装饰波浪宽
@property (nonatomic) CGFloat decorativeWavesWidth;

//闲置的振幅
@property (nonatomic) CGFloat idleAmplitude;

//频率
@property (nonatomic) CGFloat frequency;

//振幅
@property (nonatomic, readonly) CGFloat amplitude;

//密度
@property (nonatomic) CGFloat density;

//相位
@property (nonatomic) CGFloat phaseShift;

//
@property (nonatomic, readonly) NSMutableArray * waves;

@end
