//
//  ShareView.swift
//  iTVshows
//
//  Created by Fengtf on 2016/12/6.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class ShareView: UIView , UICollectionViewDelegate,UICollectionViewDataSource {

    var containView:UICollectionView?

    var dataArray : [ShareModel]?

    var content:String?
    var imgUrl:String?
    var contentUrl:String?
    var title:String?
    var rootVc:UIViewController?

    func share(content:String , imgUrl:String , contentUrl:String , title:String , rootVc : UIViewController) {
        self.content = content
        self.imgUrl = imgUrl
        self.contentUrl = contentUrl
        self.title = title
        self.rootVc = rootVc
    }


    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpCollectionView()

        setUpArray()
    }

    // MARK:-- CollectionView
    func setUpCollectionView() {
        let marign:CGFloat = 10
        let width = (self.frame.width - 3 * marign) / 2
        let height:CGFloat = width * 321 / 240

        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: marign, left: marign, bottom: marign, right: marign)

        let rect = CGRect(x: 0, y: 64, width: self.frame.width, height: self.frame.height)
        containView = UICollectionView(frame: rect, collectionViewLayout: layout)
        containView?.delegate = self
        containView?.dataSource = self
        //        watherView?.contentInset = UIEdgeInsets(top: 0, left: marign, bottom: 10, right: marign)
        containView?.backgroundColor = KBgViewColor

        containView?.register(UINib(nibName: "ShareViewCell", bundle: nil), forCellWithReuseIdentifier: "ShareViewCell")
        self.addSubview(containView!)
    }

    func setUpArray(){

        // 判断 安装微信
        if WXApi.isWXAppInstalled() && WXApi.isWXAppSupport() {
            let wxModel = ShareModel.share(name: "", title: "", type: .wechatSession)
            let pyqModel = ShareModel.share(name: "", title: "", type: .wechatTimeLine)
            dataArray?.append(wxModel)
            dataArray?.append(pyqModel)
        }

        // 判断 安装QQ
        if ((TencentOAuth.iphoneQQInstalled() && TencentOAuth.iphoneQQSupportSSOLogin()) || TencentOAuth.iphoneQQInstalled() && TencentOAuth.iphoneQZoneSupportSSOLogin()) {
            let qqModel = ShareModel.share(name: "", title: "" , type: .QQ)
            let qzoneModel = ShareModel.share(name: "", title: "" , type: .qzone)
            dataArray?.append(qqModel)
            dataArray?.append(qzoneModel)
        }

        let sina = ShareModel.share(name: "", title: "" , type: .sina)
        let copy = ShareModel.share(name: "", title: "",type: .facebook)
        dataArray?.append(sina)
        dataArray?.append(copy)


        containView?.reloadData()
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShareViewCell", for: indexPath) as! ShareViewCell
        let model = dataArray![indexPath.item]
         cell.model = model
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = dataArray![indexPath.item]

        shareText(model: model)

    }

    func shareText(model:ShareModel) {

        if model.type == .facebook {
            let board = UIPasteboard.general
            board.string = "复制了，，，"
            
            return;
        }
        let title = "share社会化组件U-Share将各大社交平台接入您的应用"
        let content = ""
        let imagUrl = ""
        let shareUrl = ""

        let messageObject = UMSocialMessageObject.init()
        let shareObject = UMShareWebpageObject.shareObject(withTitle: title, descr: content, thumImage: imagUrl)
        shareObject?.webpageUrl = shareUrl

//        if imagUrl == nil {
            shareObject?.thumbImage = UIImage(named: "share_friend_hover")
//        }

        messageObject.shareObject = shareObject;
        UMSocialManager.default().share(to: model.type!, messageObject: messageObject, currentViewController: self){(data , error) in
            var msg = "分享成功"
            if (error != nil){
                msg = "分享失败"
            }else{
                print("share error:\(error)")
            }
        }
    }

    func dismiss(){
        let height = (rootVc?.view.bounds)!.height
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            self.frame = CGRect(x: 0, y: 0, width:(self.rootVc?.view.bounds)!.width, height: height)
        }, completion: { (finished) in
            self.removeFromSuperview()
        })
    }
 
    func show() {
        self.rootVc?.view.addSubview(self)
        let height = (rootVc?.view.bounds)!.height
        self.frame = CGRect(x: 0, y: 0, width: (self.rootVc?.view.bounds)!.width, height: (rootVc?.view.bounds)!.height)
        UIView.animate(withDuration: 0.3, animations: {//colorWithAlphaComponent
            self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.frame = CGRect(x: 0, y: 0, width: (self.rootVc?.view.bounds)!.width, height: height)
        })
    }


}

//extension ShareView :   {
//
//}

 

class ShareModel: NSObject {
    var name:String?
    var title:String?

    var type:UMSocialPlatformType?

    class func share(name : String , title : String , type : UMSocialPlatformType) -> ShareModel {
        let model = ShareModel()
        model.name = name
        model.title = title
        model.type = type
        return model
    }
}






















































