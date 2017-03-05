//
//  TVShowTools.swift
//  TVLive
//
//  Created by Tengfei on 2017/3/4.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class TVLiveTools: NSObject {

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
