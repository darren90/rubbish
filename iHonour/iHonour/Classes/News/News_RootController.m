//
//  News_RootController.m
//  iHonour
//
//  Created by Tengfei on 2017/3/25.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "News_RootController.h"
#import "TFWebView.h"

@interface News_RootController ()<WKNavigationDelegate>
@property (weak, nonatomic) TFWebView *webView;

@end

@implementation News_RootController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"游戏资讯";
 
    [self testWebView];
    [self testHonour];
}

-(void)testWebView{
    
    TFWebView *webView = [[TFWebView alloc]init];
//    webView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-49);
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
    
    self.webView = webView;
    webView.navigationDelegate = self;
    webView.backgroundColor = [UIColor cyanColor];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://news.4399.com/gonglue/wzlm/zixun/"]]];
}


- (void)testHonour
{
    NSURL *uurl = [NSURL URLWithString:@"http://news.4399.com/gonglue/wzlm/zixun/"];
//    NSData *dd = [NSData dataWithContentsOfURL:uurl];
//    NSString *ss = [[NSString alloc]initWithData:dd encoding:0];
//    NSLog(@"--ss:%@",ss);
    NSURLRequest *request = [NSURLRequest requestWithURL:uurl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:120.0];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
//            NSString *str = [[NSString alloc] initWithData:data encoding:0];
//            NSLog(@"---rrr:%@",str);
            //3.创建数据解析对象
//            TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:data];
            TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:data encoding:@"utf-8"];
            NSString *strs = [[NSString alloc] initWithData:xpathParser.data encoding:NSASCIIStringEncoding];

            //4.通过Xpath定位到指定位置并获取数据
            
            NSArray *elements2 = [xpathParser searchWithXPathQuery:@"//a[starts-with(@class,'title')]"];

            NSArray *elements = [xpathParser searchWithXPathQuery:@"//ul[@class='txt-list cf']//li"];
            if (elements.count > 0){
                //5.使用数据
                //NSLog(@"elements=%@",elements[0]);
                TFHppleElement *element = elements[0];
                NSArray *chiledrens = [element children];
                if (chiledrens.count > 0) {
                    for (TFHppleElement *el in chiledrens) {
                        NSString *title = @"";
                        //NSString *content = @"";
                        NSString *href = @"";
                        NSString *imgUrl = @"";
                        
                        NSArray *elChs = el.children;
                        
                        if (elChs.count > 0) {
                            for (TFHppleElement *ell in elChs) {
                                NSString *etext = [ell text];
                                //NSString *econtent = [[ell content] stringByReplacingOccurrencesOfString:@" " withString:@""];
                                NSString *ehref = [ell objectForKey:@"href"];
                                //NSString *eimg = [ell objectForKey:@"img"];
                                if (etext) {
                                    title = etext;
                                    href = ehref;
                                }
                                //NSLog(@"--eeeetext-:%@,content: %@ , href: %@ , img: %@",etext,econtent,ehref,eimg);
                                
                                if (ell.hasChildren){
                                    //if ([title isEqualToString:@"老夫子"]) {
                                    //    NSLog(@"");
                                    //}
                                    TFHppleElement *imgEl = ell.firstChild;
                                    NSDictionary *imgDic = imgEl.attributes;
                                    if (imgDic) {
                                        imgUrl = imgDic[@"src"];//部分用的字段是lz_src
                                        if (imgUrl.length == 0) {
                                            //NSLog(@"---img:%@",imgDic);
                                            imgUrl = imgDic[@"lz_src"];
                                        }
                                        //NSLog(@"--imgUrl:%@",imgDic[@"src"]);
                                    }
                                }
                                
                            }
                        }
                        if (title.length > 0) {
                            NSLog(@"--title-:%@ , href: %@ , img: %@",title,href,imgUrl);
                        }
                    }
                }
            }
            
        }else{//下载失败
            NSLog(@"---:网页下载失败：%@",error);
        }
    }];
    
    [task resume];
}

-(void)ttt{
    NSString *str = @"";
}



@end
