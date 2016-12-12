//
//  InterfaceController.m
//  WatchDemo Extension
//
//  Created by Fengtf on 2016/12/9.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "InterfaceController.h"
#import "TableModel.h"
#import "TableRow.h"

@interface InterfaceController()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *table;
@property (nonatomic, strong) NSMutableArray *bookArray;
@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    
    [self reloadTable];
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

- (void)reloadTable{
    // 数据源
    NSArray *data = @[@{@"title":@"《谁说咸鱼没有梦想》",@"price":@"￥30.00"},
                      @{@"title":@"《不要让未来的你讨厌现在的自己》",@"price":@"￥32.80"},
                      @{@"title":@"《引爆点》",@"price":@"￥52.80"},
                      @{@"title":@"《从此不做月光族》",@"price":@"￥25.90"},
                      @{@"title":@"《少有人走的路》",@"price":@"￥13.00"}];
    
    // 设置行数和类型
    [_table setNumberOfRows:data.count withRowType:@"TableRow"];
    
    // 遍历赋值
    for (int index = 0; index < data.count; index++) {
        TableModel *model = [[TableModel alloc] initWithTilte:data[index][@"title"] price:data[index][@"price"]];
        [self.bookArray addObject:model];
        TableRow *rowController = [_table rowControllerAtIndex:index];
        rowController.tableModel = model;
    }
}

-(id)contextForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex
{
    return self.bookArray[rowIndex];
}

- (NSMutableArray *)bookArray {
    if (!_bookArray) {
        _bookArray = [NSMutableArray array];
    }
    return _bookArray;
}

@end













