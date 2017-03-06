//
//  GetPlayUrlTool.swift
//  iTVLive
//
//  Created by Tengfei on 2017/3/6.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class GetPlayUrlTool: NSObject {
    
    class func getLiveBackUrl(channelId:String ,st: Double , et: Double, finish:@escaping(_ models:[TVDetailModel]?,_ error:NSError?)->()){
        
        let url = ApiTools.getLiveBackUrl(channelId: channelId, st: st, et: et)
        
        APINetTools.GET(urlStr: url, parms: nil) { (result, error) in
            if error != nil {
                finish(nil,error)
            }else{
                let dict = result as? [String:AnyObject]
                if(dict == nil){
                    finish(nil,NSError.init(domain: "错误的status值", code: 9999, userInfo: ["status码值错误" : "status值不等于1"]))
                }
                let dataDict = dict?["video"] as? [String:AnyObject]
                if(dataDict == nil){
                    finish(nil,NSError.init(domain: "错误的status值", code: 9999, userInfo: ["status码值错误" : "status值不等于1"]))
                }
                
                let dicts = dataDict?["chapters"] as? [[String:AnyObject]]
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
    
    class func getLiveUrl(channelId:String , finish:@escaping(_ models:[TVDetailModel]?,_ error:NSError?)->()){
        
        let url = ApiTools.getLiveUrl(channelId: channelId)
        
        APINetTools.GET(urlStr: url, parms: nil) { (result, error) in
            if error != nil {
                finish(nil,error)
            }else{
                let dict = result as? [String:AnyObject]
                if(dict == nil){
                    finish(nil,NSError.init(domain: "错误的status值", code: 9999, userInfo: ["status码值错误" : "status值不等于1"]))
                }
//                let dataDict = dict?["hls_url"] as? [String:AnyObject]
//                if(dataDict == nil){
//                    finish(nil,NSError.init(domain: "错误的status值", code: 9999, userInfo: ["status码值错误" : "status值不等于1"]))
//                }
                
                let dicts = dict?["hls_url"] as? [[String:AnyObject]]
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
