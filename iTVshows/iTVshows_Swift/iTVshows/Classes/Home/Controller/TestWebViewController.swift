//
//  TestWebViewController.swift
//  01_ProjectBase
//
//  Created by Fengtf on 2016/12/3.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class TestWebViewController: BaseViewController {

    var webView:UIWebView = UIWebView()

    var headerView:UIImageView = UIImageView()


    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navBarView.leftButton.isHidden = false


        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(webView)
        webView.scrollView.delegate = self
        webView.delegate = self
        webView.scrollView.showsHorizontalScrollIndicator = true
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.alwaysBounceVertical = true
        webView.scrollView.alwaysBounceHorizontal = false
        webView.frame = view.bounds//CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        webView.backgroundColor = UIColor.white
        webView.isOpaque = false
        webView.scrollView.contentInset = UIEdgeInsets(top: 160, left: 0, bottom: 0, right: 0);
        let url = URL(string: "http://www.cnblogs.com/fengtengfei/")!
        let request = URLRequest(url: url)
        webView.loadRequest(request)

        webView.clipsToBounds = true
        view.addSubview(headerView)
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 160)
        //        headerView.backgroundColor = UIColor.brown
        headerView.contentMode = .scaleAspectFill
        headerView.image = UIImage(named: "001")
        headerView.clipsToBounds = true
        view.bringSubview(toFront: navBarView)
        navBarView.alpha = 0
        navTitleStr = "WEBVieDetail"
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension TestWebViewController : UIWebViewDelegate,UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offsetY = scrollView.contentOffset.y - ( -160 )
        print("offsetY:\(offsetY)")
        let h = 160 - offsetY
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: h)

        navBarView.alpha = scrollView.contentOffset.y / (160-64)
        if scrollView.contentOffset.y == 160 {
        }
    }
    
}

