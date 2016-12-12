//
//  TableRow.m
//  01-WatchProject
//
//  Created by Fengtf on 2016/12/10.
//  Copyright © 2016年 ftf. All rights reserved.
//

#import "TableRow.h"

@interface TableRow()


@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *titleL;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *numLab;

@end

@implementation TableRow

-(void)setTableModel:(TableModel *)tableModel
{
    _tableModel = tableModel;
    
    [_titleL setText:tableModel.title];
    [_numLab setText:tableModel.price];
}

@end
