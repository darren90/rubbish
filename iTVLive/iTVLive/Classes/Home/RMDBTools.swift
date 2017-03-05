//
//  RMDBTools.swift
//  TVLive
//
//  Created by Tengfei on 2017/3/4.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit
import RealmSwift

class RMDataModel : Object {
    dynamic var tvName = ""
    dynamic var tvUrl = ""
    dynamic var tvWebUrl = "" //网页播放地址
    dynamic var tvIconUrl = ""
    dynamic var category = "" //类别
    dynamic var index = 1   //排序
    dynamic var who = ""
    dynamic var isEffet = false //是否有效
    dynamic var date = Date()
}

class RMDBTools: NSObject {

     static let shareInstance:RMDBTools = RMDBTools()
    
    override init() {
        super.init()
    }
    
    var realm = { () -> Realm in
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let dbPath = docPath?.appending("/tvlive.realm")
        let dbUrl = URL(fileURLWithPath: dbPath!)
        print("dbpath:   \(NSHomeDirectory())")
        let rm = try! Realm(fileURL: dbUrl)
        return rm
    }()
    
    //制造数据
    func createData(model:RMDataModel){
        realm.beginWrite()
        
        realm.add(model)
        
        try! realm.commitWrite()
    }
    
    func addData(){
        let model = RMDataModel()
        model.tvName = "cctv"
        model.tvUrl = "baidu.com"
        
        realm.beginWrite()
        
        realm.add(model)
        
        try! realm.commitWrite()
    }

}


extension RMDBTools {
    class func getData() -> [TVLiveModel]{
        var datas = [TVLiveModel]()
        
        guard let urlStr = Bundle.main.path(forResource: "tv", ofType: "plist") else {
            return datas
        }
        
        //        let url = URL(fileURLWithPath: urlStr)
        
        let dict = NSDictionary(contentsOfFile: urlStr)
        
        dict?.enumerateKeysAndObjects({ (key, value, _) in
            let model = TVLiveModel(tvName: key as! String, tvUrlStr: value as! String)
            datas.append(model)
        })
        
        return datas
    }
}













