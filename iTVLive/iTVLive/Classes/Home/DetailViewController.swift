//
//  DetailViewController.swift
//  iTVLive
//
//  Created by Fengtf on 2017/3/6.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class DetailViewController: BaseTableViewController {

    var datas:[TVDetailModel]?{
        didSet{
            tableView.reloadData()
        }
    }


    var channelId:String?


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.frame = CGRect(x: 0, y: 64, width: view.width, height: view.height-64-49)
        navTitleStr = "节目"
        tableView.rowHeight = 50

        TVDetailModel.getDetailShowList(channelId: channelId ?? "") { (lists , error) in
            if error == nil{
                self.errorType = .None
                self.datas = lists
            }else{
                self.errorType = .Default
            }
        }

    }
}



extension DetailViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DetailListCell.cellWithTableView(tableView: tableView)
        let model = datas?[indexPath.row]
        cell.model = model
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
}

