//
//  TFVideoPlayerView.swift
//  iTVLive
//
//  Created by Fengtf on 2017/3/6.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class TFVideoPlayerView: UIView {
    @IBOutlet weak var startPauseBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var fullscreenBtn: UIButton!
    @IBOutlet weak var lockBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var curPosLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var progressSld: TFVSegmentSlider!
    @IBOutlet weak var progressCacheView: UIProgressView!//缓冲的view


    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var carrierView: UIView!

    @IBOutlet weak var loadbgView: UIView!
    @IBOutlet weak var bubbleMsgLabel: UILabel!
     @IBOutlet weak var activityView: UIActivityIndicatorView!

    @IBOutlet weak var topControl: UIView!
    @IBOutlet weak var bottomControl: UIView!


    //播放器对象
    lazy var mMPayer: VMediaPlayer = VMediaPlayer.sharedInstance()


    

}


extension TFVideoPlayerView{


    func initialize(){
        mMPayer.setupPlayer(withCarrierView: carrierView, with: self)
    }


    func playVideo(url: URL , title: String , seekPos: Double ){
        quickStopVideo()

        
    }

    func quickStopVideo(){
        mMPayer.reset()


    }

}

extension TFVideoPlayerView : VMediaPlayerDelegate {

    //MARK: --- 必须的方法
    //MARK: --- 即将播放
    func mediaPlayer(_ player: VMediaPlayer!, didPrepared arg: Any!) {

    }

    //MARK: --- 播放完毕
    func mediaPlayer(_ player: VMediaPlayer!, playbackComplete arg: Any!) {

    }

    //MARK: --- 播放失败
    func mediaPlayer(_ player: VMediaPlayer!, error arg: Any!) {

    }

    //MARK: --- 选择实现的方法

    func mediaPlayer(_ player: VMediaPlayer!, info arg: Any!) {

    }





}























