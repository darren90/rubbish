//
//  AdmobCell.swift
//  iTVshows
//
//  Created by Tengfei on 2017/2/18.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AdmobCell: UITableViewCell,GADBannerViewDelegate {
    @IBOutlet weak var bannerView: GADBannerView!
    
    var rootVc:UIViewController?
    
    class func cellWithTableView(tableView:UITableView) -> AdmobCell{
        let id = "AdmobCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: id) as? AdmobCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed(id, owner: nil, options: nil)?.first as? AdmobCell
        }
        return cell!
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        
        print("Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")
        GADRequest.description()
        bannerView.adUnitID = "ca-app-pub-8145075793156354/6341345022"
        bannerView.rootViewController = rootVc
        bannerView.delegate = self
        let request = GADRequest()
//        if deviceId != nil {
//            request.testDevices = [deviceId!]
//        }
        bannerView.load(request)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bannerView.rootViewController = rootVc
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
//        print("--GADBannerView-file:\(error)");
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
//        print("--GADBannerView--success")
    }
}
