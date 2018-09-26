//
//  NBWaveView.m
//  波浪
//
//  Created by mac on 2017/10/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "NBWaveView.h"
#import "NBWaveConfig.h"
#import "UIView+Extension.h"

@interface NBWaveView()
/**
 水波纹动图的定时器
 */
@property (nonatomic, strong) CADisplayLink *waveDisplaylink;
/**
 波纹View
 */
@property (nonatomic,strong) CAShapeLayer * waveLayer;
/**
 基础设置
 */
@property(nonatomic, strong) NBWaveConfig *config;

@property(nonatomic, strong) UIImageView *imgView;

@end

@implementation NBWaveView
#pragma mark - 快速创建方法
+ (instancetype)waveViewWithConfig:(void (^)(NBWaveConfig *))config
{
    NBWaveView *waveView = [[NBWaveView alloc] initWithConfig:config];
    return waveView;
}
- (instancetype)initWithConfig:(void (^)(NBWaveConfig *))config
{
    NBWaveView *waveView = [[NBWaveView alloc] init];
    if (config) {
        config(waveView.config);
    }
    waveView.backgroundColor = waveView.config.bgColor;
    [waveView.layer addSublayer:waveView.waveLayer];
    if (waveView.config.isAnimation) {
        [waveView startWave];
    }
    return waveView;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self wave];
}

/**
 这里进行绘制
 */
- (void)wave
{
    CGMutablePathRef path = CGPathCreateMutable();
    // 设置波浪起点
    CGFloat y = self.config.waveC;
    CGPathMoveToPoint(path, nil, 0, 0);
    // 绘制波浪至终点
    for (NSInteger x = 0.f; x <= self.width; x++) {
        y = self.config.waveA * sin(self.config.wavePeriod*x+self.config.waveOffset) + self.config.waveC;
        CGPathAddLineToPoint(path, nil, x, y);
    }
   

    self.waveLayer.fillColor = self.config.waveColor.CGColor;
    self.waveLayer.strokeColor = [UIColor blueColor].CGColor;
    self.waveLayer.strokeStart = 0.1;
    self.waveLayer.strokeEnd = 0.5;
    CGPathCloseSubpath(path);
    self.waveLayer.path = path;
    CGPathRelease(path);
}

/**
 开启定时器
 */
- (void)startWave
{
    if (_waveDisplaylink != nil) { return; }
    // 开启定时器
    [self waveDisplaylink];

}

- (void)drawWave
{
    self.config.waveOffset += self.config.waveSpeed;
    [self setNeedsDisplay];

}

/**
 停止波纹展示
 */
- (void)stopWave
{
    [self.waveDisplaylink invalidate];
    self.waveDisplaylink = nil;
}
#pragma mark - 懒加载
/**
 绘制的图层layer
 */
- (CAShapeLayer *)waveLayer
{
    if (_waveLayer == nil) {
        _waveLayer = [CAShapeLayer layer];
    }
    return _waveLayer;
}
/**
 定时器
 */
- (CADisplayLink *)waveDisplaylink
{
    if (_waveDisplaylink == nil) {
        //启动定时器
        _waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawWave)];
        [_waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _waveDisplaylink;
}
/**
 默认配置
 */
- (NBWaveConfig *)config
{
    if (_config == nil) {
        _config = [NBWaveConfig defaultConfig];
    }
    return _config;
}

/**
 销毁定时器
 */
- (void)dealloc
{
    [self stopWave];
}

@end
