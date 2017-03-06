//
//  HomeViewController.swift
//  TVLive
//
//  Created by Tengfei on 2017/3/4.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class HomeViewController: BaseTableViewController {
    
    var datas:[TVListModel]?{
        didSet{
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()


        tableView.frame = CGRect(x: 0, y: 64, width: view.width, height: view.height-64-49)
        navTitleStr = "节目"
        tableView.rowHeight = 100
        
        TVListModel.getTVList { (lists, error) in
            if error == nil{
                 self.errorType = .None
                self.datas = lists
            }else{
                 self.errorType = .Default
            }
        }
    }

}


extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HomeCell.cellWithTableView(tableView: tableView)
        let model = datas?[indexPath.row]
        if model?.modelType == .NotLoading{
            TVListModel.getTVLiveNow(liveModel: model!,indexPath:indexPath, finish: { (nowModel, error) in
//                if error == nil {
                    self.tableView.reloadRow(at: indexPath, with: .automatic)
//                }
             })
        }
        cell.model = model
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVc = DetailViewController()
        let model = datas?[indexPath.row]
        detailVc.channelId = model?.channelId
        navigationController?.pushViewController(detailVc, animated: true)
    }
    
}






















