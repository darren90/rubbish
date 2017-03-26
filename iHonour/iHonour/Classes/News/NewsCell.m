//
//  NewsCell.m
//  iHonour
//
//  Created by Tengfei on 2017/3/26.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "NewsCell.h"
#import <YYKit.h>

@interface NewsCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation NewsCell


+(instancetype)cellWithTableview:(UITableView *)tableView{
    static NSString *ID = @"news";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[NSBundle mainBundle]loadNibNamed:@"NewsCell" owner:nil options:nil].firstObject;
    }
 
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(NewsModel *)model{
    _model = model;
//    [imageView yy_setImageWithURL:url options:YYWebImageOptionProgressiveBlur ｜ YYWebImageOptionSetImageWithFadeAnimation];

    [self.imgView setImageWithURL:[NSURL URLWithString:model.imgUrl] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    self.titleL.text = model.title;
}

@end
