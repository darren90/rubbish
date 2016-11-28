//
//  HomeViewController.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/21.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class HomeViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "首页"
        // Do any additional setup after loading the view.


//        http://106.75.11.245:10088/constant/category/sdfsdf
//        APINetTools.GET_TV(url: "http://api.ousns.net/tv/schedule?end=20161128&start=20161128", params: nil, success: {(json) -> Void in
//            print("-----json:\(json)--")
//        }){(error) -> Void in
//            print("-----error:\(error)-")
//        }


//        NSString *m55 = [@"11$$f1a1a3a891ccdcfd08038c8678dcab53&&1480326828" MD5];
    }




    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView .dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "cell-:\(indexPath.row)"
        return cell!;
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
