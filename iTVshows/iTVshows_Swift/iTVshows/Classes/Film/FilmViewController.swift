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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Film"
        tableView.rowHeight = 120

        view.backgroundColor = KBgViewColor

        //影视列表
        FilmResModel.getFilmList(page: 1) {(list : [FilmResModel]?, error : NSError?) -> () in
            print("--list:\(list)")
            self.dataArray = list
        }

        //影视详情
//        FilmResDetailModel.getFilmDetail(id: "26315") { (model : FilmResDetailModel?, error : NSError?) -> () in
//            
//        }

        //下载地址
//        LinkModel.getLink(id: "26315") {(link : LinkModel?, error : NSError?) -> () in
//
//        }
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("---tableView")
    }
}













