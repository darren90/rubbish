 //
//  TVDetailModel.swift
//  iTVshows
//
//  Created by Tengfei on 2017/3/5.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

enum TVDetailModelType:String{
    case Living = "Living"  // 直播
    case Back  = "Back"   //  回放
    case Appoint = "Appoint"      //预约
 }

 
class TVDetailModel: NSObject {
    
    var t:String?
    var st:Double = 0
    var et:Double = 0
    var showTime:String?
    var duration:Int = 0
    var modelType: TVDetailModelType = .Living
    
    
    init(dict:[String:AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
        
        setLiveType()
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

    func setLiveType(){
        let date = Date()
        let now:Double = date.timeIntervalSince1970
        
        if now < st {
            self.modelType = .Appoint //预约
        }else if now >= st , now <= et {
            self.modelType = .Living
        }else{
            self.modelType = .Back
        }
    }
    


    class func getDetailShowList(channelId: String ,finish:@escaping(_ models:[TVDetailModel]?,_ error:NSError?)->()){
        
        let url = ApiTools.getDetailUrl(channelId: channelId)

        APINetTools.GET(urlStr: url, parms: nil) { (result, error) in
            if error != nil {
                finish(nil,error)
            }else{
                let dict = result as? [String:AnyObject]
                if(dict == nil){
                    finish(nil,NSError.init(domain: "错误的status值", code: 9999, userInfo: ["status码值错误" : "status值不等于1"]))
                }
                let dataDict = dict?["\(channelId)"] as? [String:AnyObject]
                if(dataDict == nil){
                    finish(nil,NSError.init(domain: "错误的status值", code: 9999, userInfo: ["status码值错误" : "status值不等于1"]))
                }

                let dicts = dataDict?["program"] as? [[String:AnyObject]]
                if(dicts == nil){
                    finish(nil,NSError.init(domain: "错误的status值", code: 9999, userInfo: ["status码值错误" : "status值不等于1"]))
                }else{
                    var models = [TVDetailModel]()
                    for ddic in dicts! {
                        let model = TVDetailModel(dict: ddic)
                        models.append(model)
                    }
                    finish(models,error)
                }
            }

        }
    }

}
