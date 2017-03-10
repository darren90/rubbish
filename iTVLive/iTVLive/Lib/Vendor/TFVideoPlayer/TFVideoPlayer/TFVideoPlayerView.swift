//
//  TFVideoPlayerView.swift
//  iTVLive
//
//  Created by Fengtf on 2017/3/6.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

enum TTVideoPlayerControlEvent{
    case Back //返回
    case Play  //播放
    case Pause //暂定
    case FullScreen //全屏
    case Tap        //点击屏幕
    case Lock        //锁屏
}

protocol TTVideoPlayerViewDelegate {
    //事件控制
    func videoPlayerDidControlByEvent(event: TTVideoPlayerControlEvent)

    //出错
    func videoPlayerHandleErrorCode(errorMsg: String)

    //播放结束
    func  videoPlayerDidPlayToEnd()
}

class TFVideoPlayerView: UIView {
    @IBOutlet weak var startPauseBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var fullscreenBtn: UIButton!
    @IBOutlet weak var lockBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var curPosLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var progressSld: UISlider!
    @IBOutlet weak var progressCacheView: UIProgressView!//缓冲的view
    @IBOutlet weak var downloadRateLabel: UILabel!//网速显示


    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var carrierView: UIView!

    @IBOutlet weak var loadbgView: UIView!
    @IBOutlet weak var bubbleMsgLabel: UILabel!
     @IBOutlet weak var activityView: UIActivityIndicatorView!

    @IBOutlet weak var topControl: UIView!
    @IBOutlet weak var bottomControl: UIView!

    //手势
    @IBOutlet weak var singleGesture: UITapGestureRecognizer!
    @IBOutlet weak var doubleGesture: UITapGestureRecognizer!

    //播放器对象
    lazy var mMPayer: VMediaPlayer = VMediaPlayer.sharedInstance()

    var mSyncSeekTimer: Timer?

    var isBeforePlaying: Bool = false
    var mDuration: Double = 0.0       //单位：秒
    var mCurPostion: Double = 0.0     //单位：秒
    var progressDragging: Bool = false

    var delegate: TTVideoPlayerViewDelegate?
    var isPlayLocalFile: Bool = false
    var lastWatchPos: Int = 0
    var isLockBtnEnable: Bool = false

//MARK: --- 系统方法

    override func awakeFromNib() {
        super.awakeFromNib()

        initialize()
        initializeView()
    }

    class func sharePlayerView() -> TFVideoPlayerView{
        let view = Bundle.main.loadNibNamed("TFVideoPlayerView", owner: nil, options: nil)?.first as! TFVideoPlayerView
        return view
    }


    deinit {
        NotificationCenter.default.removeObserver(self)

        unInstallPlayer()
    }

    //MARK: --- 开始暂停
    @IBAction func startPauseButtonAcion(_ sender: UIButton) {
        if isLockBtnEnable {
            return
        }

        if sender.isSelected{
            playContent()
            setPlayButtonsSelected(false)
        }else{
            pauseContent()
            setPlayButtonsSelected(true)
        }

        
    }
    //MARK: --- 锁屏
    @IBAction func lockButtonClick(_ sender: UIButton) {
        isLockBtnEnable = !isLockBtnEnable

        if isLockBtnEnable == true {
            //锁屏

            lockBtn.setImage(UIImage(named:"icon_player_lock-nor@2x.png"), for: .normal)

            self.topControl.isHidden = true
            self.bottomControl.isHidden = true
        }else{
            //开锁
            lockBtn.setImage(UIImage(named:"icon_player_unlock-nor@2x.png"), for: .normal)

            self.topControl.isHidden = false
            self.bottomControl.isHidden = false
        }

        lockBtn.isHidden = true
        delegate?.videoPlayerDidControlByEvent(event: .Lock)
    }

    //MARK: --- 全屏-切换
    @IBAction func fullscreenButtonTapped(_ sender: UIButton) {
//        delegate?.videoPlayerDidControlByEvent(event: .FullScreen)
        sender.isSelected = !sender.isSelected

        fulllScreenAtion()
    }

    //MARK: --- 返回
    @IBAction func goBackButtonAction(_ sender: UIButton) {
        delegate?.videoPlayerDidControlByEvent(event: .Back)
    }
 
     //MARK: --- 进度条 -- down
    @IBAction func progressSliderDownAction(_ sender: UISlider) {
        progressDragging = true
    }

