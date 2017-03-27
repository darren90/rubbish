//
//  News_RootController.m
//  iHonour
//
//  Created by Tengfei on 2017/3/25.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "News_RootController.h"
#import "TFWebView.h"
#import "NewsModel.h"
#import "NewsCell.h"
#import "HtmlDetailViewController.h"
#import "AdmobCell.h"

@interface News_RootController ()<WKNavigationDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) TFWebView *webView;

//@property (nonatomic,weak)UITableView * tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSMutableArray * datas;

@property (nonatomic,assign)int page;
@end

@implementation News_RootController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self initTableview];
    
    self.page = 1;
    self.title = @"游戏资讯";
    self.tableView.rowHeight = 100;
 
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.tableView.mj_header beginRefreshing];
    
//    [self testWebView];
//    [self testHonour];
}

-(void)initTableview
{
    UITableView *tableView = [[UITableView alloc]init];
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
//    tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *m = self.datas[indexPath.row];
    
    if (m.isAdmob) {
        AdmobCell *adCell = [AdmobCell cellWithTableview:tableView];
        adCell.adUnitID = kGoogleAdmobNews_Cell_01;
        adCell.bannerView.rootViewController = self;
        return adCell;
    }
    
    NewsCell *cell = [NewsCell cellWithTableview:tableView];
    cell.model = m;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *m = self.datas[indexPath.row];
    if (m.isAdmob) {
        return;
    }
    
    HtmlDetailViewController *vc = [[HtmlDetailViewController alloc]init];
    vc.detailUrl = m.url;
    vc.titleStr = m.title;
    vc.adType = Admob_News_Bottom;
    [self.navigationController pushViewController:vc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *m = self.datas[indexPath.row];
    if (m.isAdmob) {
        return 50;
    }
    return 100;
}

-(void)loadNewData{
    self.page = 1;
    [self loadData];
}

-(void)loadMoreData{
    self.page ++;
    [self loadData];
}

-(void)stopRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

-(NSString *)requestUrl{
    NSString *result = [NSString stringWithFormat:@"http://news.4399.com/gonglue/wzlm/zixun/44038-%d.html",self.page];
    if (self.page == 1) {
        result = @"http://news.4399.com/gonglue/wzlm/zixun/";
    }
    NSLog(@"load-Url:%@",result);
    return result;
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


- (void)loadData{
    NSString *url = [self requestUrl];
    NSURL *uurl = [NSURL URLWithString:url];
 
    __weak __typeof(self) weakSelf = self;

    NSURLRequest *request = [NSURLRequest requestWithURL:uurl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:120.0];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
 
            TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:data encoding:@"gbk"];
//            NSString *strs = [[NSString alloc] initWithData:xpathParser.data encoding:NSASCIIStringEncoding];

            NSArray *elements = [xpathParser searchWithXPathQuery:@"//ul[@class='txt-list cf']/*"];
            if (elements.count > 0){
                if (self.page == 1) {
                    [weakSelf.datas removeAllObjects];
                }
                
                int admobIndex = 0;
                for (TFHppleElement *li in elements) {
                    //find title
                    NSArray *tags = [li childrenWithTagName:@"div"];
                    TFHppleElement *element = tags.lastObject;
                    NSDictionary *dd = [NSDictionary dictionaryWithXMLString:element.raw];
                    NSDictionary *ad = dd[@"a"];
                    
                    NSString *href = ad[@"_href"];
                    NSString *hreff = [NSString stringWithFormat:@"%@%@",@"http://m.news.4399.com",href];
                    NSString *src = ad[@"img"][@"_src"];
                    NSString *titles = ad[@"img"][@"_alt"];
//                    NSLog(@"title: %@,href:%@,src:%@",titles,hreff,src);
                    NSLog(@"--数据解析成功-:%d",self.page);
                    NewsModel *m = [NewsModel modelWith:titles url:hreff imgUrl:src];
                    
                    if (admobIndex == 8) {
                        NewsModel *adM = [[NewsModel alloc]init];
                        adM.isAdmob = YES;
                        [self.datas addObject:adM];
                    }
                    admobIndex ++;

                    [weakSelf.datas addObject:m];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf stopRefresh];
                    [weakSelf.tableView reloadData];
                    
                });
            }
            
        }else{//下载失败
            [weakSelf stopRefresh];
            NSLog(@"---:网页下载失败：%@",error);
        }
    }];
    
    [task resume];
}

-(NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}


@end
