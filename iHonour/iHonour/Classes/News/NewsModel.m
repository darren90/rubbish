//
//  NewsModel.m
//  iHonour
//
//  Created by Tengfei on 2017/3/26.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

-(instancetype)initWith:(NSString *)title url:(NSString *)url imgUrl:(NSString *)imgUrl{
    self.title = title;
    self.url = url;
    self.imgUrl = imgUrl;
    
    return self;
}

+(instancetype)modelWith:(NSString *)title url:(NSString *)url imgUrl:(NSString *)imgUrl{
    NewsModel *m = [[NewsModel alloc]init];
    m.title = title;
    m.url = url;
    m.imgUrl = imgUrl;
    return m;
}

@end
