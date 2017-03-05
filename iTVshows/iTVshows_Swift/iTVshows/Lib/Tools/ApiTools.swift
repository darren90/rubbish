//
//  ApiTools.swift
//  iTVshows
//
//  Created by Tengfei on 2017/3/5.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class ApiTools: NSObject {
    
    
    // 央视
    static let URL_YS = "http://serv.cbox.cntv.cn/json/zhibo/yangshipindao/ysmc/index.json"
    
    // 卫视
    static let URL_WS = "http://serv.cbox.cntv.cn/json/zhibo/weishipindao/wsmc/index.json"
    
    static let URL_WS_OK = "http://cbox.cntv.cn/json2015/zhiboshy/pdfl/weishi/index.json"
    
    // 地方
    static let URL_DIFANG = "http://serv.cbox.cntv.cn/json/zhibo/difangpindao/dfmc/index.json"
    
    
    static let URL_DIFANG_OK = "http://cbox.cntv.cn/json2015/zhiboshy/pdfl/difang/index.json"
    
    //我拿到的api
    
    //综艺
    static let URL_ZHONGYO = "http://cbox.cntv.cn/json2015/zhiboshy/pdfl/zongyi1/index.json"
    
    //资讯
    static let URL_ZIXUN = "http://cbox.cntv.cn/json2015/zhiboshy/pdfl/zx/index.json"
    
    //财经
    static let URL_CAIJING = "http://cbox.cntv.cn/json2015/zhiboshy/pdfl/caijing/index.json"
    
    //影视
    static let URL_YINGSHI = "http://cbox.cntv.cn/json2015/zhiboshy/pdfl/yingshi/index.json"
    
    //动漫
    static let URL_DONGMAN = "http://cbox.cntv.cn/json2015/zhiboshy/pdfl/dongman/index.json"
    
    //熊猫
    static let URL_PANDA = "http://cbox.cntv.cn/json2015/global/ipanda/live/index.json"
    
    
    
    //详情页面
    
    //eg:   http://api.cntv.cn/epg/epginfo?serviceId=cbox&c=cctv1&d=20170305
    
    //详情页面的地址
    class func getDetailUrl(channelId:String , date:Date) -> String{
        let fmt = TimeTools.getDateFmt()
        let dateStr = fmt.string(from: date)
        let url = " http://api.cntv.cn/epg/epginfo?serviceId=cbox&c=\(channelId)&d=\(dateStr)"
        return url
    }
    
    class func getDetailUrl(channelId:String) -> String{
        let fmt = TimeTools.getDateFmt()
        let dateStr = fmt.string(from: Date())
        let url = " http://api.cntv.cn/epg/epginfo?serviceId=cbox&c=\(channelId)&d=\(dateStr)"
        return url
    }
    
    
    //回放地址
    
    //eg:   http://vdn.apps.cntv.cn/api/liveback.do?channel=cctv3&starttime=201703050132&endtime=201703050251&from=web&url=http://tv.cntv.cn/live/cctv3/
    
    
    //获取回放地址
    class func getLiveBackUrl(channelId:String , st:Double , et:Double) -> String{
        let sts = TimeTools.timedToDate(time: st)
        let ets = TimeTools.timedToDate(time: et)
        
        let url = "http://vdn.apps.cntv.cn/api/liveback.do?channel=\(channelId)&starttime=\(sts)&endtime=\(ets)&from=web&url=http://tv.cntv.cn/live/\(channelId)/"
        
        return url
    }
    
    //eg:  http://vdn.live.cntv.cn/api2/live.do?channel=pa://cctv_p2p_hdcctv1&client=iosapp
    
    //获取直播地址
    class func getLiveUrl(channelId:String) -> String{
        let url = "http://vdn.live.cntv.cn/api2/live.do?channel=pa://cctv_p2p_hd\(channelId)&client=iosapp"
        
        return url
    }
    
  
    class func getChannelImg(channelId:String) -> String{
        let url = "http://t.live.cntv.cn/imagehd/\(channelId)_01.png"
        return url
    }
    
    class func getNowPlayShow(channelId:String) -> String{
        let url = "http://api.cntv.cn/epg/nowepg?serviceId=cbox&c=\(channelId)"
        
        return url
    }

}












