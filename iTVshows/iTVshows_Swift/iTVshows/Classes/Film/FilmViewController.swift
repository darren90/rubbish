//
//  FileViewController.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/29.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class FilmViewController: BaseTableViewController {

    var dataArray:[FilmResModel]?{
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

        title = "Film"
        tableView.rowHeight = 120

        view.backgroundColor = KBgViewColor

       addReFreshControl()
        
        //影视详情
//        FilmResDetailModel.getFilmDetail(id: "26315") { (model : FilmResDetailModel?, error : NSError?) -> () in
//            
//        }

        //下载地址
//        LinkModel.getLink(id: "26315") {(link : LinkModel?, error : NSError?) -> () in
//
//        }
    }
    
    override func request() {
        //影视列表
        FilmResModel.getFilmList(page: 1) {(list : [FilmResModel]?, error : NSError?) -> () in
            print("--list:\(list)")
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: -- tableView代理
extension FilmViewController  {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FilmListCell.cellWithTableView(tableView: tableView)
        let model = dataArray![indexPath.row]
        cell.model = model
        return cell;
    }
}


// MARK: -- 刷新控件相关
extension FilmViewController {
    
    func addReFreshControl() {
        //下拉刷新相关设置
        header.setRefreshingTarget(self, refreshingAction: #selector(FilmViewController.headerRefresh))
        self.tableView!.mj_header = header
        
        footer.setRefreshingTarget(self, refreshingAction: #selector(FilmViewController.footerRefresh))
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










