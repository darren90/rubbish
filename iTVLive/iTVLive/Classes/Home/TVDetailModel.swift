 //
//  TVDetailModel.swift
//  iTVshows
//
//  Created by Tengfei on 2017/3/5.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class TVDetailModel: NSObject {
    
    var t:String?
    var st:Double = 0
    var et:Double = 0
    var showTime:String?
    var duration:Int = 0
    
    
    init(dict:[String:AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
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