     //MARK: --- 进度条 -- up
    @IBAction func progressSliderUpAction(_ sender: UISlider) {
        startActivityWithMsg(msg: "Buffering")
        let value = Double(sender.value)
        mMPayer.seek(to: Int(value * 1000.0 * mDuration))

        if mMPayer.isPlaying() { //没有播放，的话，开始播放
            playContent()
        }
    }

     //MARK: --- 进度条 -- 进度值变化
    @IBAction func dragProgressSliderAction(_ sender: UISlider) {
        let value = Double(sender.value)
        let cur = Double(value * 1000.0 * mDuration)
        curPosLabel.text = timeToHumanStr(ms: cur)
    }

    //MARK: --- 手势 - 单击
    @IBAction func handleSingleTap(_ sender: UITapGestureRecognizer) {
        if isLockBtnEnable {
            lockBtn.isHidden = !lockBtn.isHidden
            UIApplication.shared.setStatusBarHidden(self.bottomControl.isHidden, with: .none)
        }else{
            topControl.isHidden = !topControl.isHidden
            bottomControl.isHidden = !bottomControl.isHidden
//            self.topControl.isHidden = !self.topControl.isHidden
        }

        delegate?.videoPlayerDidControlByEvent(event: .Tap)
    }

    //MARK: --- 手势 - 双击
    @IBAction func handleTwoTap2(_ sender: UITapGestureRecognizer) {
        if isLockBtnEnable == true {
            return
        }

        startPauseButtonAcion(startPauseBtn)
    }

}

//MARK: --- 自定义方法 -- view
extension TFVideoPlayerView {

    func initializeView(){
        loadbgView.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        topControl.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        bottomControl.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        singleGesture.require(toFail: doubleGesture)//只有当doubleTapGesture识别失败的时候(即识别出这不是双击操作)，singleTapGesture才能开始识别。
        lockBtn.setImage(UIImage(named:"unlock"), for: .normal)
        progressSld.setThumbImage(UIImage(named: "pb-seek-bar-btn@2x.png"), for: .normal)
        progressSld.minimumTrackTintColor = UIColor.green
        progressSld.maximumTrackTintColor = UIColor.lightGray

        NotificationCenter.default.addObserver(self, selector: #selector(self.onOrientationChanged), name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation, object: nil)
    }

    func stopActivity(){
        bubbleMsgLabel.isHidden = true
        bubbleMsgLabel.text = nil
        activityView.stopAnimating()
    }

    func setBtnEnableStatus(enable: Bool){
        startPauseBtn.isEnabled = enable
        progressSld.isEnabled = enable
        fullscreenBtn.isEnabled = enable
        lockBtn.isEnabled = enable
    }

    //MARK: --- 设置播放按钮的状态 --> 图标切换
    func setPlayButtonsSelected(_ isSeldct: Bool){
        startPauseBtn.isSelected = isSeldct
    }

    func startActivityWithMsg(msg: String?){
        var msg = msg
        if isPlayLocalFile == true {
            return
        }

        if msg == nil {
            msg = "拼命的加载中..."
        }

        bubbleMsgLabel.isHidden = false
        bubbleMsgLabel.text = msg

        activityView.startAnimating()
    }

    func hiddenTopAndBottom(){
        if bottomControl.isHidden == false {
            topControl.isHidden = true
            bottomControl.isHidden = true
        }
        if isLockBtnEnable == false {
            lockBtn.isHidden = true
        }

    }

}

//MARK: --- 自定义方法 -- player
extension TFVideoPlayerView{

