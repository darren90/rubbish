//
//  MeViewController.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/21.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class MeViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navBarView.leftButton.isHidden = true
        navTitleStr = "我的"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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