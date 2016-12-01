//
//  HomeViewController.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/21.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class HomeViewController: BaseTableViewController {

    var dataArray:[ArticleModel]?{
        didSet{
            tableView.reloadData()
        }
    }

    /// 请求的当前页
    var page:Int = 1
    
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    
    let footer = MJRefreshAutoNormalFooter()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        launchAnimation()

//        Thread.sleep(forTimeInterval: 3.0) //延长程序启动时间为：3秒
        
        title = "首页"
        tableView.rowHeight = 120

        view.backgroundColor = KBgViewColor

        addReFreshControl()

    }

    
    
    override func request() {
        ArticleModel.getArticleList(page: page) { (list : [ArticleModel]?, error : NSError?) in
            //            print("--list-:\(list)")
            self.endRefresh()
            if error == nil {
                self.errorType = .None
                if(self.page == 1){
                    self.dataArray = list
                     print("-1-arrcount:\(self.dataArray?.count)")
                }else{
                    var tempArr = self.dataArray
                    for m in list! {
                        tempArr?.append(m)
                    }
                    self.dataArray = tempArr
                    print("-2-arrcount:\(self.dataArray?.count)")
                }
            }else{
                self.errorType = .Default
            }
        }
    }
}

// MARK: -- 刷新控件相关
extension HomeViewController {
    
    func addReFreshControl() {
        //下拉刷新相关设置
        header.setRefreshingTarget(self, refreshingAction: #selector(HomeViewController.headerRefresh))
        self.tableView!.mj_header = header
        
        footer.setRefreshingTarget(self, refreshingAction: #selector(HomeViewController.footerRefresh))
        self.tableView!.mj_footer = footer
    }
    
    //顶部下拉刷新
    func footerRefresh(){
        page = page + 1
        request()
    }
    
    //顶部下拉刷新
    func headerRefresh(){
        page = 1
        request()
    }
    
    func endRefresh() {
        //结束刷新
        self.tableView!.mj_footer.endRefreshing()
        //结束刷新
        self.tableView!.mj_header.endRefreshing()
    }
}

//extension TableViewViewController: UITableViewDelegate,UITableViewDataSource

// MARK: -- tableView代理
extension HomeViewController  {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ArticleListCell.cellWithTableView(tableView: tableView)
        let model = dataArray![indexPath.row]
        cell.model = model
        return cell;
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVc = ArticleDetailViewController()
        let model = dataArray![indexPath.row]
        detailVc.articleId = model.id
        navigationController?.pushViewController(detailVc, animated: true)
    }

}


extension HomeViewController {
    //播放启动画面动画
    func launchAnimation() {
        //获取启动视图
        let vc = UIStoryboard(name: "LaunchScreen", bundle: nil)
            .instantiateViewController(withIdentifier: "launch")
        let launchview = vc.view!
        let delegate = UIApplication.shared.delegate
        delegate?.window!!.addSubview(launchview)
        //self.view.addSubview(launchview) //如果没有导航栏，直接添加到当前的view即可
        
        //播放动画效果，完毕后将其移除
        UIView.animate(withDuration: 1, delay: 1.5, options: .beginFromCurrentState,
                       animations: {
                        launchview.alpha = 0.0
                        let transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1.0)
                        launchview.layer.transform = transform
        }) { (finished) in
            launchview.removeFromSuperview()
        }
    }
}








