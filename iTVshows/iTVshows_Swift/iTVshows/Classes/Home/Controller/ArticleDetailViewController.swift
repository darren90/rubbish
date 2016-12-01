//
//  ArticleDetailViewController.swift
//  iTVshows
//
//  Created by Fengtf on 2016/12/1.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class ArticleDetailViewController: BaseTableViewController {

    var articleId:String?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func request() {
        if articleId == nil {
            return
        }

        ArticleDetailModel.getArticleDetail(id: articleId!){ (model : ArticleDetailModel?, error : NSError?) in

        }

//        ArticleDetailModel.getArticleDetail(id: self.articleId){(list : [ArticleDetailModel]?, error : NSError?) -> () in
//            print("--list-:\(list)")
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
