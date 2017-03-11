//
//  AllChannelViewController.swift
//  TVLive
//
//  Created by Tengfei on 2017/3/4.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class AllChannelViewController: BaseViewController {

    var datas = { () -> [ChannelModel] in 
  
//        let m1 = ChannelModel(imageName: "box_favourite_normal", title: "热播" )
        let m2 = ChannelModel(imageName: "box_special_normal", title: "综艺", channenlUrl:ApiTools.URL_ZHONGYO)
        let m3 = ChannelModel(imageName: "box_yangshi_normal", title: "央视", channenlUrl:ApiTools.URL_YS)
        let m4 = ChannelModel(imageName: "box_weishi_normal", title: "卫视", channenlUrl:ApiTools.URL_WS_OK)
        let m5 = ChannelModel(imageName: "box_news_dongman", title: "动漫", channenlUrl:ApiTools.URL_DONGMAN)
        let m6 = ChannelModel(imageName: "box_movie_normal", title: "影视", channenlUrl:ApiTools.URL_WS_OK)
        let m7 = ChannelModel(imageName: "box_conties_normal", title: "地方", channenlUrl:ApiTools.URL_DIFANG_OK)
        let m8 = ChannelModel(imageName: "box_news_panda", title: "熊猫", channenlUrl:ApiTools.URL_PANDA)
//        let m9 = ChannelModel(imageName: "box_game_normal", title: "游戏")
        let m10 = ChannelModel(imageName: "box_news_normal", title: "资讯", channenlUrl:ApiTools.URL_ZIXUN)
//        let m11 = ChannelModel(imageName: "box_hd_normal", title: "高清")
        let m12 = ChannelModel(imageName: "box_caijing_normal", title: "财经", channenlUrl:ApiTools.URL_CAIJING)
        
        let arr = [m2,m3,m4,m5,m6,m7,m8,m10,m12]
        return arr
    }()
    
    var waterView : UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.errorType = .None
        navTitleStr = "频道大全"
        
        navBarView.leftButton.isHidden = true
        view.addSubview(waterView)
        waterView.frame = CGRect(x: 0, y: 64, width: view.width, height: view.height - 64)
        waterView.delegate = self
        waterView.dataSource = self
        waterView.reloadData()
        waterView.backgroundColor = UIColor.white
        waterView.register(UINib(nibName: "ChannelViewCell", bundle: nil), forCellWithReuseIdentifier: "ChannelViewCell")
        waterView.alwaysBounceVertical = true
        
        let layout = waterView.collectionViewLayout as! UICollectionViewFlowLayout
        waterView.bounces = true
        let margin:CGFloat = 15.0
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        let row:CGFloat = 3
        layout.itemSize = CGSize(width: (KWidth - (row+1)*margin) / row, height: (KWidth - (row+1)*10.0) / row)
        layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin)
    }
 
}

extension AllChannelViewController : UICollectionViewDataSource,UICollectionViewDelegate,ChannelViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChannelViewCell", for: indexPath) as! ChannelViewCell
        let model = datas[indexPath.row]
        cell.model = model
        cell.deledate = self
        return cell
    }
    
    func cellDidClick(model: ChannelModel) {
//        print("---")
        let detailVc = ChannelListViewController()
        detailVc.channenlUrl = model.channenlUrl
        detailVc.titleStr = model.title
        navigationController?.pushViewController(detailVc, animated: true)
    }
  
}











