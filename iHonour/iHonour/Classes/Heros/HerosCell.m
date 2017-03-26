//
//  HerosCell.m
//  iHonour
//
//  Created by Tengfei on 2017/3/26.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "HerosCell.h"
#import <YYKit.h>

@interface HerosCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation HerosCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setModel:(HerosModel *)model{
    _model = model;
    
    [self.imgView setImageWithURL:[NSURL URLWithString:model.imgUrl] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
    self.titleL.text = model.name;
}

@end
