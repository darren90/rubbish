//
//  ArticleDetailModel.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/29.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class ArticleDetailModel: NSObject {


    //    content = "";
    //    dateline = 1480217328;
    //    favorites = 0;
    //    id = 29575;
    //    intro = "\U5728\U6211\U4e0d\U591a\U7684\U89c1\U8bc6\U91cc\Uff0c\U4ece\U6765\U6ca1\U6709\U4e00\U90e8\U7ffb\U62cd\U7684\U5267\U96c6\U80fd\U8d85\U8d8a\U539f\U8457\Uff0c\U4f46\U8fd9\U90e8\Uff0c\U5df2\U7ecf\U5f88\U63a5\U8fd1\U4e86\U3002";
    //    poster = "2016/1127/1e25d122bd9150eca1d34c79608e05ff.jpg";
    //    resourceid = 0;
    //    review = "<null>";
    //    source = "";
    //    thanks = "<null>";
    //    title = "\U300a\U65e0\U4eba\U751f\U8fd8\U300b| \U4f60\U4ee5\U4e3a\U771f\U8ba9\U4f60\U6765\U770b\U63a8\U7406\U7684\U5417\Uff1f";
    //    translator = "<null>";
    //    type = "t_review";
    //    updatetime = 0;
    //    views = 5203;

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

    //偏差日期
    class func getArticleDetail(id : String, finish:@escaping(_ models:ArticleDetailModel?,_ error:NSError?)->()){

        let url = "http://api.ousns.net/article/getinfo?id=\(id)"

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

                let dataDiv :[String:AnyObject]? = result?["data"] as? [String:AnyObject]

                if(dataDiv == nil){
                    finish(nil,NSError.init(domain: "没有可用的数据", code: 9999, userInfo: ["字典为空" : "status值不等于1"]))
                }else{
                    let model = ArticleDetailModel.init(dict: dataDiv!)
                    finish(model,nil)
                }
            }
            
        }
    }
}
