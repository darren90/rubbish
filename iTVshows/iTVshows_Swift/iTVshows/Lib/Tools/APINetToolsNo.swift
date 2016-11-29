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

        let timestamp = Int(NSDate().timeIntervalSince1970)
        let md5Str = "\(cid)$$\(accesskey)&&\(timestamp)".md5!
        //        print("md5Str:\(md5Str),after:\(md5Str.md5!)")

        let url = urlStr + "&cid=\(cid)"+"&client=\(client)"+"&timestamp=\(timestamp)" + "&accesskey=\(md5Str)"
        print("--timestamp:\(timestamp)--md5:\(md5Str)\n,url:\(url)")

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

        let timestamp = Int(NSDate().timeIntervalSince1970)
        let md5Str = "\(cid)$$\(accesskey)&&\(timestamp)".md5!
        //        print("md5Str:\(md5Str),after:\(md5Str.md5!)")

        let url = urlStr + "&cid=\(cid)"+"&client=\(client)"+"&timestamp=\(timestamp)" + "&accesskey=\(md5Str)"
        print("--timestamp:\(timestamp)--md5:\(md5Str)\n,url:\(url)")

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



    static func GET_TV(url:String,params:[String:AnyObject]?,success:@escaping (_ json:AnyObject) -> Void,fail:@escaping (_ error:Any) ->Void){

// http://api.ousns.net/tv/schedule?accesskey=e7d7640d0e1c89dbc5ccb9d0e24b5db3&cid=11&client=1&end=20161128&start=20161128&timestamp=1480326828

        let timestamp = Int(NSDate().timeIntervalSince1970)
        let md5Str = "\(cid)$$\(accesskey)&&\(timestamp)".md5!
//        print("md5Str:\(md5Str),after:\(md5Str.md5!)")

        let url = url + "&cid=\(cid)"+"&client=\(client)"+"&timestamp=\(timestamp)" + "&accesskey=\(md5Str)"
        print("--timestamp:\(timestamp)--md5:\(md5Str)\n,url:\(url)")
        Alamofire.request(url, method: .get).responseJSON { (response) in
            switch response.result.isSuccess {
            case true:
                print("-- post request data:\(response.result.value)")
                success(response.result.value! as AnyObject)
            case false:
                print("-- get request error:\(response.result.error!)")
                fail(response.result.error!)
            }
        }
    }

    static func AGET2(url:String,params:[String:AnyObject]?,success:@escaping (_ json:AnyObject) -> Void,fail:@escaping (_ error:Any) ->Void){

        Alamofire.request(url, method: .get).responseJSON { (response) in
            switch response.result.isSuccess {
            case true:
//                //把得到的JSON数据转为数组
//                if let items = response.result.value as? NSArray{
//                    for dict in items{//遍历数组得到每一个字典模型
//                        print(dict)
//                    }
//                }
                print("-- post request data:\(response.result.value)")
                success(response.result.value! as AnyObject)
            case false:
                print("-- get request error:\(response.result.error!)")
                fail(response.result.error!)
            }

//            if(response.response?.statusCode == 200){
//                if let jsonn = response.result.value{
//                    print("json:\(jsonn)")
//                }
//                print("response.result:\(response.result)")
//            }else{
//                print("error:\(response.result.error)")
//            }
        }

    }

    static func APOST2(url:String,params:[String:AnyObject]?,success:@escaping(_ json:AnyObject) -> Void,fail:@escaping(_ error:Any) ->Void){
        Alamofire.request(url, method: .post).responseJSON { (response) in
            switch response.result.isSuccess {
            case true:
                print("-- post request data:\(response.result.value)")
                success(response.result.value! as AnyObject)
            case false:
                print("-- post request error:\(response.result.error!)")
                fail(response.result.error!)
            }
        }
    }


}

/*
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


















