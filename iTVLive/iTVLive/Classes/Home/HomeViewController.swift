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

        navBarView.leftButton.isHidden = true
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
        let model = datas?[indexPath.row]
        if model?.isAdmob == true {
            let cell = AdmobCell.cellWithTableView(tableView: tableView)
            cell.rootVc = self
            return cell;
        }
        
        let cell = HomeCell.cellWithTableView(tableView: tableView)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = datas?[indexPath.row]
        if model?.isAdmob == true {
            return 50
        }else{
            return 100
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = datas?[indexPath.row]
        if model?.isAdmob == true {
            return
        }
    
        if model?.modelType != .YES {
            self.view.makeToast("暂无节目，请稍后重试", duration: 1.5, position: .center)
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        
        let detailVc = DetailViewController()
        detailVc.channelId = model?.channelId
        detailVc.titleStr = model?.t
        navigationController?.pushViewController(detailVc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}






















