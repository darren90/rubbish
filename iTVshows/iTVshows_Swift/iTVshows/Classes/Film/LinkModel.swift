//
//  LinkModel.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/29.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class LinkModel: NSObject {

    var id:String?

    var cnname:String?

    var enname:String?

    var content:String?

    init(dict:[String:AnyObject]) {
        super.init()

        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {

    }

    class func getLink(id:String,finish:@escaping(_ models:LinkModel?,_ error:NSError?)->()){

        let url = "http://api.ousns.net/resource/itemlink?id=\(id)"

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
                    let model = LinkModel.init(dict: dataDic!)
                    finish(model,nil)
                }
                
            }
            
        }
    }

}
