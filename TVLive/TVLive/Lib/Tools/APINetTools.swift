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
    static let cid = 11
    static let client = 1
    static let accesskey = "f1a1a3a891ccdcfd08038c8678dcab53"


    static func GET(urlStr:String,parms:[String : AnyObject]?,fininsh : @escaping (_ result:AnyObject? , _ error:NSError?) -> ()){

        let url = getUrl(urlStr: urlStr)

        Alamofire.request(url, method: .get).responseJSON { (response) in
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

        let url = getUrl(urlStr: urlStr)

        Alamofire.request(url, method: .post).responseJSON { (response) in
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

    static func getUrl(urlStr:String) -> String {
        let timestamp = Int(NSDate().timeIntervalSince1970)
        let md5Str = "\(cid)$$\(accesskey)&&\(timestamp)".md5!

        var url = urlStr
        if (urlStr.contains("?")){
            url = url + "&cid=\(cid)"+"&client=\(client)"+"&timestamp=\(timestamp)" + "&accesskey=\(md5Str)"
        } else {
             url = url + "?cid=\(cid)"+"&client=\(client)"+"&timestamp=\(timestamp)" + "&accesskey=\(md5Str)"
        }
        print("--timestamp:\(timestamp)--md5:\(md5Str),\n\n url:\(url)")

        return url
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


















