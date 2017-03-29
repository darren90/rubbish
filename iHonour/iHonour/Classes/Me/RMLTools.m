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
    return;
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
    return;
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
    return;
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
    
}

-(void)delCollectWithTitle:(NSString *)title{
    
}

-(BOOL)isThisCollected:(NewsModel *)newsModel listType:(RMListType)listType{
    
    
    return NO;
}


-(NSArray *)getAll{
    RLMRealm *realm = [RLMRealm defaultRealm];
//    [realm allObjects:nil];
    
    
    return nil;
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
