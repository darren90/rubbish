//
//  RMListModel.h
//  RealmOCDemo
//
//  Created by Fengtf on 2017/3/29.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import <Realm/Realm.h>

typedef enum {
    RMListNews,
    RMListCheats,
    RMListHero,
//    RMListType,
} RMListType;

@interface RMListModel : RLMObject

@property NSInteger ID;

@property NSString * title;

@property NSString * url;

@property NSString  * imgUrl;

@property RMListType listType;

@property NSDate *date;

@end
