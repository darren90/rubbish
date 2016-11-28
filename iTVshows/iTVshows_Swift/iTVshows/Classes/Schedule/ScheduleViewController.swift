//
//  ScheduleViewController.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        title = "Schedule"

        APINetTools.GET_TV(url: "http://api.ousns.net/tv/schedule?end=20161128&start=20161128", params: nil, success: {(json) -> Void in
            print("-----json:\(json)--")
        }){(error) -> Void in
            print("-----error:\(error)-")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
