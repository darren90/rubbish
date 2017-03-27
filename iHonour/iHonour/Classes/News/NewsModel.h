//
//  NewsModel.h
//  iHonour
//
//  Created by Tengfei on 2017/3/26.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject


@property (nonatomic,copy)NSString * title;


@property (nonatomic,copy)NSString * url;

@property (nonatomic,copy)NSString * imgUrl;

//是否为广告
@property (nonatomic,assign)BOOL isAdmob;

-(instancetype)initWith:(NSString *)title url:(NSString *)url imgUrl:(NSString *)imgUrl;


+(instancetype)modelWith:(NSString *)title url:(NSString *)url imgUrl:(NSString *)imgUrl;

@end