    func initialize(){
        mMPayer.setupPlayer(withCarrierView: carrierView, with: self)

        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidEnterForeground), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidEnterForeground), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
    }

    func applicationDidEnterForeground(){
        if mMPayer.isPlaying() == false {
            if isBeforePlaying{
                isBeforePlaying = false;
                setPlayButtonsSelected(false)
                mMPayer.start()
            }
        }
    }

    func applicationDidEnterBackground(){
        if mMPayer.isPlaying() {
            if isBeforePlaying{
                mMPayer.pause()
                setPlayButtonsSelected(true)
                isBeforePlaying = true;
            }
        }
    }

    func playVideo(url: URL , title: String , seekPos: Double ){
        quickStopVideo()

        UIApplication.shared.isIdleTimerDisabled = true

        setBtnEnableStatus(enable: false)

        mMPayer.setDataSource(url)

        titleLabel.text = title
        var seek = 0.0
        if seekPos - 5.0 > 0.0 {
            seek = seekPos - 5.0
        }
        if seekPos == 0.0 {
            seek = 0.0
        }
        lastWatchPos = Int(seek) * 1000 //用毫秒

        mMPayer.prepareAsync()
        startActivityWithMsg(msg: "Loading...")
    }


    func quickStopVideo(){
        mMPayer.reset()
        destoryTimer()
        progressSld.value = 0.0
        progressCacheView.progress = 0.0
        curPosLabel.text = "00:00"
        durationLabel.text = "00:00"
        durationLabel.text = nil
        mDuration = 0
        mCurPostion = 0
        lastWatchPos = 0

        stopActivity()
        setBtnEnableStatus(enable: true)

        UIApplication.shared.isIdleTimerDisabled = false
    }


    func timeToHumanStr(ms: Double) -> String {

        let seconds = Int(ms)
        let h = Int(seconds / 3600)
        let m = Int(seconds - h * 3600) / 60
        let s = Int(seconds - h * 3600 - m * 60)

        var result = String(format: "%02x", h) + ":" + String(format: "%02x", m) + ":" +  String(format: "%.2x", s);
        if h <= 0{
            result = String(format: "%02x", m) + ":" + String(format: "%02x", s)
        }
//        print("-timeToHumanStr--\(result)")
        return result
    }


}

extension TFVideoPlayerView {
    func playContent(){
        if mMPayer.isPlaying() == false {
            mMPayer.start()
            setPlayButtonsSelected(false)

            delegate?.videoPlayerDidControlByEvent(event: .Play)
        }
    }

    func pauseContent(){
        if mMPayer.isPlaying(){
            mMPayer.pause()
            setPlayButtonsSelected(true)

            delegate?.videoPlayerDidControlByEvent(event: .Pause)
        }
    }

    func replayContent(){
        mMPayer.seek(to: 0)

        mMPayer.start()
        setPlayButtonsSelected(false)

    }


    func addTimer(){
       mSyncSeekTimer = Timer(timeInterval: 1.0/3, target: self, selector: #selector(self.syncUIStatus), userInfo: nil, repeats: true)
        RunLoop.main.add(mSyncSeekTimer!, forMode: .commonModes)
    }

    func destoryTimer(){
        mSyncSeekTimer?.invalidate()
        mSyncSeekTimer = nil
    }

    func syncUIStatus(){
        if progressDragging == false , mMPayer.isPlaying() {
            if bubbleMsgLabel.isHidden == true {
                stopActivity()
            }

            mCurPostion = Double(mMPayer.getCurrentPosition()) / 1000.0

            let progress: Float = Float(mCurPostion / mDuration)
            progressSld.setValue(progress, animated: true)

            curPosLabel.text = timeToHumanStr(ms: mCurPostion)
//            durationLabel.text = timeToHumanStr(ms: mDuration)
        }
    }

    func unInstallPlayer(){
        quickStopVideo()
        destoryTimer()

        print("--****播放器销毁了****")

        NotificationCenter.default.removeObserver(self)
        mMPayer.unSetupPlayer()

        self.removeFromSuperview()
    }

}

extension TFVideoPlayerView : VMediaPlayerDelegate {

    //MARK: --- 必须的方法
    //MARK: --- 即将播放
    func mediaPlayer(_ player: VMediaPlayer!, didPrepared arg: Any!) {
        player.setVideoFillMode(VMVideoFillModeFit) //可以撑满屏幕

        mDuration = Double(player.getDuration()) / 1000.0

        if lastWatchPos > 0 {
            player .seek(to: lastWatchPos)
            curPosLabel.text = timeToHumanStr(ms: Double(lastWatchPos))
        }

        player.start()
        setPlayButtonsSelected(false)

        durationLabel.text = timeToHumanStr(ms: mDuration)
        setBtnEnableStatus(enable: true)
        stopActivity()
        addTimer()
    }

    //MARK: --- 播放完毕
    func mediaPlayer(_ player: VMediaPlayer!, playbackComplete arg: Any!) {
        mMPayer.pause()

        setPlayButtonsSelected(true)

        delegate?.videoPlayerDidPlayToEnd()
    }

    //MARK: --- 播放失败
    func mediaPlayer(_ player: VMediaPlayer!, error arg: Any!) {
        print("--mediaPlayer-播放出错");
        stopActivity()
        delegate?.videoPlayerHandleErrorCode(errorMsg: "播放出错")
    }

