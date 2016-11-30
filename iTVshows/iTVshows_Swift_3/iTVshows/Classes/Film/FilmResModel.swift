//
//  FileResModel.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/29.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit


class FilmResModel: NSObject {

    var id:String?

    var cnname:String?

    var enname:String?

    var play_status:String?

    var poster:String?

    var poster_a:String?

    var poster_b:String?

    var poster_m:String?

    var poster_s:String?

    var rank:Int = 0

    var score:Double = 0.0

    var remark:String?

    var views:Int = 0

    var lang:String?

    var itemupdate:String?

    var channel:String?

    var category:String?

    var area:String?

    var format:String?

    init(dict:[String:AnyObject]) {
        super.init()

        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {

    }

    class func getFilmList(page:Int = 1,finish:@escaping(_ models:[FilmResModel]?,_ error:NSError?)->()){

        let url = "http://api.ousns.net/resource/fetchlist?page=\(page)&limit=15"

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
                    let dataDiv :[[String:AnyObject]]? = dataDic?["list"] as? [[String:AnyObject]]

                    if(dataDiv == nil){
                        finish(nil,NSError.init(domain: "没有可用的数据", code: 9999, userInfo: ["字典为空" : "status值不等于1"]))
                    }else{
                        var models = [FilmResModel]()
                        for dic in dataDiv! {
                            let model = FilmResModel.init(dict: dic)
                            models.append(model)
                        }
                        print("--ms-:\(models)")
                        finish(models,nil)
                    }
                }

            }
            
        }
    }

    

}
