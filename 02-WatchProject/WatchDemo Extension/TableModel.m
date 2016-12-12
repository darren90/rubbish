//
//  TableModel.m
//  01-WatchProject
//
//  Created by Fengtf on 2016/12/12.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "TableModel.h"

@implementation TableModel

- (instancetype)initWithTilte:(NSString *)title price:(NSString *)price
{
    self = [super init];
    if (self) {
        self.title = title;
        self.price = price;
    }
    return self;
}


@end
