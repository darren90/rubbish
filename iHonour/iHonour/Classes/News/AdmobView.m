//
//  AdmobView.m
//  iHonour
//
//  Created by Tengfei on 2017/3/26.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "AdmobView.h"

@implementation AdmobView

-(instancetype)init
{
    if (self = [super init]) {
        [self initliza];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initliza];
    }
    return self;
}

-(void)initliza
{
    self.backgroundColor = KColor(239, 239, 244);
    
    GADBannerView *bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    self.bannerView = bannerView;
    self.clipsToBounds = YES;
//    bannerView.frame = self.bounds;
    [self addSubview:self.bannerView];
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
    }];
    
    KLog(@"Google Mobile Ads SDK version: %@", [GADRequest sdkVersion]);
    self.bannerView.adUnitID = self.adUnitID;
    self.bannerView.delegate = self;
}

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView{
    self.hidden = NO;
 
//    KLog(@"--adViewDidReceiveAd-:successs");
}
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error{
    KLog(@"footer-error:%@",error);
 
}

- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView{
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
     self.bannerView.adUnitID = self.adUnitID;
    self.bannerView.frame = self.bounds;
    GADRequest *request = [GADRequest request];
//    request.testDevices = @[@"2077ef9a63d2b398840261c8221a0c9b"];
    [self.bannerView loadRequest:request];
}

@end
