//
//  TableModel.h
//  01-WatchProject
//
//  Created by Fengtf on 2016/12/12.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableModel : NSObject
//标题
@property (nonatomic, copy) NSString *title;
//价格
@property (nonatomic, copy) NSString *price;
//初始化方法
- (instancetype)initWithTilte:(NSString *)title price:(NSString *)price;
@end
