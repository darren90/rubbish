//
//  InterfaceController.m
//  WatchDemo Extension
//
//  Created by Fengtf on 2016/12/9.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}
- (IBAction)clickAction {
    NSLog(@"--clickAction---");
//    TwoInterfaceController
    [self pushControllerWithName:@"TwoInterfaceController" context:@{@"key" : @"我是传值001"}];
//    self presentControllerWithNames:<#(nonnull NSArray<NSString *> *)#> contexts:<#(nullable NSArray *)#>

    
}
- (IBAction)goToTable {

    [self pushControllerWithName:@"ThreeInterfaceController" context:@{@"key" : @"我是传值001"}];

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



