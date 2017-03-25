//
//  ViewController.m
//  iHonour
//
//  Created by Fengtf on 2017/3/25.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "ViewController.h"
#import "TFWebView.h"
#import "HTMLParser.h"
#import "TFHpple.h"

@interface ViewController ()

@property (weak, nonatomic) TFWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self testHonour];

}

- (void)testHonour
{
    NSURL *uurl = [NSURL URLWithString:@"http://m.news.4399.com/gonglue/wzlm/yingxiong/"];

    NSURLRequest *request = [NSURLRequest requestWithURL:uurl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:120.0];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            //3.创建数据解析对象
            TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:data];
            //4.通过Xpath定位到指定位置并获取数据
            NSArray *elements = [xpathParser searchWithXPathQuery:@"//ul[@class='plist2 cf ulList']"];
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



- (void)testHtml
{
    //1.构建网址
    NSURL *url = [NSURL URLWithString:@"http://www.weiphone.com/apple/news/index_1.shtml"];
    //2.转换成NSData类型
    NSData *urlData = [[NSData alloc]initWithContentsOfURL:url];

    NSURL *uurl = [NSURL URLWithString:@"http://www.weiphone.com/apple/news/index_1.shtml"];

    NSURLRequest *request = [NSURLRequest requestWithURL:uurl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:120.0];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            //3.创建数据解析对象
            TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:data];
            //4.通过Xpath定位到指定位置并获取数据
            NSArray *elements = [xpathParser searchWithXPathQuery:@"//div[@id='news']"];
            if (elements.count > 0){
                //5.使用数据
                //NSLog(@"elements=%@",elements[0]);
                TFHppleElement *element = elements[0];
                NSArray *chiledrens = [element children];
                if (chiledrens.count > 0) {
                    for (TFHppleElement *el in chiledrens) {
                        NSString *text = [el text];
                        NSString *content = [[el content] stringByReplacingOccurrencesOfString:@" " withString:@""];
                        NSLog(@"--text-:%@,content: %@",text,content);
                    }
                }
            }

        }else{//下载失败
            NSLog(@"---:网页下载失败：%@",error);
        }
    }];

    [task resume];

    return;

    //3.创建数据解析对象
    TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:urlData];
    //4.通过Xpath定位到指定位置并获取数据
    NSArray *elements = [xpathParser searchWithXPathQuery:@"//div[@id='news']"];
    if (elements.count > 0){
        //5.使用数据
        NSLog(@"elements=%@",elements[0]);
    }

}















-(void)parseHtml2{



}

-(void)parseHtml{
    NSError *error = nil;
    NSString *html =
    @"<ul>"
    "<li><input type='image' name='input1' value='string1value' /></li>"
    "<li><input type='image' name='input2' value='string2value' /></li>"
    "</ul>"
    "<span class='spantext'><b>Hello World 1</b></span>"
    "<span class='spantext'><b>Hello World 2</b></span>";
    HTMLParser *parser = [[HTMLParser alloc] initWithString:html error:&error];

    if (error) {
        NSLog(@"Error: %@", error);
        return;
    }

    HTMLNode *bodyNode = [parser body];

    NSArray *inputNodes = [bodyNode findChildTags:@"input"];

    for (HTMLNode *inputNode in inputNodes) {
        if ([[inputNode getAttributeNamed:@"name"] isEqualToString:@"input2"]) {
            NSLog(@"input2---: %@", [inputNode getAttributeNamed:@"value"]); //Answer to first question
        }
    }

    NSArray *spanNodes = [bodyNode findChildTags:@"span"];

    for (HTMLNode *spanNode in spanNodes) {
        if ([[spanNode getAttributeNamed:@"class"] isEqualToString:@"spantext"]) {
            NSLog(@"spantext--: %@", [spanNode rawContents]); //Answer to second question
            NSLog(@"spantext2--: %@",[spanNode rawContents]);
        }
    }
}


-(void)testWebView{
    self.automaticallyAdjustsScrollViewInsets = NO;

    //TFWebView *webView = [[TFWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    TFWebView *webView = [[TFWebView alloc]init];
    webView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);

    [self.view addSubview:webView];
    self.webView = webView;
    webView.backgroundColor = [UIColor cyanColor];

    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.news.4399.com/wzlm/yingxiong/tk/m/728869.html"]]];
}

@end
