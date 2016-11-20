//
//  ViewController.swift
//  iTVshows
//
//  Created by Tengfei on 16/11/18.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        MobClick.beginLogPageView("ViewController");
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        MobClick.endLogPageView("ViewController");
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        UMSocialUIManager.showShareMenuViewInWindow { (shareselectView, platformType) in
//            self.shareText(platType: platformType)
//        }
//        shareAction()
    }

    func shareText(platType:UMSocialPlatformType) {
        let messObj = UMSocialMessageObject()
        messObj.text = "Swift分享的测试版本"
        messObj.isKind(of: UMSocialShareResponse.classForCoder())

        UMSocialManager.default().share(to: platType, messageObject: messObj, currentViewController: self) { (data, error) in
            if(error == nil){
                print("share error");
            }else{
//                if(data.isKind(of:?UMSocialShareResponse)){
//                    
//                }
//                data =
//                UMSocialResponse
                
            }
        }
    }
    
    
    func shareAction (){
        
        
        UMSocialUIManager.showShareMenuViewInWindow { (shreMenuView, platformType) -> Void in
            
            let messageObject:UMSocialMessageObject = UMSocialMessageObject.init()
            messageObject.text = "社会化组件UShare将各大社交平台接入您的应用，快速武装App。"//分享的文本
            
            /*
             //1.分享图片
             var shareObject:UMShareImageObject = UMShareImageObject.init()
             shareObject.title = "Umeng分享"//显不显示有各个平台定
             shareObject.descr = "描述信息"//显不显示有各个平台定
             shareObject.thumbImage = UIImage.init(named: "icon")//显不显示有各个平台定
             shareObject.shareImage = "http://dev.umeng.com/images/tab2_1.png"
             messageObject.shareObject = shareObject;
             */
            
            //2.分享分享网页
            let shareObject:UMShareWebpageObject = UMShareWebpageObject.init()
            shareObject.title = "分享标题"//显不显示有各个平台定
            shareObject.descr = "描述信息"//显不显示有各个平台定
            shareObject.thumbImage = UIImage.init(named: "icon")//缩略图，显不显示有各个平台定
            shareObject.webpageUrl = "http://video.sina.com.cn/p/sports/cba/v/2013-10-22/144463050817.html"
            messageObject.shareObject = shareObject;
            
            UMSocialManager.default().share(to: UMSocialPlatformType.sina, messageObject: messageObject, currentViewController: self, completion: { (shareResponse, error) -> Void in
                if error != nil {
                    print("Share Fail with error ：%@", error)
                }else{
                    print("Share succeed")
                }
                
            })
            
        }
    }

}

