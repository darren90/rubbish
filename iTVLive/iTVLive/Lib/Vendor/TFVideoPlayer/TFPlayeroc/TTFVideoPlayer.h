//
//  TFVideoPlayer.m
//  FileMaster
//
//  Created by Tengfei on 16/6/16.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTFVideoPlayerView.h"
#import "Vitamio.h"


typedef enum {
    // The video was flagged as blocked due to licensing restrictions (geo or device).
    kVideoPlayerErrorVideoBlocked = 900,
    
    // There was an error fetching the stream.
    kVideoPlayerErrorFetchStreamError,
    
    // Could not find the stream type for video.
    kVideoPlayerErrorStreamNotFound,
    
    // There was an error loading the video as an asset.
    kVideoPlayerErrorAssetLoadError,
    
    // There was an error loading the video's duration.
    kVideoPlayerErrorDurationLoadError,
    
    // AVPlayer failed to load the asset.
    kVideoPlayerErrorAVPlayerFail,
    
    // AVPlayerItem failed to load the asset.
    kVideoPlayerErrorAVPlayerItemFail,
    
    // Chromecast failed to load the stream.
    kVideoPlayerErrorChromecastLoadFail,
    
    // There was an unknown error.
    kVideoPlayerErrorUnknown,
    
} TFVideoPlayerErrorCode;


typedef enum {
    TFVideoPlayerStateUnknown,
    TFVideoPlayerStateContentLoading,
    TFVideoPlayerStateContentPlaying,
    TFVideoPlayerStateContentPaused,
    TFVideoPlayerStateSuspend,
    TFVideoPlayerStateDismissed,
    TFVideoPlayerStateError
} TFVideoPlayerState;

typedef enum {
    TFVideoPlayerControlEventTapPlayerView,
    TFVideoPlayerControlEventTapNext,
    TFVideoPlayerControlEventTapPrevious,
    TFVideoPlayerControlEventTapDone,
    TFVideoPlayerControlEventTapFullScreen,
    TFVideoPlayerControlEventTapCaption,
    TFVideoPlayerControlEventTapVideoQuality,
    TFVideoPlayerControlEventSwipeNext,
    TFVideoPlayerControlEventSwipePrevious,
    TFVideoPlayerControlEventShare,//分享
    TFVideoPlayerControlEventPause,//暂停
    TFVideoPlayerControlEventPlay,//播放
    TFVideoplayercontroleventClarity,//清晰度
} TFVideoPlayerControlEvent;


@class TTFVideoPlayer;
@protocol TFVideoPlayerDelegate <NSObject>
@optional
- (BOOL)shouldVideoPlayer:(TTFVideoPlayer*)videoPlayer changeStateTo:(TFVideoPlayerState)toState;
- (void)videoPlayer:(TTFVideoPlayer*)videoPlayer willChangeStateTo:(TFVideoPlayerState)toState;

- (void)videoPlayer:(TTFVideoPlayer*)videoPlayer didControlByEvent:(TFVideoPlayerControlEvent)event;
- (void)videoPlayer:(TTFVideoPlayer*)videoPlayer didChangeSubtitleFrom:(NSString*)fronLang to:(NSString*)toLang;
- (void)videoPlayer:(TTFVideoPlayer*)videoPlayer willChangeOrientationTo:(UIInterfaceOrientation)orientation;
- (void)videoPlayer:(TTFVideoPlayer*)videoPlayer didChangeOrientationFrom:(UIInterfaceOrientation)orientation;

//use


- (void)videoPlayer:(TTFVideoPlayer*)videoPlayer didChangeStateFrom:(TFVideoPlayerState)fromState;

- (void)videoPlayer:(TTFVideoPlayer*)videoPlayer didPlayToEnd:(VMediaPlayer *)player;//播放结束

- (void)handleErrorCode:(TFVideoPlayerErrorCode)errorCode customMessage:(NSString*)customMessage;//播放出错

@end


@interface TTFVideoPlayer : NSObject<VMediaPlayerDelegate>

@property (nonatomic, strong) TTFVideoPlayerView *view;

@property (nonatomic, strong) VMediaPlayer       *mMPayer;

@property (nonatomic, weak) id<TFVideoPlayerDelegate> delegate;

/** 单例的方式创建播放器 */
+(TTFVideoPlayer *) sharedPlayer;



@property (nonatomic,copy)NSString * playUrl;


//当前播放到第几秒
@property (nonatomic,assign)double currentDuraion;

- (id)initWithVideoPlayerView:(TTFVideoPlayerView*)videoPlayerView;

//正常播放视频的时候调用这个  时间：秒
-(void)playStreamUrl:(NSURL*)url title:(NSString*)title seekToPos:(long)pos;
//正在播放的过程中切换了播放地址，进行播放的时候用这个  时间：秒
//-(void)playChangeStreamUrl:(NSURL*)url title:(NSString*)title seekToPos:(long)pos;


/** 播放 */
- (void)playContent;
/** 暂停 */
- (void)pauseContent;
#pragma mark - 卸载播放器
-(void)unInstallPlayer;

-(void)playerWillAppear;
-(void)playerDidDisAppear;


/**
 *  是否播放的是本地资源
 */
@property (nonatomic,assign)BOOL isPlayLocalFile;//我增加的字段，以便播放本地视频的时候视频不受打扰


//后加的参数
@property (nonatomic, assign) BOOL isFullScreen;
@property (nonatomic, assign) BOOL forceRotate;
@property (nonatomic, assign) UIInterfaceOrientation visibleInterfaceOrientation;
@property (nonatomic, assign) CGRect landscapeFrame;
@property (nonatomic, assign) CGRect portraitFrame;

 
/***  视频当前播放到那个时间 单位：秒s */
@property (nonatomic,assign)double currentDuation;
/***  视频总时间 单位：秒s */
@property (nonatomic,assign)double totalDuraion;






@end










