//
//  RMLTools.h
//  iHonour
//
//  Created by Tengfei on 2017/3/29.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "RMListModel.h"
#import "NewsModel.h"

@interface RMLTools : NSObject

+ (instancetype)shareTools;

-(void)addOne;

-(void)addCollect:(NewsModel *)newsModel listType:(RMListType)listType;

-(void)delCollect:(RMListModel *)model;

-(void)delCollectWithUrl:(NSString *)url;

-(BOOL)isThisCollected:(NewsModel *)newsModel listType:(RMListType)listType;



-(NSArray *)getAll;

@end
