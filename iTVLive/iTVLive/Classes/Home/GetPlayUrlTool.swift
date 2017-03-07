//
//  GetPlayUrlTool.swift
//  iTVLive
//
//  Created by Tengfei on 2017/3/6.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class GetPlayUrlTool: NSObject {
    
    class func getLiveBackUrl(channelId:String ,st: Double , et: Double, finish:@escaping(_ models:[String]?,_ error:NSError?)->()){
        
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
                    var models = [String]()
                    for ddic in dicts! {
                        let url = ddic["url"] as! String
                        if (url.characters.count > 0){
                            models.append(url)
                        }
                    }
                    finish(models,error)
                }
            }
        }
    }
    
    class func getLiveUrl(channelId:String , finish:@escaping(_ models:[String]?,_ error:NSError?)->()){
        
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
                
                let dicts = dict!["hls_url"] as? [String:String]
                if(dicts == nil){
                    finish(nil,NSError.init(domain: "错误的status值", code: 9999, userInfo: ["status码值错误" : "status值不等于1"]))
                }else{
                    var models = [String]()
                    for (_, value) in dicts! {
                        if (value.characters.count > 0){
                            models.append(value)
                        }
                    }
                    finish(models,error)
                }
            }
        }

        

    }
}
