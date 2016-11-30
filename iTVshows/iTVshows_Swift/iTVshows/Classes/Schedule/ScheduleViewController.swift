//
//  ScheduleViewController.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class ScheduleViewController: BaseTableViewController {

    var dataArray:[ScheduleModel]? {
        didSet{
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Schedule"


        //获取数据
        ScheduleModel.getScheduleList(offsetDate: 0) {(list : [ScheduleModel]?, error : NSError? ) -> () in
            print("list:\(list)")
            self.dataArray = list
        }
    }


}

extension ScheduleViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView .dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        let model = dataArray![indexPath.row]
        cell?.textLabel?.text = "cell-:\(model.cnname!)"
        return cell!;
    }

}









