//
//  TFWebView.m
//  WebViewWithProgressLine
//
//  Created by Fengtf on 2017/3/25.
//  Copyright © 2017年 Michael. All rights reserved.
//

#import "TFWebView.h"

@interface TFWebView()

@property (weak, nonatomic) CALayer *progresslayer;


@property (nonatomic,weak) UIView *progressView;


@end

@implementation TFWebView


//-(instancetype)init{
  //  if (self = [super init]) {
   //     [self setUpProgress];
   // }
   // return self;
//}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpProgress];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration{
    if (self = [super initWithFrame:frame configuration:configuration]) {
        [self setUpProgress];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];

    self.progressView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 3);

}

-(void)setUpProgress{

    //添加属性监听
    [self addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
 

    //进度条
    UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 3)];
    progress.backgroundColor = [UIColor clearColor];
    [self addSubview:progress];
    self.progressView = progress;

    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 3);
//    rgb(45, 165, 252)
    layer.backgroundColor = [UIColor colorWithRed:45/255.0 green:165/255.0 blue:252/255.0 alpha:1.0].CGColor;
    [progress.layer addSublayer:layer];
    self.progresslayer = layer;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
//        NSLog(@"%@", change);
        self.progresslayer.opacity = 1;
        self.progresslayer.frame = CGRectMake(0, 0, self.bounds.size.width * [change[NSKeyValueChangeNewKey] floatValue], 3);
        if ([change[NSKeyValueChangeNewKey] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}



- (void)dealloc{
    [self removeObserver:self forKeyPath:@"estimatedProgress"];
}



@end
