//
//  APINetTools.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/22.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

import Alamofire
//import Swif


enum RequestType:String{
    case GET = "GET"
    case POST = "POST"
}

class APINetTools: NSObject {
 
    static func GET(urlStr:String,parms:[String : AnyObject]?,fininsh : @escaping (_ result:AnyObject? , _ error:NSError?) -> ()){
 
        Alamofire.request(urlStr, method: .get).responseJSON { (response) in
            switch response.result.isSuccess {
            case true:
//                print("-- get request data:\(response.result.value)")
                fininsh(response.result.value! as AnyObject,nil)
            case false:
//                print("-- get request error:\(response.result.error!)")
                 fininsh(nil,response.result.error as NSError?)
            }
        }
    }

    
    static func POST(urlStr:String,parms:[String : AnyObject]?,fininsh : @escaping (_ result:AnyObject? , _ error:NSError?) -> ()){
 

        Alamofire.request(urlStr, method: .post).responseJSON { (response) in
            switch response.result.isSuccess {
            case true:
//                print("-- post request data:\(response.result.value)")
                fininsh(response.result.value! as AnyObject,nil)
            case false:
//                print("-- post request error:\(response.result.error!)")
                fininsh(nil,response.result.error as NSError?)
            }
        }
    }

 

}

/*
 
 首页(资讯，剧评，等等) -- 影视(影视列表) -- 排期（追剧） -- 我的

 
 

 API使用反馈交流群： 595548644
 CID:11
 accesskey:
 f1a1a3a891ccdcfd08038c8678dcab53
 
资讯列表
资讯详情

影视列表
影视详情

资源下载方式
影视资源列表

搜索接口
季度集数信息
今日更新
今日热门
全局搜索接口

字幕列表
字幕详情

美剧时间表

*/


















