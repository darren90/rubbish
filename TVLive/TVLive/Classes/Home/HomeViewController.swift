//
//  HomeViewController.swift
//  TVLive
//
//  Created by Tengfei on 2017/3/4.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class HomeViewController: BaseTableViewController {
    
    let datas = TVLiveTools.getData()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.errorType = .None
        navTitleStr = "节目"
        
//        print(datas)
        RMDBTools.shareInstance.addData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    lazy var dataArray:

}


extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HomeCell.cellWithTableView(tableView: tableView)
        let model = datas[indexPath.row]
        cell.textLabel?.text = model.tvName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playVc = TFMoviePlayerViewController()
        let model = datas[indexPath.row]
        playVc.playUrl = model.tvPlayUrlStr
        playVc.titleStr = model.tvName
        navigationController?.present(playVc, animated: true, completion: nil)
    }
    
}






















