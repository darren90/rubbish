//
//  Cheats_RootController.m
//  iHonour
//
//  Created by Tengfei on 2017/3/25.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "Cheats_RootController.h"
#import "NewsModel.h"
#import "NewsCell.h"
#import "HtmlDetailViewController.h"

@interface Cheats_RootController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak)UITableView * tableView;

@property (nonatomic,strong)NSMutableArray * datas;

@property (nonatomic,assign)int page;
@end

@implementation Cheats_RootController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableview];
    
    self.page = 1;
    self.title = @"攻略秘籍";
    self.tableView.rowHeight = 100;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.tableView.mj_header beginRefreshing];
    
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
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell *cell = [NewsCell cellWithTableview:tableView];
    NewsModel *m = self.datas[indexPath.row];
    cell.model = m;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *m = self.datas[indexPath.row];
    
    HtmlDetailViewController *vc = [[HtmlDetailViewController alloc]init];
    vc.detailUrl = m.url;
    vc.titleStr = m.title;
    vc.adType = Admob_Cheats_Bottom;
    [self.navigationController pushViewController:vc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    NSString *result = [NSString stringWithFormat:@"http://www.anqu.com/yxzji/gonglue/list_10169_%d.shtml",self.page];
    if (self.page == 1) {
        result = @"http://www.anqu.com/yxzji/gonglue/index.shtml";
    }
    NSLog(@"load-攻略-Url: %@",result);
    return result;
}

- (void)loadData{
    NSString *url = [self requestUrl];
    NSURL *uurl = [NSURL URLWithString:url];
    
    __weak __typeof(self) weakSelf = self;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:uurl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:120.0];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            
            TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:data encoding:@"utf-8"];
//            NSString *strs = [[NSString alloc] initWithData:xpathParser.data encoding:NSASCIIStringEncoding];
            
            NSArray *elements = [xpathParser searchWithXPathQuery:@"//div[@class='liebiao']//ul/*"];
            if (elements.count > 0){
                if (self.page == 1) {
                    [weakSelf.datas removeAllObjects];
                }
                
                for (TFHppleElement *li in elements) {
                    //find title
                    NSArray *tags = [li childrenWithTagName:@"div"];
                    TFHppleElement *element = tags.firstObject;
                    NSDictionary *dd = [NSDictionary dictionaryWithXMLString:element.raw];
                    NSDictionary *ad = dd[@"a"];
                    
                    NSString *href = ad[@"_href"];
//                    NSString *hreff = [NSString stringWithFormat:@"%@%@",@"http://m.news.4399.com",href];
                    NSString *src = ad[@"img"][@"_src"];
                    NSString *title = ad[@"_title"];
                    NSLog(@"title: %@,href:%@,src:%@",title,href,src);
                    NSLog(@"--数据解析成功-:%d",self.page);
                    NewsModel *m = [NewsModel modelWith:title url:href imgUrl:src];
                    
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
