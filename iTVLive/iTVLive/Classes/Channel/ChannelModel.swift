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
    var channenlUrl:String?
    
    init(imageName:String,title:String) {
        super.init()
        self.id = title
        self.imgName = imageName
        self.title = title
    }
    
    init(imageName:String,title:String,channenlUrl:String) {
        super.init()
        self.id = title
        self.imgName = imageName
        self.title = title
        self.channenlUrl = channenlUrl
    }
    
    
//    let m1 = ChannelModel(imageName: "box_favourite_normal", title: "热播")
//    let m2 = ChannelModel(imageName: "box_special_normal", title: "特色")
//    let m3 = ChannelModel(imageName: "box_yangshi_normal", title: "央视")
//    let m4 = ChannelModel(imageName: "box_weishi_normal", title: "卫视")
//    let m5 = ChannelModel(imageName: "box_sport_normal", title: "体育")
//    let m6 = ChannelModel(imageName: "box_movie_normal", title: "影视")
//    let m7 = ChannelModel(imageName: "box_conties_normal", title: "地方")
//    let m8 = ChannelModel(imageName: "box_news_panda", title: "熊猫")
//    let m9 = ChannelModel(imageName: "box_game_normal", title: "游戏")
//    let m10 = ChannelModel(imageName: "box_news_normal", title: "资讯")
//    let m11 = ChannelModel(imageName: "box_hd_normal", title: "高清")
//    let m12 = ChannelModel(imageName: "box_caijing_normal", title: "财经")
    
}


