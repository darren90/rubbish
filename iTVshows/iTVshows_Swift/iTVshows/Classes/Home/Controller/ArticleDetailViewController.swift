//
//  ArticleDetailViewController.swift
//  iTVshows
//
//  Created by Fengtf on 2016/12/1.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class ArticleDetailViewController: BaseViewController,UIScrollViewDelegate ,UIWebViewDelegate{

    //MARK: --- 暴露出来的参数
    var articleId:String?


    //MARK: --- 内部要用的参数

    lazy var webView : UIWebView = {
        let webView = UIWebView()
        webView.scrollView.delegate = self
        webView.delegate = self
        webView.scrollView.clipsToBounds = false
        webView.scrollView.showsHorizontalScrollIndicator = true
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.alwaysBounceVertical = true
        webView.scrollView.alwaysBounceHorizontal = false
        webView.backgroundColor = UIColor.white
        webView.scrollView.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0);
        webView.isOpaque = false
        webView.clipsToBounds = true
        return webView
    }()

    var headerView:UIImageView = UIImageView()


    override func viewDidLoad() {
        super.viewDidLoad()

//        navBarView.leftButton.isHidden = false
        webView.frame = view.bounds//CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(webView)//ParallaxHeaderView

        view.addSubview(headerView)
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        headerView.contentMode = .scaleAspectFill
        headerView.image = UIImage(named: "001")
        headerView.clipsToBounds = true
        view.bringSubview(toFront: navBarView)

        view.bringSubview(toFront: navBarView)
        navBarView.alpha = 0
        navTitleStr = "ArticleDetail"
    }

    override func request() {
        if articleId == nil {
            return
        }

        ArticleDetailModel.getArticleDetail(id: articleId!){ (model : ArticleDetailModel?, error : NSError?) in
            if error == nil {
                self.errorType = .None
                self.loadSuccess(model: model!)
            }else{
                self.errorType = .Default
            }

        }
    }

    func loadSuccess(model:ArticleDetailModel)  {
        var html = "<html> <head>"
//        html += "<link rel=\"stylesheet\" href="
//        htm l += cssStr
//        html += "</head>"
        html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />"
        html += model.content ?? ""
        html += "</body> </html>"

        webView.loadHTMLString(html, baseURL: nil)
        navTitleStr = model.title

        let url = URL(string: (model.poster) ?? "")
        if url == nil {
            headerView.image = KPlaceImg
        }else{
            headerView.yy_setImage(with: url, placeholder: KPlaceImg, options:  .setImageWithFadeAnimation, completion: nil)// .progressiveBlur |
        }


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK - webView的代理

    func webViewDidStartLoad(_ webView: UIWebView) {
        print(#function)
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        print(#function)
        self.errorType = .None
    }

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(#function)
        self.errorType = .Default
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offsetY = scrollView.contentOffset.y - ( -200 )
//        print("offsetY:\(offsetY)")
        let h = 200 - offsetY
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: h)

        navBarView.alpha = scrollView.contentOffset.y / (200-64)

    }
}


//extension ArticleDetailModel : UIWebViewDelegate {
//
//
//}



