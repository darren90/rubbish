//
//  TVListModel.swift
//  iTVshows
//
//  Created by Tengfei on 2017/3/5.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

enum TVListModelType:String{
    case NotLoading = "NotLoading"  //还没有请求
    case YES  = "YES"   //请求了 - 请求到数据
    case NO = "NO"      //请求了 - 没有请求到数据
}


class TVListModel: NSObject {
    
    //有用的
    var order:Int = 1
    var title:String?
    var channelId:String?
    var t:String?//正在播放的视频
    var iconUrl:URL?//显示的图片
    var modelType: TVListModelType = .NotLoading

    
    //无用的
    var channelImg:String?
    var bigImgUrl:String?
    var imgUrl:String?
    var initial:String?
    var p2pUrl:String?
    var shareUrl:String?
    var liveUrl:String?
    var autoImg:String?
    var newChannelImg:String?
    
    var isAdmob: Bool = false //是否是广告
    
    override init() {
        super.init()
    }

    init(dict:[String:AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
        
        guard let channelId = channelId else{
            return
        }
        let uurl = ApiTools.getChannelImg(channelId: channelId)
        iconUrl = URL(string: uurl)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
    class func getTVList(finish:@escaping(_ models:[TVListModel]?,_ error:NSError?)->()){
        let url = ApiTools.URL_YS //"http://serv.cbox.cntv.cn/json/zhibo/yangshipindao/ysmc/index.json"
        
        APINetTools.GET(urlStr: url, parms: nil) { (result, error) in
            if error != nil {
                finish(nil,error)
            }else{
                let dict = result as? [String:AnyObject]
                if(dict == nil){
                    finish(nil,NSError.init(domain: "错误的status值", code: 9999, userInfo: ["status码值错误" : "status值不等于1"]))
                }
                let dataDict = dict?["data"] as? [String:AnyObject]
                if(dataDict == nil){
                    finish(nil,NSError.init(domain: "错误的status值", code: 9999, userInfo: ["status码值错误" : "status值不等于1"]))
                }
                
                let dicts = dataDict?["items"] as? [[String:AnyObject]]
                if(dicts == nil){
                    finish(nil,NSError.init(domain: "错误的status值", code: 9999, userInfo: ["status码值错误" : "status值不等于1"]))
                }else{
                    var models = [TVListModel]()
                    var index = 0
                    for ddic in dicts! {
                        let model = TVListModel(dict: ddic)
                        models.append(model)
                        
                        if index == 12 { //加入广告逻辑
                            let adM = TVListModel()
                            adM.isAdmob = true
                            models.append(adM)
                        }
                        index = index + 1
                    }
                    finish(models,error)
                }
                
 
            }
            
        }
    }

    //获取正在播放的视频的标题
    class func getTVLiveNow(liveModel: TVListModel ,indexPath: IndexPath , finish:@escaping(_ models:TVListModel?,_ error:NSError?)->()){

        let url = ApiTools.getNowPlayShow(channelId: liveModel.channelId ?? "")

        APINetTools.GET(urlStr: url, parms: nil) { (result, error) in
            if error != nil {
                liveModel.modelType = .NO
//                finish(nil,error)
            }else{
//                "t": "新闻联播",
//                "s": "19:00:00",
//                "d": 1488798742,
//                "c": "cctv1",
//                "n": "CCTV-1 综合",
//                "e": "19:44:00",
//                "ints": 1488798000,
//                "inte": 1488800640
                let dict = result as? [String:AnyObject]
                if(dict == nil){
                    liveModel.modelType = .NO
                }else{
                    liveModel.modelType = .YES
                    let t: String = (dict!["t"] as? String) ?? ""
                    liveModel.t = t
                    if t.characters.count == 0 {
                        liveModel.modelType = .NO
                    }
                }
            }

             finish(liveModel,error)
        }
    }
    
    
    class func getTVChannelList(url: String? ,finish:@escaping(_ models:[TVListModel]?,_ error:NSError?)->()){
//        let url = ApiTools.URL_YS
        guard let url = url else {
            return
        }
        
        APINetTools.GET(urlStr: url, parms: nil) { (result, error) in
            if error != nil {
                finish(nil,error)
            }else{
                let dict = result as? [String:AnyObject]
                if(dict == nil){
                    finish(nil,NSError.init(domain: "错误的status值", code: 9999, userInfo: ["status码值错误" : "status值不等于1"]))
                }
                let dataDict = dict?["data"] as? [String:AnyObject]
                if(dataDict == nil){
                    finish(nil,NSError.init(domain: "错误的status值", code: 9999, userInfo: ["status码值错误" : "status值不等于1"]))
                }
                
                let dicts = dataDict?["items"] as? [[String:AnyObject]]
                if(dicts == nil){
                    finish(nil,NSError.init(domain: "错误的status值", code: 9999, userInfo: ["status码值错误" : "status值不等于1"]))
                }else{
                    var models = [TVListModel]()
                    for ddic in dicts! {
                        let model = TVListModel(dict: ddic)
                        models.append(model)
                    }
                    finish(models,error)
                }
                
                
            }
            
        }
    }

    
}















