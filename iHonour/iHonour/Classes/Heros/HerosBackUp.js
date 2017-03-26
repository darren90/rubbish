//
//  Heros_RootController.m
//  iHonour
//
//  Created by Tengfei on 2017/3/25.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "Heros_RootController.h"
#import "NewsModel.h"
#import "NewsCell.h"
#import "HtmlDetailViewController.h"
#import "HerosModel.h"

@interface Heros_RootController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak)UITableView * tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *waterView;

@property (nonatomic,strong)NSMutableArray * datas;

@property (nonatomic,assign)int page;
@end

@implementation Heros_RootController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableview];
    
    self.page = 1;
    self.title = @"英雄大全";
    self.tableView.rowHeight = 100;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    //    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
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
        result = @"http://m.news.4399.com/gonglue/wzlm/yingxiong/";
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
                                  
                                  TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:data encoding:@"gbk"];
                                  //            NSString *strs = [[NSString alloc] initWithData:xpathParser.data encoding:NSASCIIStringEncoding];
                                  
                                  NSArray *elements = [xpathParser searchWithXPathQuery:@"//ul[@class='plist2 cf ulList']"];
                                  if (elements.count > 0){
                                  if (self.page == 1) {
                                  [weakSelf.datas removeAllObjects];
                                  }
                                  NSArray *catNames = @[@"全部",@"坦克",@"战士",@"刺客",@"法师",@"射手",@"辅助"];
                                  int index = 0;
                                  //大类英雄
                                  for (TFHppleElement *ul in elements) {
                                  NSMutableArray *cats = [NSMutableArray array];
                                  NSString *cate = @"未知";
                                  if (index < catNames.count) {
                                  cate = catNames[index];
                                  }
                                  index++;
                                  
                                  //find title
                                  NSArray *lis = [ul childrenWithTagName:@"li"];
                                  
                                  for (TFHppleElement *li in lis) {
                                  NSDictionary *dd = [NSDictionary dictionaryWithXMLString:li.raw];
                                  NSDictionary *ad = dd[@"a"];
                                  //                        NSLog(@"%@",ad);
                                  NSString *name = ad[@"__text"];
                                  
                                  NSString *url = ad[@"_href"];
                                  NSString *imgUrl = ad[@"img"][@"_src"];
                                  if (imgUrl == nil) {
                                  imgUrl = ad[@"img"][@"_lz_src"];
                                  }
                                  
                                  HerosModel *m = [HerosModel modelWith:name url:url imgUrl:imgUrl type:cate];
                                  [cats addObject:m];
                                  }
                                  
                                  [weakSelf.datas addObject:cats];
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