    //MARK: --- 选择实现的方法


    //MARK: --- 缓存
    func mediaPlayer(_ player: VMediaPlayer!, cacheStart arg: Any!) {
        print("--cacheStart:\(arg)")
    }

    func mediaPlayer(_ player: VMediaPlayer!, cacheComplete arg: Any!) {
        print("--cacheComplete:\(arg)")
    }

    func mediaPlayer(_ player: VMediaPlayer!, cacheSpeed arg: Any!) {
        print("--cacheSpeed:\(arg)")
    }

    func mediaPlayer(_ player: VMediaPlayer!, cacheUpdate arg: Any!) {
        print("--cacheUpdate:\(arg)")
    }

    func mediaPlayer(_ player: VMediaPlayer!, cacheNotAvailable arg: Any!) {
        print("--cacheNotAvailable:\(arg)")
    }


    func mediaPlayer(_ player: VMediaPlayer!, info arg: Any!) {

    }


    //
    func mediaPlayer(_ player: VMediaPlayer!, setupManagerPreference arg: Any!) {
        player.decodingSchemeHint = VMDecodingSchemeQuickTime
        player.autoSwitchDecodingScheme = true
    }

    func mediaPlayer(_ player: VMediaPlayer!, setupPlayerPreference arg: Any!) {
        player.setBufferSize(512*1024*1024)
        player.setAdaptiveStream(true)
        player.setVideoQuality(VMVideoQualityMedium)
        player.useCache = true

        let cachePath = NSHomeDirectory() + "/Library/Caches/MediasCaches"
        if FileManager.default.fileExists(atPath: cachePath){
            try! FileManager.default.createDirectory(atPath: cachePath, withIntermediateDirectories: true, attributes: nil)
        }

        player.setCacheDirectory(cachePath)
    }

    //拖动进度条
    func mediaPlayer(_ player: VMediaPlayer!, seekComplete arg: Any!) {
        progressDragging = false

        stopActivity()
    }

    func mediaPlayer(_ player: VMediaPlayer!, notSeekable arg: Any!) {
        progressDragging = false
    }

    func mediaPlayer(_ player: VMediaPlayer!, bufferingStart arg: Any!) {
        progressDragging = true

        player.pause()
        startActivityWithMsg(msg: "缓存中...")
    }

    func mediaPlayer(_ player: VMediaPlayer!, bufferingUpdate arg: Any!) {
        print("bufferingUpdate:\(arg)")
        if bubbleMsgLabel.isHidden {
//            let progress = Double(arg)
            bubbleMsgLabel.text = "缓存...\(arg)%"
        }
    }

    func mediaPlayer(_ player: VMediaPlayer!, bufferingEnd arg: Any!) {
        progressDragging = false

        player.start()
        stopActivity()
    }

    //速度
    func mediaPlayer(_ player: VMediaPlayer!, downloadRate arg: Any!) {
        print("bufferingUpdate:\(arg)")

        if isPlayLocalFile == true {
            return
        }

        if arg == nil{
            downloadRateLabel.text = "12KB/s"
        }else{
            downloadRateLabel.text = nil
        }
    }

}

//MARK: -- 旋转屏幕
//https://github.com/BrikerMan/BMPlayer
extension TFVideoPlayerView {

    //MARK: --- 重力感应
    @objc fileprivate func onOrientationChanged() {
        print("--重力感应-");
    }

    func fulllScreenAtion(){

        let orientation = UIDevice.current.orientation
        guard let interfaceOrientation = UIInterfaceOrientation(rawValue: orientation.rawValue) else{
            return
        }

        switch interfaceOrientation {

        case .portraitUpsideDown:
            self.interfaceOrientation(orientation: .portraitUpsideDown)
        case .portrait:
            self.interfaceOrientation(orientation: .portrait)
        case .landscapeLeft:
            self.interfaceOrientation(orientation: .landscapeLeft)
        case .landscapeRight:
            self.interfaceOrientation(orientation: .landscapeRight)
        case .unknown:
            self.interfaceOrientation(orientation: .landscapeRight)

        }

    }


    func interfaceOrientation(orientation: UIInterfaceOrientation){

        if(UIDevice.current.responds(to: Selector(stringLiteral: "setOrientation:"))){
            let selector = Selector(stringLiteral: "setOrientation:")

        }
    }

}






















