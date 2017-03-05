//
//  TVDetailModel.swift
//  iTVshows
//
//  Created by Tengfei on 2017/3/5.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class TVDetailModel: NSObject {
    
    var t:String?
    var st:Double = 0
    var et:Double = 0
    var showTime:String?
    var duration:Int = 0
    
    
    init(dict:[String:AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
