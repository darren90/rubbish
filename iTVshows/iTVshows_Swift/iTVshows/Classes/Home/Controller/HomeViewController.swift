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

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "首页"
        tableView.rowHeight = 120

        view.backgroundColor = KBgViewColor

        ArticleModel.getArticleList { (list : [ArticleModel]?, error : NSError?) in
//            print("--list-:\(list)")
//             self.dataArray = list
        }

//        ArticleDetailModel.getArticleDetail(id: "29575"){(list : [ArticleDetailModel]?, error : NSError?) -> () in
//            print("--list-:\(list)")
//        }

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
}











