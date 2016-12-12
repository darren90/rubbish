//
//  TwoInterfaceController.m
//  01-WatchProject
//
//  Created by Fengtf on 2016/12/10.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "TwoInterfaceController.h"

@interface TwoInterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *titleL;

@end

@implementation TwoInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.

    NSString *str = (NSString *)[context objectForKey:@"key"];
    [self.titleL setText:str];
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



