//
//  TVListModel.swift
//  iTVshows
//
//  Created by Tengfei on 2017/3/5.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class TVListModel: NSObject {
    
    //有用的
    var order:Int = 1
    var title:String?
    var channelId:String?
    var t:String?//正在播放的视频
    var iconUrl:URL?//显示的图片
    
    //无用的
    var channelImg:String?
    var bigImgUrl:String?
    var imgUrl:String?
    var initial:String?
    var p2pUrl:String?
    var shareUrl:String?
    var liveUrl:String?
    var autoImg:String?
    var newChannelImg:String?
    
    
    init(dict:[String:AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
        
        guard let channelId = channelId else{
            return
        }
        let uurl = ApiTools.getChannelImg(channelId: channelId)
        iconUrl = URL(string: uurl)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
    
}
