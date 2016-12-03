//
//  ScheduleViewController.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class ScheduleViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource {

//   private var waterView:UICollectionView = {
//    }()
    
    /// 请求的当前页
    var page:Int = 1
    
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    
//    let footer = MJRefreshAutoNormalFooter()

    var watherView:UICollectionView?
    
    var dataArray:[ScheduleModel]? {
        didSet{
//            tableView.reloadData()
            watherView?.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navTitleStr = "Schedule"

        setUpCollectionView()
        addLoadingView()//这个需要手动添加
        
        addReFreshControl()
    }
    
    override func request() {
        //获取数据
        ScheduleModel.getScheduleList(offsetDate: 0) {(list : [ScheduleModel]?, error : NSError? ) -> () in
//            print("list:\(list)")
            self.endRefresh()
            if error == nil {
                self.errorType = .None
                self.dataArray = list
            }else{
                self.errorType = .Default
            }
        }
    }
    
    
    // MARK:-- CollectionView
    func setUpCollectionView() {
        let marign:CGFloat = 10
        let width = (self.view.frame.width - 3 * marign) / 2
        let height:CGFloat = width * 321 / 240
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: marign, left: marign, bottom: marign, right: marign)
        
        watherView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        watherView?.delegate = self
        watherView?.dataSource = self
//        watherView?.contentInset = UIEdgeInsets(top: 0, left: marign, bottom: 10, right: marign)
        watherView?.backgroundColor = KBgViewColor
        watherView?.register(UINib(nibName: "ScheduleListCell", bundle: nil), forCellWithReuseIdentifier: "ScheduleListCell")
        view.addSubview(watherView!)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScheduleListCell", for: indexPath) as! ScheduleListCell
        let model = dataArray![indexPath.item]
        cell.model = model
        return cell
    }

}

// MARK: -- 网络请求 extension OAuthViewController : UIWebViewDelegate
//extension ScheduleViewController : UICollectionViewDelegate,UICollectionViewDataSource {
//    
//   }



extension ScheduleViewController {
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1;
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dataArray?.count ?? 0;
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableView .dequeueReusableCell(withIdentifier: "cell")
//        if cell == nil {
//            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
//        }
//        let model = dataArray![indexPath.row]
//        cell?.textLabel?.text = "cell-:\(model.cnname!)"
//        return cell!;
//    }

}


// MARK: -- 刷新控件相关
extension ScheduleViewController {
    
    func addReFreshControl() {
        //下拉刷新相关设置
        header.setRefreshingTarget(self, refreshingAction: #selector(ScheduleViewController.headerRefresh))
        self.watherView!.mj_header = header
        
//        footer.setRefreshingTarget(self, refreshingAction: #selector(ScheduleViewController.footerRefresh))
//        self.tableView!.mj_footer = footer
    }
    
    //顶部下拉刷新
    func footerRefresh(){
        page = page + 1
        request()
    }
    
    //顶部下拉刷新
    func headerRefresh(){
        page = 1
        request()
    }
    
    func endRefresh() {
        //结束刷新
//        self.watherView!.mj_footer.endRefreshing()
        //结束刷新
        self.watherView!.mj_header.endRefreshing()
    }
}











