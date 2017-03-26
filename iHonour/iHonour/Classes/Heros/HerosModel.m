//
//  HerosModel.m
//  iHonour
//
//  Created by Tengfei on 2017/3/26.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "HerosModel.h"

@implementation HerosModel

+(instancetype)modelWith:(NSString *)name url:(NSString *)url imgUrl:(NSString *)imgUrl type:(NSString *)type{
    HerosModel *m = [[HerosModel alloc]init];
    m.url = url;
    m.name = name;
    m.imgUrl = imgUrl;
    m.typeStr = type;
    
    return m;
}

@end
