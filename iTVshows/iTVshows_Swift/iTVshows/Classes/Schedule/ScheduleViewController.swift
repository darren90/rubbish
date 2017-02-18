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
    
//  let footer = MJRefreshAutoNormalFooter()

    var watherView:UICollectionView?

    lazy var dateBtn:UIButton = UIButton()
    
    var dataArray:[ScheduleModel]? {
        didSet{
//            tableView.reloadData()
            watherView?.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navBarView.leftButton.isHidden = true
        navTitleStr = ""

        setUpCollectionView()
        addLoadingView()//这个需要手动添加
        
        addReFreshControl()
    }
    
    override func request() {
        getDatas(date: Date())
    }

    func getDatas(date:Date){
//        self.watherView!.mj_header.beginRefreshing()
        //获取数据
        ScheduleModel.getScheduleList(date: date) {(list : [ScheduleModel]?, error : NSError? ) -> () in
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
        let edgeMargin:CGFloat = 20;
        let width = (self.view.frame.width -  marign - 2*edgeMargin) / 2
        let height:CGFloat = width * 321 / 240
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: marign, left: edgeMargin, bottom: marign+49, right: edgeMargin)

        let rect = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height - 64)
        watherView = UICollectionView(frame: rect, collectionViewLayout: layout)
        watherView?.delegate = self
        watherView?.dataSource = self
        watherView?.backgroundColor = KBgViewColor
        watherView?.register(UINib(nibName: "ScheduleListCell", bundle: nil), forCellWithReuseIdentifier: "ScheduleListCell")
        view.addSubview(watherView!)


        navBarView.navTitle.isUserInteractionEnabled = true
        navBarView.navTitle.addSubview(dateBtn)
        dateBtn.setTitleColor(UIColor.black, for: .normal)
        dateBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        dateBtn.addTarget(self, action: #selector(self.datePickAction), for: .touchUpInside)
//        dateBtn.frame = navBarView.navTitle.bounds
//        let normal = UIColor.createImageWithColor(KCommonColor)
//        dateBtn .setBackgroundImage(normal, for: .normal)
        dateBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
        dateBtn.layer.shadowColor = UIColor.black.cgColor
        dateBtn.layer.cornerRadius = 8
        dateBtn.layer.shadowOpacity = 0.8
//        dateBtn.clipsToBounds = true
//        dateBtn.frame.size = CGSize(width: 100, height: 44);
//        dateBtn.center = navBarView.center
        dateBtn.frame = CGRect(x: (navBarView.navTitle.frame.width-100)/2, y: 2, width: 100, height: 35)
        dateBtn.backgroundColor = KCommonColor
        

        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY/MM/dd"
        let selectDateStr = formatter.string(from: Date())
        dateBtn.setTitle(selectDateStr, for: .normal)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FilmDetailViewController") as! FilmDetailViewController
        let model = dataArray![indexPath.row]
        detailVc.filmId = model.id
        navigationController?.pushViewController(detailVc, animated: true)
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



    func datePickAction() {
        let current = Date()
        let min = Date().addingTimeInterval(-60 * 60 * 24 * 15)
        let max = Date().addingTimeInterval(60 * 60 * 24 * 15)
        let picker = DateTimePicker.show(selected: current, minimumDate: min, maximumDate: max)
        picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.doneButtonTitle = "!! DONE DONE !!"
        picker.todayButtonTitle = "Today"
        picker.completionHandler = { date in
//            self.current = date

            //刷新数据
            self.getDatas(date: date)

            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY/MM/dd" //"HH:mm dd/MM/YYYY"
            let selectDateStr = formatter.string(from: date)
            print("selct date :\(selectDateStr)")
            self.dateBtn.setTitle(selectDateStr, for: .normal)
        }

    }

}











