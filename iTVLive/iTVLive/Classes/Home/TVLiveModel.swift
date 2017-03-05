
//
//  TVLiveModel.swift
//  TVLive
//
//  Created by Tengfei on 2017/3/4.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class TVLiveModel: NSObject {
    
    var tvName:String?
    
    var tvPlayUrlStr:String?
    
    var tvPlayUrl:URL?
    
    
    override init() {
        super.init()
    }
    
    init(tvName:String,tvUrlStr:String) {
        super.init()
        
        self.tvName = tvName
        tvPlayUrlStr = tvUrlStr
        self.tvPlayUrl = URL(fileURLWithPath: tvUrlStr)
 
    }
    
}
