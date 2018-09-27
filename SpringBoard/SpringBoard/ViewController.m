//
//  ViewController.m
//  HCSpringBoard
//
//  Created by 刘海川 on 16/3/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "ViewController.h"
#import "HCAssistant.h"
#import "HCWebViewController.h"
#import "AppDelegate.h"
#import "IFlyMSC/IFlyMSC.h"
#import "ISRDataHelper.h"

#import "HCBankListViewController.h"
#import "Waver.h"

@interface ViewController ()<IFlySpeechRecognizerDelegate>
    
@property (nonatomic, strong) NSMutableArray *iconModelsArray;
@property (nonatomic, strong) NSMutableArray *speechKeysArray;
@property (nonatomic, strong) HCSpringBoardView *springBoard;
@property (nonatomic, strong) UIImageView *cardView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) NSString*speechText;
@property (nonatomic, strong) Waver *waveView;
//不带界面的识别对象
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[[UIImage imageNamed:@"bg"] stretchableImageWithLeftCapWidth:320 topCapHeight:568]];
    [self.view addSubview:self.navBarView];
    //获取序列化到本地的所有菜单
    NSDictionary *mainMenuDict = [[NSDictionary alloc]initWithContentsOfFile:DOCUMENT_FOLDER(kMenuFileName)];
    _favoriteMainMenu = [HCFavoriteIconModel modelWithDictionary:mainMenuDict];
    [self displayMenu];
    
}
    
- (void)showAppStore:(UIButton *)sender
{
    HCWebViewController *webVC = [[HCWebViewController alloc] init];
    webVC.title = @"应用超市";
    webVC.url = @"http://t200storemarket.zhengtoon.com/app/index.html#/";
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [del.launcherController presentViewController:webVC animated:YES completion:nil];
}

- (void)eCardBtnAction:(UIButton *)sender
{
    if (self.cardView.alpha == 0) {
        [self eCardShow];
    }else if(self.cardView.alpha == 1){
        [self eCardHidden];
    }
}

- (void)eCardShow
{
    [UIView animateWithDuration:0.3 animations:^{
        self.cardView.alpha = 1;
        self.cardView.frame = CGRectMake(0,  (IPhoneX ? 88 : 64), kScreenSize.width, 150);
    }];
}

- (void)eCardHidden
{
    [UIView animateWithDuration:0.3 animations:^{
        self.cardView.alpha = 0;
        self.cardView.frame = CGRectMake(0,   (IPhoneX ? 88 : 64) -150, kScreenSize.width, 0);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_springBoard) {
        if (_springBoard.isEdit) {
            [_springBoard showEditButton];
        }
    }
}

- (void)displayMenu {
    _iconModelsArray = [[NSMutableArray alloc]init];
    //取出要显示的数据
    NSUserDefaults *userDefaultsLoveMenu = [[NSUserDefaults alloc]initWithSuiteName:kUserDefaultSuiteNameLoveMenu];
    NSArray *userDefaultsLoveMenuArray = [userDefaultsLoveMenu objectForKey:kUserDefaultLoveMenuKey];
    if (userDefaultsLoveMenu && userDefaultsLoveMenuArray) {
        NSData *modelsArrayData = [userDefaultsLoveMenu objectForKey:kUserDefaultLoveMenuKey];
        NSArray *modelsArray = [NSKeyedUnarchiver unarchiveObjectWithData:modelsArrayData];
        _iconModelsArray = [modelsArray mutableCopy];
    }
    else {
        [self getDisplayIcon:_favoriteMainMenu];

        NSData *iconModelsArrayData = [NSKeyedArchiver archivedDataWithRootObject:_iconModelsArray];
        [userDefaultsLoveMenu setObject:iconModelsArrayData forKey:kUserDefaultLoveMenuKey];
        [userDefaultsLoveMenu synchronize];
    }
    
    //汇总关键字
    self.speechKeysArray = [NSMutableArray arrayWithCapacity:0];
    [self.favoriteMainMenu.itemList enumerateObjectsUsingBlock:^(HCFavoriteIconModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.speechKeysArray addObject:obj.name];
    }];
    
    //根据数据显示菜单
    if ([self.view viewWithTag:SpringBoardTag]) {
        [_springBoard removeFromSuperview];
    }
    [self.view addSubview:self.springBoard];

    self.cardView.frame =  CGRectMake(0,   (IPhoneX ? 88 : 64) -150, kScreenSize.width, 150);
    self.cardView.alpha = 0;
    [self.view addSubview:self.cardView];
    //底部Tabbar
    [self.view addSubview:self.bottomView];
    
}

