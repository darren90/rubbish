//
//  AdmobCell.m
//  iHonour
//
//  Created by Tengfei on 2017/3/27.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "AdmobCell.h"


@implementation AdmobCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)cellWithTableview:(UITableView *)tableView{
    static NSString *ID = @"AdmobCell";
    AdmobCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[AdmobCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
    
    KLog(@"--adViewDidReceiveAd-:successs");
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
