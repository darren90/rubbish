//
//  BaseViewController.h
//  FileMaster
//
//  Created by Tengfei on 16/3/3.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

// loading状态
typedef NS_ENUM(NSUInteger, RequestState) {
    RequestStateNone,       // 没有错误  --> 移除loading
    RequestStateNoNet,      // 没有网络  --> 显示错误界面loading
    RequestStateNoData,     // 没有数据  --> 显示没有数据的界面loading
};


@interface BaseViewController : UIViewController

//@property (nonatomic, weak) UIImageView *noDataView;

@property (nonatomic,strong)UIImage * nodataImgage;


//请求
-(void)request;

//开始动画
-(void)startAnimate;


//结束动画
-(void)stopAnimate;


//请求后的状态
@property (nonatomic,assign)RequestState requestState;

@end
