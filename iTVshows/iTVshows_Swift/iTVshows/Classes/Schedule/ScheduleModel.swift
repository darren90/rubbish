//
//  ScheduleModel.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class ScheduleModel: NSObject {

    var id:String?

    var cnname:String?

    var enname:String?

    var poster:String?

    var season:String?

    var episode:String?

    var poster_a:String?

    var poster_b:String?

    var poster_m:String?

    var poster_s:String?

    init(dict:[String:AnyObject]) {
        super.init()

//        setValuesForKeysWithDictionary(dict)
        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forKey key: String) {

        super.setValue(value, forKey: key)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {

    }

    //偏差日期
    class func getScheduleList(offsetDate:Int,finished:(_ models:[ScheduleModel]?,_ error:Any?)->()){
        //正：tomorrow
        //负：yesterday
        let date = NSDate.init(timeIntervalSinceNow: Double(offsetDate*24*60*60))
//        var formate = DateFormatter
//        formate.set
        let url = "http://api.ousns.net/tv/schedule?end=20161128&start=20161128"

        APINetTools.GET_TV(url: url, params: nil, success: {(json) -> Void in
            print("-----json:\(json)--")
        }){(error) -> Void in
            print("-----error:\(error)-")
        }
    }

}
/*
 //为了字典转模型
 init(dict:[String:AnyObject]){
 super.init()//用需要调用 super
 setValuesForKeysWithDictionary(dict)
 }

 override func setValue(value: AnyObject?, forKey key: String) {
 //        print("key=:\(value),key=:\(key)")

 if "user" == key {

 user = User(dict: value as! [String:AnyObject] )
 return
 }

 super.setValue(value, forKey: key)
 }

 override func setValue(value: AnyObject?, forUndefinedKey key: String) {

 }


 class func getStatus(since_id:Int,max_id:Int ,finished:(models:[Status]?,error:Any?)->()){
 let path = "2/statuses/friends_timeline.json"


 var params = ["access_token":UserAccount.getAccount()!.access_token!]
 //下拉刷新
 if since_id > 0 {
 params["since_id"] = "\(since_id)"
 }

 if max_id > 0 {
 params["max_id"] = "\(max_id - 1)"
 }

 APINetTools.get(path, params: params, success: { (json) -> Void in
 //            print(json)
 let models = dict2Model(json["statuses"] as! [[String:AnyObject]])
 //                print(models)


 cacheStatusImages(models,finished: finished)

 //            finished(models: models, error: nil)
 }) { (error) -> Void in
 finished(models: nil, error: error)
 }
 */
