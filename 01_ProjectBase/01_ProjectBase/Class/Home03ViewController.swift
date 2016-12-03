//
//  Home03ViewController.swift
//  01_ProjectBase
//
//  Created by Tengfei on 2016/12/1.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class Home03ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.

        navTitleStr = "Home03"

        rightTitle = "PushWebView"
    }

    override func rightBtnClick() {
        let vc = TestWebViewController()
        navigationController?.pushViewController(vc, animated: true)
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
