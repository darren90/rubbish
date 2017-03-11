//
//  ChannelListViewController.swift
//  iTVLive
//
//  Created by Tengfei on 2017/3/11.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit


class ChannelListViewController: BaseTableViewController {
    
    var channenlUrl:String?
    var titleStr:String?{
        didSet{
            navTitleStr = titleStr
        }
    }
    
    var datas:[TVListModel]?{
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self.view)
            make.top.equalTo(self.view.top).offset(64)
        }
        tableView.rowHeight = 100
        
        TVListModel.getTVChannelList(url: channenlUrl) {(lists, error) in
            if error == nil{
                self.errorType = .None
                self.datas = lists
            }else{
                self.errorType = .Default
            }
        }
    }
}


extension ChannelListViewController {
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
        let model = datas?[indexPath.row]
        
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
