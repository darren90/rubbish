//
//  HomeViewController.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/21.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class HomeViewController: BaseTableViewController {

    var dataArray:[ArticleModel]?{
        didSet{
            tableView.reloadData()
        }
    }

    /// 请求的当前页
    var page:Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        launchAnimation()
        
        title = "首页"
        tableView.rowHeight = 120

        view.backgroundColor = KBgViewColor
 

//        ArticleDetailModel.getArticleDetail(id: "29575"){(list : [ArticleDetailModel]?, error : NSError?) -> () in
//            print("--list-:\(list)")
//        }

    }

    
    
    override func request() {
        ArticleModel.getArticleList { (list : [ArticleModel]?, error : NSError?) in
            //            print("--list-:\(list)")
            if error == nil {
                self.errorType = .None
                self.dataArray = list
            }else{
                self.errorType = .Default
            }
        }
    }
    
}

//extension TableViewViewController: UITableViewDelegate,UITableViewDataSource

// MARK: -- tableView代理
extension HomeViewController  {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ArticleListCell.cellWithTableView(tableView: tableView)
        let model = dataArray![indexPath.row]
        cell.model = model
        return cell;
    }
}


extension HomeViewController {
    //播放启动画面动画
    func launchAnimation() {
        //获取启动视图
        let vc = UIStoryboard(name: "LaunchScreen", bundle: nil)
            .instantiateViewController(withIdentifier: "launch")
        let launchview = vc.view!
        let delegate = UIApplication.shared.delegate
        delegate?.window!!.addSubview(launchview)
        //self.view.addSubview(launchview) //如果没有导航栏，直接添加到当前的view即可
        
        //播放动画效果，完毕后将其移除
        UIView.animate(withDuration: 1, delay: 1.5, options: .beginFromCurrentState,
                       animations: {
                        launchview.alpha = 0.0
                        let transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1.0)
                        launchview.layer.transform = transform
        }) { (finished) in
            launchview.removeFromSuperview()
        }
    }
}








