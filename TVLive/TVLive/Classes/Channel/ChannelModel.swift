//
//  ChannelModel.swift
//  TVLive
//
//  Created by Tengfei on 2017/3/5.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class ChannelModel: NSObject {

    var imgName:String?
    var title:String?
    var id:String?
    
    init(imageName:String,title:String) {
        super.init()
        self.id = title
        self.imgName = imageName
        self.title = title
    }
    
}


