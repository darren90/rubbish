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
//            self.shareText(platType: .sina)
//        }
//        shareAction()
        
//        shareText(platType: .sina);

//        loginin()
    }


    
    func shareInfo ()  {
//        UMSocialUrlResource
    }
    
    
    func loginin()  {
         //"http://weixintest.ihk.cn/ihkwx_upload/heji/material/img/20160414/1460616012469.jpg"
        
        UMSocialManager.default().getUserInfo(with: .wechatSession, currentViewController: self) { (result, error) in
            if (error == nil){
                print("auth fail")
            }else{
                let resp = result as! UMSocialAuthResponse
                print("uid:\(resp.uid)")
                print("accessToken:\(resp.accessToken)")
                print("refreshToken:\(resp.refreshToken)")
                print("expiration:\(resp.expiration)")
                print("originalResponse:\(resp.originalResponse)")
            }
        }
        
    }
    
    

    

    func shareText(platType:UMSocialPlatformType) {
        let messObj = UMSocialMessageObject.init()
        messObj.text = "Swift分享的测试版本"
//        messObj.isKind(of: UMSocialShareResponse.classForCoder())

        UMSocialManager.default().share(to: platType, messageObject: messObj, currentViewController: self) { (data, error) in
            if(error == nil){
                print("share error");
            }else{
                print("share success");
//                if(data.isKind(of:?UMSocialShareResponse)){
//                    
//                }
//                data =
//                UMSocialResponse
                
            }
        }
    }
    
    
    func shareAction (){
      
    }

}

