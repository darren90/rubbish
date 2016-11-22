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

class APINetTools: NSObject {

    static func GET(url:String,params:[String:AnyObject]?,success:@escaping (_ json:AnyObject) -> Void,fail:@escaping (_ error:Any) ->Void){

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

    static func POST(url:String,params:[String:AnyObject]?,success:@escaping(_ json:AnyObject) -> Void,fail:@escaping(_ error:Any) ->Void){
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





















