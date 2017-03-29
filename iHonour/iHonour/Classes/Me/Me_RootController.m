//
//  Me_RootController.m
//  iHonour
//
//  Created by Tengfei on 2017/3/28.
//  Copyright © 2017年 ftf. All rights reserved.
//

#import "Me_RootController.h"
#import <Realm/Realm.h>
#import "RMListModel.h"

@interface Me_RootController ()

@end

@implementation Me_RootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initDB{
    NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [docPath objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:@"Tengfei.realm"];
    NSLog(@"数据库目录 = %@",filePath);

    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [NSURL fileURLWithPath:filePath];

    //    RLMRealm *realm = [RLMRealm realmWithConfiguration:config error:nil];

    [RLMRealmConfiguration setDefaultConfiguration:config];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self addOne];
}

-(void)addOne{
    RLMRealm *realm = [RLMRealm defaultRealm];

    RMListModel *m = [[RMListModel alloc]init];
    m.name = @"rrmj001";
    m.date = [NSDate new];
    [realm beginWriteTransaction];
    //    [realm addOrUpdateObject:m];
    [realm addObject:m];
    [realm commitWriteTransaction];
}


@end
