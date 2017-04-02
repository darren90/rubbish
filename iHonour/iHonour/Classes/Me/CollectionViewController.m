//
//  CollectionViewController.m
//  iHonour
//
//  Created by Tengfei on 2017/3/29.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "CollectionViewController.h"
#import "NewsModel.h"
#import "NewsCell.h"
#import "HtmlDetailViewController.h"
#import "AdmobCell.h"
#import "RMListModel.h"

@interface CollectionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak)UITableView * tableView;

@property (nonatomic,strong)NSMutableArray * datas;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableview];
    [self startAnimate];
    
    self.title = @"我的收藏";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.rowHeight = 100;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(delItem)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(request)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.tableFooterView = [UIView new];
}


-(void)initTableview
{
    UITableView *tableView = [[UITableView alloc]init];
    [self.view addSubview:tableView];
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    RMListModel *m = self.datas[indexPath.row];
    
    NewsCell *cell = [NewsCell cellWithTableview:tableView];
    cell.model = [self getNesModel:m];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RMListModel *model = self.datas[indexPath.row];
    NewsModel *m = [self getNesModel:model];
    
    HtmlDetailViewController *vc = [[HtmlDetailViewController alloc]init];
    vc.detailUrl = m.url;
    vc.titleStr = m.title;
    vc.adType = Admob_Cheats_Bottom;
    vc.newsModel = m;
    vc.listType = RMListCheats;
    [self.navigationController pushViewController:vc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    return 100;
}

#pragma mark --- 删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        RMListModel *mdoel = self.datas[indexPath.row];
        [[RMLTools shareTools] delCollect:mdoel];
        [self.datas removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
 
        if (self.datas.count == 0) {
            self.requestState = RequestStateNoData;
        }
    }
}

-(void)request{
    NSArray *arr = [[RMLTools shareTools] getAll];
    [self.datas removeAllObjects];
    [self.datas addObjectsFromArray:arr];
    [self.tableView reloadData];
    [self stopRefresh];
    
    if (self.datas.count == 0) {
        self.requestState = RequestStateNoData;
    }else{
        self.requestState = RequestStateNone;
    }
}

-(void)delItem{
    if (self.tableView.isEditing) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(delItem)];
    }else{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(delItem)];
    }
    
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
}

-(void)stopRefresh{
    [self.tableView.mj_header endRefreshing];
}

-(NewsModel *)getNesModel:(RMListModel *)newsModel{
    NewsModel *m = [[NewsModel alloc]init];
    m.title = newsModel.title;
    m.url = newsModel.url;
    m.imgUrl = newsModel.imgUrl;
    return m;
}

-(NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}


@end
