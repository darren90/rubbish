//
//  HttpManager.h
//  TestAFN
//
//  Created by Tengfei on 2017/5/4.
//  Copyright © 2017年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpManager : NSObject
#define kTimeOutInterval 30 // 请求超时的时间
typedef void (^SuccessBlock)(NSDictionary *dict, BOOL success); // 访问成功block
typedef void (^AFNErrorBlock)(NSError *error); // 访问失败block

+ (void)getWithUrl:(NSString *)url Params:(NSDictionary *)param Success:(SuccessBlock)success fail:(AFNErrorBlock)fail;


@end
