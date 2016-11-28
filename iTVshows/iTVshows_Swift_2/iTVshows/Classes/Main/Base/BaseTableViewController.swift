//
//  BaseTableViewController.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/21.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class BaseTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    public var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        addTableView()
    }

    func addTableView() {
        tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        self.view .addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }



    func numberOfSections(in tableView: UITableView) -> Int {
        return 0;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView .dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        return cell!;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
