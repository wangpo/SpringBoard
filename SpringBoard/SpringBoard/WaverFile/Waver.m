//
//  Waver.m
//  Waver
//
//  Created by kevinzhow on 14/12/14.
//  Copyright (c) 2014年 Catch Inc. All rights reserved.
//

#import "Waver.h"

@interface Waver ()
{
    
    CAGradientLayer *gradient1;
    CAGradientLayer  *bgGradientLayer;
    
    
}

@property (nonatomic) CAGradientLayer *gradientLayer;
@property (nonatomic) CAGradientLayer *gradientLayer_other;

@property (nonatomic) CGFloat phase;
@property (nonatomic) CGFloat amplitude;
@property (nonatomic) NSMutableArray * waves;
@property (nonatomic) CGFloat waveHeight;
@property (nonatomic) CGFloat waveWidth;
@property (nonatomic) CGFloat waveMid;
@property (nonatomic) CGFloat maxAmplitude;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic) CAShapeLayer *middleLayer;
@end

@implementation Waver


- (id)init
{
    if(self = [super init]) {
        [self setup];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}


//初始化
- (void)setup
{
    self.waves = [NSMutableArray new];
    
    self.frequency = 1.0f;  //频率   改变屏幕波纹数量
    
    self.amplitude = 2.0f;  //振幅
    self.idleAmplitude = 0.01f;  //闲置振幅  当没有外部音源输入时的最小振幅
    
    self.numberOfWaves = 3;
    self.phaseShift = 0.02f; //相位  改变波纹移动速度
    self.density = 1.f; //取样点间隔，越小越平滑
    
    self.waveColor = [UIColor whiteColor];
    self.mainWaveWidth = 2.0f;
    self.decorativeWavesWidth = 1.0f;
    
	self.waveHeight = CGRectGetHeight(self.bounds);
    self.waveWidth  = CGRectGetWidth(self.bounds);
    self.waveMid    = self.waveWidth / 2.0f;    //控制屏幕中波浪起伏的中点位置
    self.maxAmplitude = self.waveHeight - 4.0f;
    
    UIColor * bC = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
    UIColor * yC = [UIColor colorWithRed:18/255.f green:136/255.f blue:114/255.f alpha:1];
    UIColor * gC = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
    
    
    bgGradientLayer = [CAGradientLayer layer];
    bgGradientLayer.frame    = CGRectMake(0, 0, self.waveWidth, self.waveHeight);
    
    bgGradientLayer.backgroundColor = yC.CGColor;

    [self.layer addSublayer:bgGradientLayer];
    
    
    //主线
    _gradientLayer
    = [CAGradientLayer layer];
    _gradientLayer.frame    = CGRectMake(0, 0, self.waveWidth, self.waveHeight);
    _gradientLayer.colors = @[(__bridge id)bC.CGColor,
                              (__bridge id)yC.CGColor,
                              (__bridge id)bC.CGColor];
    
    _gradientLayer.locations  = @[@(0.0),@(0.5),@(1)];
    _gradientLayer.startPoint = CGPointMake(0, 0);
    _gradientLayer.endPoint  = CGPointMake(0, 1);
    [self.layer addSublayer:_gradientLayer];
    
    //self.layer.mask = _gradientLayer;
    
   
    //次线
    _gradientLayer_other = [CAGradientLayer layer];
    _gradientLayer_other.frame    = CGRectMake(0, 0, self.waveWidth, self.waveHeight);
    _gradientLayer_other.colors = @[(__bridge id)gC.CGColor,
                                    (__bridge id)yC.CGColor,
                                    (__bridge id)gC.CGColor];
    
    _gradientLayer_other.locations  = @[@(0.0),@(0.5),@(1)];
    _gradientLayer_other.startPoint = CGPointMake(0, 0);
    _gradientLayer_other.endPoint  = CGPointMake(0, 1);
    [self.layer addSublayer:_gradientLayer_other];
    
    
    _middleLayer = [[CAShapeLayer alloc] init];
}

- (void)setWaverLevelCallback:(void (^)(Waver * waver))waverLevelCallback {
    _waverLevelCallback = waverLevelCallback;

    [self.displayLink invalidate];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(invokeWaveCallback)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    for(int i=0; i < self.numberOfWaves; i++)
    {
        CAShapeLayer *waveline = [CAShapeLayer layer];
        waveline.lineCap       = kCALineCapButt;
        waveline.lineJoin      = kCALineJoinRound;
        waveline.strokeColor   = [[UIColor clearColor] CGColor];
        waveline.fillColor     = [[UIColor clearColor] CGColor];
        [waveline setLineWidth:(i==0 ? self.mainWaveWidth : self.decorativeWavesWidth)];
        CGFloat progress = 1.0f - (CGFloat)i / self.numberOfWaves;
        CGFloat multiplier = MIN(1.0, (progress / 3.0f * 2.0f) + (1.0f / 3.0f));
		UIColor *color = [self.waveColor colorWithAlphaComponent:(i == 0 ? 1.0 : 1.0 * multiplier * 0.4)];
		waveline.strokeColor = color.CGColor;
        [self.layer addSublayer:waveline];
        [self.waves addObject:waveline];
    }
    
}

- (void)invokeWaveCallback
{
    self.waverLevelCallback(self);
}


//设置振幅
- (void)setLevel:(CGFloat)level
{
    _level = level;
    
    self.phase += self.phaseShift; // Move the wave
    
    self.amplitude = fmax( level, self.idleAmplitude);
    [self updateMeters];
}


- (void)updateMeters
{
	self.waveHeight = CGRectGetHeight(self.bounds);
	self.waveWidth  = CGRectGetWidth(self.bounds);
	self.waveMid    = self.waveWidth / 2.0f;
	self.maxAmplitude = self.waveHeight - 4.0f;
	
    UIGraphicsBeginImageContext(self.frame.size);
    
    for(int i=0; i < self.numberOfWaves; i++) {

        UIBezierPath *wavelinePath = [UIBezierPath bezierPath];
        
        for(CGFloat x = 0; x<self.waveWidth + self.density; x += self.density) {
            
            //使用新算法计算点
            CGFloat mapx = x/self.waveWidth*4-2;
            CGFloat mapy = [self calcValueForY:mapx offset:self.phase];
            
            CGFloat y = 0;
            if (i == 0) {
                y=(mapy+0.5)*self.waveHeight;
            }else if(i == 1){
                y=(-mapy+0.5)*self.waveHeight;
            }else{
                y = (mapy/5+0.5)*self.waveHeight;
            }
            
            if (x==0) {
                [wavelinePath moveToPoint:CGPointMake(x, y)];
            }
            else {
                [wavelinePath addLineToPoint:CGPointMake(x, y)];
            }
        }
        CAShapeLayer *waveline = [self.waves objectAtIndex:i];
        waveline.path = [wavelinePath CGPath];
        if (i==0 || i == 1) {
            waveline.fillColor = [UIColor whiteColor].CGColor;
        }
        
        if (i == 0) {
            _gradientLayer.mask = waveline;
        }else if(i == 1){
            _gradientLayer_other.mask = waveline;
        }
    }
    
    UIBezierPath *wavelinePath = [UIBezierPath bezierPathWithRect:CGRectMake(0, self.waveHeight/2-1.5, self.waveWidth,3)];
    _middleLayer.path = wavelinePath.CGPath;
    _middleLayer.fillColor = [UIColor blackColor].CGColor;
    _middleLayer.zPosition = 0;
    bgGradientLayer.mask = _middleLayer;
    
    UIGraphicsEndImageContext();
}

-(CGFloat)calcValueForY:(CGFloat)mapX offset:(CGFloat)offset{
    double sinFunc = sin(0.75 * M_PI * mapX - offset * M_PI);//这里的offset * Math.PI是偏移量φ
    double recessionFunc = pow(4 / (4 + pow(mapX, 4)), 2.5);
    return 0.5 * sinFunc * recessionFunc;
}


- (void)dealloc
{
    [_displayLink invalidate];
}

@end
