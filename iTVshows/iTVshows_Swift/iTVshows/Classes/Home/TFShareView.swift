//
//  TFShareView.swift
//  iTVshows
//
//  Created by Fengtf on 2016/12/6.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class TFShareView: UIView , UICollectionViewDelegate,UICollectionViewDataSource   {

    //外部参数
    fileprivate var shareContent:String!
    fileprivate var shareImage:UIImage!
    fileprivate var shareUrl:String!
    fileprivate var shareTitle:String!

    fileprivate var contentHeight:CGFloat = 220
    var dataArray = [ShareModel]()


    var containView:UICollectionView?

    fileprivate var bgView:UIView!
    fileprivate var contentView:UIView!
//    fileprivate var scrollView:UIScrollView!
//    fileprivate var pageControl:UIPageControl!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.bgView = UIView.init(frame: self.bounds)
        self.bgView.backgroundColor = UIColor.black
        self.bgView.alpha = 0.0
        self.addSubview(self.bgView)

        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.bgViewTapped))
        self.bgView.addGestureRecognizer(tapGesture)

        self.contentView = UIView.init(frame: CGRect(x: 0, y: frame.height, width: frame.width, height: contentHeight))
        self.contentView.backgroundColor = UIColor.groupTableViewBackground
        self.addSubview(self.contentView)

        let sharePaltformArray = [
            [ "share_weixin", "share_friend", "share_sina" , "share_qq", "share_zone"],
            [ "微信","朋友圈", "微博", "QQ", "QQ空间"]
        ]


        // 1 - add CancleBtn
        let cancelBtn = UIButton(type:.custom)
        cancelBtn.frame = CGRect(x: 0, y: self.contentView.frame.height - 44, width: self.contentView.frame.width, height: 44)
        cancelBtn.backgroundColor = UIColor.white
        cancelBtn.setTitle("取消", for: UIControlState())
        cancelBtn.setTitleColor(UIColor.black, for: UIControlState())
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelBtn.addTarget(self, action: #selector(self.cancelBtnClicked), for: .touchUpInside)
        self.contentView.addSubview(cancelBtn)


        // 2 - add Line
        let lienView = UIView()
        lienView.frame = CGRect(x: 0, y: self.contentView.frame.height - cancelBtn.frame.minY, width: self.contentView.frame.width, height: 1)
        lienView.backgroundColor = UIColor(colorLiteralRed: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        self.containView?.addSubview(lienView)

        // 3 - addCollection
        let marign:CGFloat = 10
        let width = (self.frame.width - (3 + 1) * marign) / 3
        let height:CGFloat = (width + 20)

        let containViewY = self.contentView.frame.height - (height * 2 + cancelBtn.frame.height + lienView.frame.height);

        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: marign, left: marign, bottom: marign, right: marign)

        let rect = CGRect(x: 0, y: containViewY, width: self.contentView.frame.width, height: height * 2)
        containView = UICollectionView(frame: rect, collectionViewLayout: layout)
        containView?.delegate = self
        containView?.dataSource = self
        containView?.backgroundColor = KBgViewColor
//        containView?.backgroundColor = UIColor.w

        containView?.register(UINib(nibName: "ShareViewCell", bundle: nil), forCellWithReuseIdentifier: "ShareViewCell")
        self.contentView.addSubview(containView!)

        // 制作数据源
        setUpArray()
    }

    func setUpArray(){

        // 判断 安装微信
        if WXApi.isWXAppInstalled() && WXApi.isWXAppSupport() {
            let wxModel = ShareModel.share(name: "share_weixin", title: "微信", type: .wechatSession)
            let pyqModel = ShareModel.share(name: "share_friend", title: "朋友圈", type: .wechatTimeLine)
            dataArray.append(wxModel)
            dataArray.append(pyqModel)
        }

        // 判断 安装QQ
        if ((TencentOAuth.iphoneQQInstalled() && TencentOAuth.iphoneQQSupportSSOLogin()) || TencentOAuth.iphoneQQInstalled() && TencentOAuth.iphoneQZoneSupportSSOLogin()) {
            let qqModel = ShareModel.share(name: "share_qq", title: "QQ" , type: .QQ)
            let qzoneModel = ShareModel.share(name: "share_zone", title: "QQ空间" , type: .qzone)
            dataArray.append(qqModel)
            dataArray.append(qzoneModel)
        }

        let sina = ShareModel.share(name: "share_sina", title: "微博" , type: .sina)
        let copy = ShareModel.share(name: "share_logo", title: "拷贝",type: .facebook)
        dataArray.append(sina)
        dataArray.append(copy)

        containView?.reloadData()
    }


    func setShareModel(_ content:String , image:UIImage , url:String , title:String) {

        self.shareContent = content
        self.shareImage = image
        self.shareUrl = url
        self.shareTitle = title

    }


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShareViewCell", for: indexPath) as! ShareViewCell
        let model = dataArray[indexPath.item]
        cell.model = model
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = dataArray[indexPath.item]

//        shareText(model: model)

    }

    /**
     遮罩背景响应事件
     */
    func bgViewTapped() {
        self.dismiss()
    }

    /**
     取消按钮响应事件
     */
    func cancelBtnClicked() {
        self.dismiss()
    }


    func showInViewController(_ viewController:UIViewController){
        self.showInView(viewController.view)
    }

    //MARK: -- 消失
    fileprivate func dismiss(){
        UIView.animate(withDuration: 0.3, animations: {
            self.bgView.alpha = 0.0
            self.contentView.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: self.contentHeight)

        }, completion: { (finished) in
            self.removeFromSuperview()
        })


    }

    //MARK: -- 出现
    func showInView(_ parentView:UIView) {
        parentView.addSubview(self)
        UIView.animate(withDuration: 0.3, animations: {
            self.bgView.alpha = 0.4
            self.contentView.frame = CGRect(x: 0, y: self.frame.height - self.contentHeight, width: self.frame.width, height: self.contentHeight)
        })

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
