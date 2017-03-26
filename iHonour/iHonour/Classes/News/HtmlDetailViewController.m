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
    
    self.title = self.titleStr;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.detailUrl]]];

    [self initAdView];
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


- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
//    NSLog(@"---");
    
 
    
//    [webView stringByEvaluatingJavaScriptFromString:js];
}


-(WKWebViewConfiguration *)webConfig{
    NSMutableString *js = [NSMutableString string];
    //删除header
    [js appendString:@"var header = document.getElementsByTagName('header')[0];"];
    [js appendString:@"header.parentNode.removeChild(header);"];
    
    //删除购买
    [js appendString:@"var top = document.getElementsByClassName('cost-box')[0];"];
    [js appendString:@"top.parentNode.removeChild(top);"];
    
    //删除header
    [js appendString:@"var bottom = document.getElementsByClassName('buy-now')[0];"];
    [js appendString:@"bottom.parentNode.removeChild(bottom);"];
    
    // 根据JS字符串初始化WKUserScript对象
    WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    // 根据生成的WKUserScript对象，初始化WKWebViewConfiguration
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    [config.userContentController addUserScript:script];
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







@end
