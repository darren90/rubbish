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
#import "HerosCell.h"
#import "HerosSectionHeaderView.h"
@interface Heros_RootController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *waterView;

@property (nonatomic,strong)NSMutableArray * datas;

@property (nonatomic,assign)int page;
@end

@implementation Heros_RootController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.page = 1;
    self.title = @"英雄大全";
//    self.tableView.rowHeight = 100;
//    
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    [self.tableView.mj_header beginRefreshing];
    
    self.waterView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.waterView.mj_header beginRefreshing];
    [self.waterView registerNib:[UINib nibWithNibName:@"HerosCell" bundle:nil] forCellWithReuseIdentifier:@"HerosCell"];
    [self.waterView registerNib:[UINib nibWithNibName:@"HerosSectionHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HerosSectionHeaderView"];
    
    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout *)self.waterView.collectionViewLayout;
    CGFloat margin = 15;
    CGFloat edge = 20;
    flow.minimumLineSpacing = 8;
    flow.minimumInteritemSpacing = 8;
    CGFloat itemW = (KWidth-2*margin -2*edge)/3.0;
    CGFloat itemH = itemW * 16 / 9.0;
    flow.itemSize = CGSizeMake(itemW, itemH);
    flow.sectionInset = UIEdgeInsetsMake(margin, edge, margin, edge);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.datas.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *arr = self.datas[section];
    return arr.count;
}

//-(UICollectionReusableView *)

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HerosCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HerosCell" forIndexPath:indexPath];
    NSArray *arr = self.datas[indexPath.section];
    cell.model = arr[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        HerosSectionHeaderView *headerView =
        [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                           withReuseIdentifier:@"HerosSectionHeaderView"
                                                  forIndexPath:indexPath];
        NSArray *arr = self.datas[indexPath.section];
        HerosModel *m = arr[indexPath.row];
        headerView.name = m.typeStr;
         return (UICollectionReusableView *)headerView;
    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = self.datas[indexPath.section];
    HerosModel *m = arr[indexPath.row];
    
    HtmlDetailViewController *vc = [[HtmlDetailViewController alloc]init];
    vc.detailUrl = m.url;
    vc.titleStr = m.name;
    vc.adType = Admob_Heros_Bottom;
    [self.navigationController pushViewController:vc animated:YES];
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 40);
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
    [self.waterView.mj_header endRefreshing];
//    [self.waterView.mj_footer endRefreshing];
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
                    [self.datas removeObjectAtIndex:0];
                    [weakSelf.waterView reloadData];
                    
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
