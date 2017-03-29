//
//  HerosModel.h
//  iHonour
//
//  Created by Tengfei on 2017/3/26.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HerosModel : NSObject


@property (nonatomic,copy)NSString * name;


@property (nonatomic,copy)NSString * url;


@property (nonatomic,copy)NSString * imgUrl;

//类别
@property (nonatomic,copy)NSString * typeStr;


+(instancetype)modelWith:(NSString *)name url:(NSString *)url imgUrl:(NSString *)imgUrl type:(NSString *)type;


@end
