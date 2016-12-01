//
//  FilmResDetailModel.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/29.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class FilmResDetailModel: NSObject {

    var id:String?

    var cnname:String?

    var enname:String?

    /// 纯汉字，没有html代码
    var content:String?

    var category:String?

    var area:String?

    var channel:String?

//    为0表示当前用户没有权限下载资源(必须传递uid和token给当前接口),仅限IOS客户端
    let item_permission:Int = 0

    var play_status:String?

    var poster:String?

    var poster_a:String?

    var poster_b:String?

    var poster_m:String?

    var poster_s:String?

    var premiere:Int = 0

    var score:Double = 0.0

    var remark:String?

    var views:Int = 0

    init(dict:[String:AnyObject]) {
        super.init()

        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {

    }

    class func getFilmDetail(id:String,finish:@escaping(_ models:FilmResDetailModel?,_ error:NSError?)->()){

        let url = "http://api.ousns.net/resource/getinfo?id=\(id)"

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

                let dataDic = result?["data"] as? [String:AnyObject]

                if(dataDic == nil){
                    finish(nil,NSError.init(domain: "没有数据", code: 9999, userInfo: ["数据为空" : "数据为空"]))
                }else{
                    let model = FilmResDetailModel.init(dict: dataDic!)
                    finish(model,nil)
                }
                
            }
            
        }
    }


}
//1.1.1
