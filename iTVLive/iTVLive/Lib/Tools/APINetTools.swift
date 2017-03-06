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
  



















