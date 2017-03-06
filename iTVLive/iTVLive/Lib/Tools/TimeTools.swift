//
//  Int-Extension.swift
//  iTVshows
//
//  Created by Tengfei on 2017/3/5.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit


class TimeTools : NSObject {
    
    class func getDateFmt() -> DateFormatter{
        //设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        let formateStr = "yyyyMMddHHmm"
        
        let fmt = DateFormatter()
        fmt.dateStyle = .medium
        fmt.timeStyle = .short
        fmt.dateFormat = formateStr
        
        let zone = TimeZone(identifier: "Asia/Shanghai")
        fmt.timeZone = zone
        return fmt
    }
    //传时间戳
    class func timedToDate(time:Double) -> String{
        let date = Date(timeIntervalSince1970: time)
        
        //设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
//        let formateStr = "yyyyMMddHHmm"
//        
//        let fmt = DateFormatter()
//        fmt.dateStyle = .medium
//        fmt.timeStyle = .short
//        fmt.dateFormat = formateStr
//        
//        let zone = TimeZone(identifier: "Asia/Shanghai")
//        fmt.timeZone = zone
        
        let fmtDateStr = getDateFmt().string(from: date)
        //201703050126
        return fmtDateStr
    }
    
    
    
}