- (void)bottomBtnClicked:(UIButton *)sender
{
    if (sender.tag == 5) {
        HCBankListViewController *menuListViewController = [[HCBankListViewController alloc] initWithMainMenu:self.favoriteMainMenu.itemList];
        AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [del.launcherController presentViewController:[[UINavigationController alloc] initWithRootViewController:menuListViewController] animated:YES completion:nil];
    }

}

-(IFlySpeechRecognizer *)iFlySpeechRecognizer
{
    if (!_iFlySpeechRecognizer) {
        //创建语音识别对象
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        _iFlySpeechRecognizer.delegate = self;
        //设置识别参数
        //设置为听写模式
        [_iFlySpeechRecognizer setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
        //asr_audio_path 是录音文件名，设置value为nil或者为空取消保存，默认保存目录在Library/cache下。
        [_iFlySpeechRecognizer setParameter:@"iat.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        //设置最长录音时间:60秒
        [_iFlySpeechRecognizer setParameter:@"-1" forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置语音后端点:后端点静音检测时间，即用户停止说话多长时间内即认为不再输入， 自动停止录音
        [_iFlySpeechRecognizer setParameter:@"3000" forKey:[IFlySpeechConstant VAD_EOS]];
        //设置语音前端点:静音超时时间，即用户多长时间不说话则当做超时处理
        [_iFlySpeechRecognizer setParameter:@"3000" forKey:[IFlySpeechConstant VAD_BOS]];
        //网络等待时间
        [_iFlySpeechRecognizer setParameter:@"2000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        //设置采样率，推荐使用16K
        [_iFlySpeechRecognizer setParameter:@"16000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
        //设置语言
        [_iFlySpeechRecognizer setParameter:@"zh_cn" forKey:[IFlySpeechConstant LANGUAGE]];
        //设置方言
        [_iFlySpeechRecognizer setParameter:@"mandarin" forKey:[IFlySpeechConstant ACCENT]];//普通话
        //设置是否返回标点符号
        [_iFlySpeechRecognizer setParameter:@"0" forKey:[IFlySpeechConstant ASR_PTT]];
        
    }
    return _iFlySpeechRecognizer;
}

- (void)startSpeechRecognizer:(UIButton *)sender
{
    NSLog(@"-----%@",NSStringFromSelector(_cmd));
    self.speechText = @"";
    [self.iFlySpeechRecognizer startListening];

    if (!self.waveView.superview) {
        self.waveView.frame = CGRectMake(0, kScreenSize.height - 180, kScreenSize.width, 60);
        [self.view addSubview:self.waveView];
    }
   
}

- (void)stopSpeechRecognizer:(UIButton *)sender
{
    [self.iFlySpeechRecognizer stopListening];
    [self.waveView removeFromSuperview];
}

#pragma mark - IFlySpeechRecognizerDelegate协议实现
//识别结果返回代理
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast{
    NSLog(@"-----%@",NSStringFromSelector(_cmd));
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    
    NSString * resultFromJson = [ISRDataHelper stringFromJson:resultString];
    self.speechText = [NSString stringWithFormat:@"%@%@", self.speechText,resultFromJson];
}



//识别会话结束返回代理
- (void)onCompleted: (IFlySpeechError *) error{
    if (error.errorCode == 0 ) {
        //识别完毕
        if ([self.speechText containsString:@"打开"] || [self.speechText containsString:@"查询"]) {
            NSString *keyword = [self hitAppNameBySpeechKeywords:self.speechText];
            if (keyword) {
                HCWebViewController *webVC = [[HCWebViewController alloc] init];
                webVC.title = keyword;
                AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [del.launcherController presentViewController:webVC animated:YES completion:nil];
            }
        }
    }
    if (self.waveView.superview) {
         [self.waveView removeFromSuperview];
    }
}

//停止录音回调
- (void) onEndOfSpeech{}
//开始录音回调
- (void) onBeginOfSpeech{}
//会话取消回调
- (void) onCancel{}

//音量回调函数
- (void) onVolumeChanged: (int)volume{
    NSString * vol = [NSString stringWithFormat:@"音量：%d",volume];
    
}

- (NSString *)hitAppNameBySpeechKeywords:(NSString *)speechText
{
    __block NSString *appName = nil;
    [self.speechKeysArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self.speechText containsString:obj]) {
            *stop = YES;
            appName = obj;
        }
    }];
    return appName;
}

#pragma mark - Setter & Getter
- (UIView *)navBarView
{
    if(!_navBarView){
        _navBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, (IPhoneX ? 88 : 64))];
        _navBarView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];

        //高斯模糊
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = _navBarView.bounds;
        [_navBarView addSubview:effectView];
        
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (IPhoneX ? 44 : 20), kScreenSize.width, 40)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text =  @"公民";
        [_navBarView addSubview:_titleLabel];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor whiteColor];
        line.frame = CGRectMake(0, 0, 48, 3);
        line.center = CGPointMake(kScreenSize.width/2, CGRectGetMaxY(_titleLabel.frame));
        [_navBarView addSubview:line];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = _titleLabel.frame;
        [button addTarget:self action:@selector(eCardBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_navBarView addSubview:button];
        
        UIButton *appStoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        appStoreButton.frame = CGRectMake(kScreenSize.width - 40,  (IPhoneX ? 44 : 20)+7, 30, 30);
        [appStoreButton setImage:[UIImage imageNamed:@"appStore"] forState:UIControlStateNormal];
        [appStoreButton addTarget:self action:@selector(showAppStore:) forControlEvents:UIControlEventTouchUpInside];
        [_navBarView addSubview:appStoreButton];
    }
    return _navBarView;
}
    
