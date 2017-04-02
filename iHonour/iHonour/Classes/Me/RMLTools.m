//
//  RMLTools.m
//  iHonour
//
//  Created by Tengfei on 2017/3/29.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "RMLTools.h"

@implementation RMLTools

+ (instancetype)shareTools
{
    static RMLTools *sharedData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData = [[self alloc] init];
    });
    return sharedData;
}

+(void)initialize{
    [self initDB];
}

+(void)initDB{
    
    NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [docPath objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:@"iHonour.realm"];
    NSLog(@"relam path = %@",filePath);
    
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [NSURL fileURLWithPath:filePath];
    
    //    RLMRealm *realm = [RLMRealm realmWithConfiguration:config error:nil];
    
    [RLMRealmConfiguration setDefaultConfiguration:config];
}

 
-(void)addOne{
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    RMListModel *m = [[RMListModel alloc]init];
    m.title = @"rrmj001";
    m.date = [NSDate new];
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:m];
//    [realm addObject:m];
    [realm commitWriteTransaction];
}

-(void)addCollect:(NewsModel *)newsModel listType:(RMListType)listType{
    
    RMListModel *m = [self getRMLModel:newsModel];
    if (!m) {
        return;
    }
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    m.listType = listType;
   
    [realm beginWriteTransaction];
//    [realm addOrUpdateObject:m];
    [realm addObject:m];
    [realm commitWriteTransaction];
}

-(void)delCollect:(RMListModel *)model{
    RLMRealm *realm = [RLMRealm defaultRealm];
//    RMListModel *m = [self getRMLModel:model];
    
    [realm beginWriteTransaction];
    [realm deleteObject:model];
    [realm commitWriteTransaction];
}

-(void)delCollectWithTitle:(NSString *)title{
    
}

-(BOOL)isThisCollected:(NewsModel *)newsModel listType:(RMListType)listType{
    
    
    return NO;
}

//返回NewsModel 的数组
-(NSArray *)getAll{
//    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults *sets = [RMListModel allObjects];
//    NSMutableArray *res = [NSMutableArray arrayWithCapacity:sets.count];
//    for (RMListModel *rml in sets) {
//        NewsModel *m = [self getNesModel:rml];
//        [res addObject:m];
//    }
    
    NSMutableArray *res = [NSMutableArray arrayWithCapacity:sets.count];
    for (RMListModel *rml in sets) {
        [res addObject:rml];
    }
    return res;
}

-(NewsModel *)getNesModel:(RMListModel *)newsModel{
    NewsModel *m = [[NewsModel alloc]init];
    m.title = newsModel.title;
    m.url = newsModel.url;
    m.imgUrl = newsModel.imgUrl;
    return m;
}


-(RMListModel *)getRMLModel:(NewsModel *)newsModel{
    RMListModel *m = [[RMListModel alloc]init];
    m.title = newsModel.title;
    m.url = newsModel.url;
    m.imgUrl = newsModel.imgUrl;
    m.date = [NSDate date];
    return m;
}


@end
