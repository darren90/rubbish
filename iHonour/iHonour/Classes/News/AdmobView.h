//
//  AdmobView.h
//  iHonour
//
//  Created by Tengfei on 2017/3/26.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMobileAds/GoogleMobileAds.h>


@interface AdmobView : UIView<GADBannerViewDelegate>

@property (strong, nonatomic) GADBannerView *bannerView;

//广告为id
@property (nonatomic,copy)NSString * adUnitID;



@end
