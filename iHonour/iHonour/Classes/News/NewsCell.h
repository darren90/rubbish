//
//  NewsCell.h
//  iHonour
//
//  Created by Tengfei on 2017/3/26.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NewsCell : UITableViewCell

+(instancetype)cellWithTableview:(UITableView *)tableview;

@property (nonatomic,strong)NewsModel * model;


@end
