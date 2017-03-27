//
//  AdmobCell.h
//  iHonour
//
//  Created by Tengfei on 2017/3/27.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface AdmobCell : UITableViewCell

+(instancetype)cellWithTableview:(UITableView *)tableView;

@property (strong, nonatomic) GADBannerView *bannerView;

//广告为id
@property (nonatomic,copy)NSString * adUnitID;


@end
