//
//  AppDelegate.swift
//  TVLive
//
//  Created by Tengfei on 2017/3/3.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit
import GoogleMobileAds


let KUMAPPKEy = "58b98cf0ae1bf87b7c001e64"
let KBuglyAPPID = "96d500923b"
let KBuglyAPPKey = "ce8c2358-5905-4415-a4b1-79cd7357475a"


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //配置admob
        GADMobileAds.configure(withApplicationID: "ca-app-pub-8145075793156354~4703918622")//"ca-app-pub-3940256099942544~1458002511"
        
        //设置全局的tabbar的默认颜色 rgb(61, 168, 245)
        UITabBar.appearance().tintColor = KCommonColor
        UINavigationBar.appearance().tintColor = KCommonColor
        
        umengTrack()
        setupBugly()
        setupUMsocial()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    
    // MARK: - 友盟统计
    func umengTrack() {
        MobClick.setLogEnabled(true)
        let config = UMAnalyticsConfig.sharedInstance()
        config!.appKey = KUMAPPKEy
        //        config.secret =
        MobClick.start(withConfigure: config)
    }
    
    // MARK: - bugly
    func setupBugly() {
        // Get the default config
        let config = BuglyConfig()
        #if DEBUG
            config.debugMode = true
        #endif
        config.reportLogLevel = BuglyLogLevel.warn
        
        config.channel = "TFStore"
        Bugly.start(withAppId: KBuglyAPPID, config: config)
        
        Bugly.setTag(1799);
        
        Bugly.setUserIdentifier(UIDevice.current.name)
        
        Bugly.setUserValue(ProcessInfo.processInfo.processName, forKey: "Process")
    }
    
    // MARK: - bugly
    func setupUMsocial() {
        let umMangerr = UMSocialManager.default()
        umMangerr!.openLog(true)
        umMangerr!.umSocialAppkey = KUMAPPKEy
        
        //微信
        umMangerr!.setPlaform(.wechatSession, appKey: "wxdc1e388c3822c80b", appSecret: "3baf1193c85774b3fd9d18447d76cab0", redirectURL: "http://mobile.umeng.com/social")
        
        //qq
        umMangerr!.setPlaform(.QQ, appKey: "100424468", appSecret: nil, redirectURL: "http://mobile.umeng.com/social")
        
        //新浪
        umMangerr!.setPlaform(.sina, appKey: "2949226810", appSecret: "ad08040031457a934608f9118a8577e4", redirectURL: "http://mobile.umeng.com/social")
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let result = UMSocialManager.default().handleOpen(url)
        if !result {
            
        }
        return result
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        let result = UMSocialManager.default().handleOpen(url)
        if !result {
            
        }
        return result
    }
}

