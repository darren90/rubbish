//
//  TFMoviePlayerViewController.swift
//  TVLive
//
//  Created by Tengfei on 2017/3/4.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class TFMoviePlayerViewController: UIViewController {
    
    var player:TTFVideoPlayer = TTFVideoPlayer()
    
    var playUrl:String?{
        didSet{
        }
    }
    var titleStr:String?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(player.view)
        player.view.frame = view.bounds
        player.delegate = self
        
        playVideo()
    }

    
    func playVideo() {
        guard let playUrl = playUrl  else {
            return
        }
        guard let uUrl = URL(string: playUrl) else{
            return
        }
    
        player.playStreamUrl(uUrl, title: titleStr ?? "", seekToPos: 0)
    }
    

}
 

extension TFMoviePlayerViewController : TFVideoPlayerDelegate{
    
    func videoPlayer(_ videoPlayer: TTFVideoPlayer!, didControlBy event: TFVideoPlayerControlEvent) {
        switch event {
        case TFVideoPlayerControlEventTapDone:
            unInstalPlayer()
            dismiss(animated: true, completion: nil)
        default:
            
            break
        }
    }
    
    //播放结束
    func videoPlayer(_ videoPlayer: TTFVideoPlayer!, didPlayToEnd player: VMediaPlayer!) {
         print("播放结束")
    }
    
    //播放出错
    func handle(_ errorCode: TFVideoPlayerErrorCode, customMessage: String!) {
        print("播放出错")
    }
    
    func unInstalPlayer(){
        NotificationCenter.default.removeObserver(self)
        player.pauseContent()
        player.unInstallPlayer()
        player.delegate = nil
        player.view.removeFromSuperview()
        player.view = nil
//        player = nil
        print("---播放器销毁---")
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
}



