//
//  NewsModel.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/29.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class ArticleModel: NSObject {

    var id:String?

    var title:String?

    var type:String?

    var poster:String?

    var dateline:String?

    var content:String?

    var intro:String?

    var resourceid:String?

    var review:String?

    var source:String?

    var thanks:String?

    var translator:String?

    var views:String?

    init(dict:[String:AnyObject]) {
        super.init()

        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {

    }


    class func getArticleList(page:Int = 1 , finish:@escaping(_ models:[ArticleModel]?,_ error:NSError?)->()){

        let url = "http://api.ousns.net/article/fetchlist?limit=15&page=\(page)"

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

                let dataDiv :[[String:AnyObject]]? = result?["data"] as? [[String:AnyObject]]

                if(dataDiv == nil){
                    finish(nil,NSError.init(domain: "没有可用的数据", code: 9999, userInfo: ["字典为空" : "status值不等于1"]))
                }else{
                    var models = [ArticleModel]()
                    for dic in dataDiv! {
                        let model = ArticleModel.init(dict: dic)
                        models.append(model)
                    }
//                    print("--ms-:\(models)")
                    finish(models,nil)
                }
            }

        }
    }

}
