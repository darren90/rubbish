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

        setValuesForKeys(dict)
    }

//    override func setValue(_ value: Any?, forKey key: String) {
//        super.setValue(value, forKey: key)
//    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {

    }

    //偏差日期
    class func getScheduleList(date:Date,finish:@escaping(_ models:[ScheduleModel]?,_ error:NSError?)->()){

        let formate = DateFormatter()
        formate.dateFormat = "yyyyMMdd"

        let dateStr = formate.string(from: date as Date)
        formate.dateFormat = "yyyy-MM-dd"

        let dateDiv = formate.string(from: date as Date)

        //        print("---dateStr:\(dateStr),--dateDiv:\(dateDiv)")
        let url = "http://api.ousns.net/tv/schedule?end=\(dateStr)&start=\(dateStr)"

        APINetTools.GET(urlStr: url, parms: nil) {(result : AnyObject?, error : NSError?) -> () in
            print("----\(result)")
            print("----\(error)")

            if (error != nil){
                finish(nil,error)
            }else{
                let status = result?["status"] as! Int
                if (status != 1){
                    finish(nil,NSError.init(domain: "错误的status值", code: 9999, userInfo: ["status码值错误" : "status值不等于1"]))
                }
                let dataDic :[String:AnyObject]? = result?["data"] as? [String:AnyObject]

                if(dataDic == nil){
                    finish(nil,NSError.init(domain: "没有可用的数据", code: 9999, userInfo: ["status码值错误" : "status值不等于1"]))
                }else{
                    let dataDiv :[[String:AnyObject]]? = dataDic?[dateDiv] as? [[String:AnyObject]]

                    if(dataDiv == nil){
                        finish(nil,NSError.init(domain: "没有可用的数据", code: 9999, userInfo: ["字典为空" : "status值不等于1"]))
                    }else{
                        var models = [ScheduleModel]()
                        for dic in dataDiv! {
                            let model = ScheduleModel.init(dict: dic)
                            models.append(model)
                        }
                        finish(models,nil)
                    }
                }
            }
        }
    }

    //偏差日期
    class func getScheduleList(offsetDate:Int,finish:@escaping(_ models:[ScheduleModel]?,_ error:NSError?)->()){
        
//        start(必选) 开始时间,标准的时间格式,如:2015-02-03或2015-2-3或20150203
//        end(必选) 结束时间,同上,开始时间和结束时间不能超过31天
//        limit(可选) 返回数量

        
        //        http://api.ousns.net/tv/schedule?end=20161128&start=20161128
        //正：tomorrow
        //负：yesterday
        let date = NSDate.init(timeIntervalSinceNow: Double(offsetDate*24*60*60))
        let formate = DateFormatter()
        formate.dateFormat = "yyyyMMdd"

        let dateStr = formate.string(from: date as Date)
        formate.dateFormat = "yyyy-MM-dd"

        let dateDiv = formate.string(from: date as Date)

//        print("---dateStr:\(dateStr),--dateDiv:\(dateDiv)")
        let url = "http://api.ousns.net/tv/schedule?end=\(dateStr)&start=\(dateStr)"

        APINetTools.GET(urlStr: url, parms: nil) {(result : AnyObject?, error : NSError?) -> () in
            print("----\(result)")
            print("----\(error)")

            if (error != nil){
                finish(nil,error)
            }else{
                let status = result?["status"] as! Int
                if (status != 1){
                    finish(nil,NSError.init(domain: "错误的status值", code: 9999, userInfo: ["status码值错误" : "status值不等于1"]))
                }
                let dataDic :[String:AnyObject]? = result?["data"] as? [String:AnyObject]

                if(dataDic == nil){
                    finish(nil,NSError.init(domain: "没有可用的数据", code: 9999, userInfo: ["status码值错误" : "status值不等于1"]))
                }else{
                    let dataDiv :[[String:AnyObject]]? = dataDic?[dateDiv] as? [[String:AnyObject]]

                    if(dataDiv == nil){
                        finish(nil,NSError.init(domain: "没有可用的数据", code: 9999, userInfo: ["字典为空" : "status值不等于1"]))
                    }else{
                        var models = [ScheduleModel]()
                        for dic in dataDiv! {
                            let model = ScheduleModel.init(dict: dic)
                            models.append(model)
                        }
                        finish(models,nil)
                    }
                }
            }
        }
    }
}

/*
 
 APINetTools.GET_TV(url: url, params: nil, success: {(json) -> Void in
 print("-----json:\(json)--")
 }){(error) -> Void in
 print("-----error:\(error)-")
 }

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
