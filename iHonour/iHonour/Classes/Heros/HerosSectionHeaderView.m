//
//  HerosSectionHeaderView.m
//  iHonour
//
//  Created by Tengfei on 2017/3/26.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "HerosSectionHeaderView.h"

@interface HerosSectionHeaderView()

@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation HerosSectionHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setName:(NSString *)name{
    _name = name;
    
    self.titleL.text = name;
}

@end
