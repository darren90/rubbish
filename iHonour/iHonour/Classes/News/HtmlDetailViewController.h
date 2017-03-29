//
//  HtmlDetailViewController.h
//  iHonour
//
//  Created by Tengfei on 2017/3/26.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "BaseViewController.h"
#import "NewsModel.h"
#import "RMListModel.h"

typedef enum {
    Admob_News_Bottom,
    Admob_Cheats_Bottom,
    Admob_Heros_Bottom,
} AdmobType;

@interface HtmlDetailViewController : BaseViewController


@property (nonatomic,copy)NSString * titleStr;

@property (nonatomic,copy)NSString * detailUrl;

@property (nonatomic,assign)AdmobType adType;

@property (nonatomic,strong)NewsModel *newsModel;

@property (nonatomic,assign)RMListType listType;

@end
