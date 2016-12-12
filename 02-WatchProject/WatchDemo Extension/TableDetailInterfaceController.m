//
//  TableDetailInterfaceController.m
//  01-WatchProject
//
//  Created by Tengfei on 2016/12/12.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "TableDetailInterfaceController.h"
#import "TableModel.h"

@interface TableDetailInterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *titleL;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *numL;

@end

@implementation TableDetailInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    TableModel *model = context;
    NSString *title = model.title;//[context objectForKey:@"title"];
    NSString *price = model.price;//[context objectForKey:@"price"];

    [_titleL setText:title];
    [_numL setText:price];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



