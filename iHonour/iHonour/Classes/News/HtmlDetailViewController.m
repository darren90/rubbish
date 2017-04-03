//
//  HtmlDetailViewController.m
//  iHonour
//
//  Created by Tengfei on 2017/3/26.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "HtmlDetailViewController.h"
#import "TFWebView.h"
#import "HTMLParser.h"
#import "TFHpple.h"
#import "AdmobView.h"

@interface HtmlDetailViewController ()<WKNavigationDelegate>
@property (weak, nonatomic) TFWebView *webView;

@end

@implementation HtmlDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    NSLog(@"--:%@",self.detailUrl);
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initWebView];
    [self startAnimate];
    
    self.title = self.titleStr;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.detailUrl]]];

    [self initAdView];
    
    BOOL result = [[RMLTools shareTools] isThisCollected:self.newsModel listType:self.listType];
    if (result) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"home_sc_n"] style:UIBarButtonItemStyleDone target:self action:@selector(likeAction)];
    }else{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"like_n"] style:UIBarButtonItemStyleDone target:self action:@selector(likeAction)];
    }
    
    
    //KVO
    [self.webView addObserver:self
                   forKeyPath:@"loading"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
}


#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"loading"]) {
//        NSLog(@"loading");
        // 加载完成
        if (!self.webView.loading) {
            [self injectJSCode];
        }
        
    }
}

#pragma mark -- WKWebView代理

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    NSLog(@"-didFinishNavigation--");
    [self injectJSCode];
    self.requestState = RequestStateNone;
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    self.requestState = RequestStateNoData;
    NSLog(@"--网页加载失败--");
}

-(void)injectJSCode{
    // 1 - 资讯需要删除的地方
    
    // 手动调用JS代码
    NSMutableString *js = [NSMutableString string];
    
    if (self.listType == RMListNews) {
        //删除header
        [js appendString:@"var header = document.getElementsByClassName('header')[0];"];
        [js appendString:@"header.parentNode.removeChild(header);"];
        
        //删除网站导航
        [js appendString:@"var header = document.getElementsByClassName('srcmenuwp')[0];"];
        [js appendString:@"header.parentNode.removeChild(header);"];
        
        //删除引导下载王者荣耀的链接
        [js appendString:@"var header = document.getElementsByClassName('gamehbtn mt15 head-wp')[0];"];
        [js appendString:@"header.parentNode.removeChild(header);"];
        
        //删除 热门游戏专区
        [js appendString:@"var header = document.getElementsByClassName('area tit12')[0];"];
        [js appendString:@"header.parentNode.removeChild(header);"];
        
        //删除最底部
        [js appendString:@"var header = document.getElementsByClassName('footwp ftinner')[0];"];
        [js appendString:@"header.parentNode.removeChild(header);"];
        
    }else{
        
        // 2 - 攻略需要删除的地方
        [js appendString:@"$(\"#AQ_B_CONTAINER_47\").remove();"];

        //删除最顶部
        [js appendString:@"var header1 = document.getElementsByClassName('header tac re ov')[0];"];
        [js appendString:@"header1.parentNode.removeChild(header1);"];

        //删除底部
        
        [js appendString:@"var header6 = document.getElementsByClassName('wz-title pl10 pr10')[0];"];
        [js appendString:@"header6.parentNode.removeChild(header6);"];
        
        [js appendString:@"var header7 = document.getElementsByClassName('game-ul mb25')[0];"];
        [js appendString:@"header7.parentNode.removeChild(header7);"];
        
        [js appendString:@"var header8 = document.getElementsByClassName('pt15 pb15 pl20 pr20 huiBG mb30')[0];"];
        [js appendString:@"header8.parentNode.removeChild(header8);"];
        
        //游戏推荐
        [js appendString:@"var header8 = document.getElementsByClassName('imgsc-fixed')[0];"];
        [js appendString:@"header8.parentNode.removeChild(header8);"];
        
        [js appendString:@"var header8 = document.getElementsByClassName('game-ul mb25')[0];"];
        [js appendString:@"header8.parentNode.removeChild(header8);"];
        
        [js appendString:@"var header8 = document.getElementsByClassName('mt30')[0];"];
        [js appendString:@"header8.parentNode.removeChild(header8);"];
        
        //删除广告
//        [js appendString:@"$(\"#71414\").remove();"];

        [js appendString:@"var iframes = document.getElementsByTagName('iframe'); for (var i = 0; i < iframes.length; i++) { iframes[i].parentNode.removeChild(iframes[i]); };"];
        
    }
    
    
    [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"--注入-response: %@ error: %@", response, error);
    }];

}

-(void)likeAction{

    BOOL result = [[RMLTools shareTools] isThisCollected:self.newsModel listType:self.listType];

    if (result) {
        [[RMLTools shareTools] delCollectWithUrl:self.detailUrl];
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"like_n"];
    }else{
        [[RMLTools shareTools] addCollect:self.newsModel listType:self.listType];
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"home_sc_n"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initWebView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    TFWebView *webView = [[TFWebView alloc]initWithFrame:CGRectZero configuration:[self webConfig]];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
    webView.navigationDelegate = self;
    self.webView = webView;
    webView.backgroundColor = [UIColor cyanColor];
}



-(WKWebViewConfiguration *)webConfig{
     // 根据生成的WKUserScript对象，初始化WKWebViewConfiguration
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
//    [config.userContentController addUserScript:script];
    return config;
}


#pragma mark --- 添加广告

-(void)initAdView{
    NSString *adUnitID = kGoogleAdmobNews_Bottom_01;
    switch (self.adType) {
        case Admob_News_Bottom:
            adUnitID = kGoogleAdmobNews_Bottom_01;
            break;
        case Admob_Cheats_Bottom:
            adUnitID = kGoogleAdmobCheats_Bottom_01;
            break;
        case Admob_Heros_Bottom:
            adUnitID = kGoogleAdmobHeros_Bottom_01;
            break;
            
        default:
            break;
    }
    
    AdmobView *adView = [[AdmobView alloc]init];
    adView.adUnitID = adUnitID;
    [self.view addSubview:adView];
    adView.bannerView.rootViewController = self;
    [adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.equalTo(@55);
    }];
}


-(void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"loading"];
}




@end