- (UIImageView *)cardView
{
    if (!_cardView) {
        _cardView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"card"]];
    }
    return _cardView;
}

- (HCSpringBoardView *)springBoard
{
    if(!_springBoard){
        CGRect sbRect = CGRectMake(0,  (IPhoneX ? 88 : 64), kScreenSize.width, [self getOnePageRomByDevice]*(ICONIMG_HEIGHT+0.5)+40);
        _springBoard = [[HCSpringBoardView alloc] initWithFrame:sbRect modes:_iconModelsArray];
        _springBoard.springBoardDelegate = self;
        _springBoard.tag = SpringBoardTag;
    }
    return _springBoard;
}
    
- (UIView *)bottomView
{
    if(!_bottomView){
        //底部Tabbar
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenSize.height - 90, kScreenSize.width, 90)];
        _bottomView.backgroundColor  = [UIColor colorWithWhite:0.9 alpha:0.5];
      
        //高斯模糊
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = _bottomView.bounds;
        [_bottomView addSubview:effectView];
        
        CGFloat width  = (kScreenSize.width - 90)/ 5;
        for (int i = 1; i <= 5; i++) {
            UIButton *pButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [pButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab%@",@(i)]] forState:UIControlStateNormal];
            pButton.tag = i;
            pButton.frame = CGRectMake(15*i+width*(i-1), (90-(width))/2, width, width);
            if (i == 3) {
                //语音识别
                [pButton addTarget:self action:@selector(startSpeechRecognizer:) forControlEvents:UIControlEventTouchDown];
                 [pButton addTarget:self action:@selector(stopSpeechRecognizer:) forControlEvents:UIControlEventTouchUpInside];
            }else {
                [pButton addTarget:self action:@selector(bottomBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            }
            [_bottomView addSubview:pButton];
        }
    }
    return _bottomView;
}

- (Waver *)waveView
{
    if (!_waveView) {
        //语音输入动画
        _waveView = [[Waver alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100.0)];
        _waveView.waverLevelCallback = ^(Waver * waver) {
            waver.level = 1;
        };
    }
    return _waveView;
}
#pragma mark - HCSpringBoardDelegate
- (void)springBoardDidScroll:(HCSpringBoardView *)springBoard
{
    [self eCardHidden];
}


#pragma mark - 快捷方法
//递归查找需要显示的图标
- (void)getDisplayIcon:(HCFavoriteIconModel *)favoroteModel
{
    if ([favoroteModel.type isEqualToString:kViewcontroller] || [favoroteModel.type isEqualToString:kWebLocal] || [favoroteModel.type isEqualToString:kWebNetwork]) {
        if (favoroteModel.display) {
            [_iconModelsArray addObject:favoroteModel];
        }
    }
    else if ([favoroteModel.type isEqualToString:kMenuList] || [favoroteModel.type isEqualToString:kMenuIcons]) {
        for (int i = 0; i < favoroteModel.itemList.count; i++) {
            [self getDisplayIcon:favoroteModel.itemList[i]];
        }
    }
}

- (NSInteger)getOnePageRomByDevice {
    NSInteger row = 5;
    if (IPHONE6Plus){
        row = 5;
    }
    return row;
}

@end
