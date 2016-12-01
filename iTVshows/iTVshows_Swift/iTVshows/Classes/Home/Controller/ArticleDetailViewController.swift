//
//  ArticleDetailViewController.swift
//  iTVshows
//
//  Created by Fengtf on 2016/12/1.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class ArticleDetailViewController: BaseTableViewController {

    //MARK: --- 暴露出来的参数
    var articleId:String?


    //MARK: --- 内部要用的参数

    lazy var webView : UIWebView = {
        let webView = UIWebView()
        webView.scrollView.delegate = self
        webView.scrollView.clipsToBounds = false
        webView.scrollView.showsHorizontalScrollIndicator = true
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.alwaysBounceVertical = true
        webView.scrollView.alwaysBounceHorizontal = false
        return webView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()


        view.addSubview(webView)//ParallaxHeaderView
    }

    override func request() {
        if articleId == nil {
            return
        }

        ArticleDetailModel.getArticleDetail(id: articleId!){ (model : ArticleDetailModel?, error : NSError?) in

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ArticleDetailModel : UIWebViewDelegate {
    //MARK - webView的代理
    func webViewDidStartLoad(_ webView: UIWebView) {
        print(#function)
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        print(#function)
    }

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(#function)
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        print("offsetY:\(offsetY)")
    }

}



