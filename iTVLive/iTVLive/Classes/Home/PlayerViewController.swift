//
//  PlayerViewController.swift
//  iTVLive
//
//  Created by Tengfei on 2017/3/6.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit
import SnapKit

class PlayerViewController: BaseTableViewController {
    
    var model : TVDetailModel?
    var channelId:String?
    let playerView = TFVideoPlayerView.sharePlayerView()

    var datas:[String]?{
        didSet{
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navBarView.isHidden = true
        tableView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
//        navTitleStr = model?.t
        tableView.rowHeight = 50

        initPlayView()

        getUrlAndPlay()
    }

    func initPlayView(){
        let payerH: CGFloat = view.width * 10.0 / 16
        tableView.contentInset = UIEdgeInsetsMake(payerH, 0, 0, 0)
        view.addSubview(playerView)
        playerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(0)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(payerH)
        }
        playerView.delegate = self
    }


    func getUrlAndPlay(){
        guard let model = model else {
            return
        }
        
        guard let channelId = channelId else {
            return
        }
        
        if model.modelType == .Living {
            GetPlayUrlTool.getLiveUrl(channelId: channelId, finish: { (lists, error) in
                if error == nil{
                    self.errorType = .None
                    self.datas = lists
                    self.playView(url: (lists?.first)!)
                }else{
                    self.errorType = .Default
                }
            })
        }else if model.modelType == .Back {
            GetPlayUrlTool.getLiveBackUrl(channelId:channelId, st: model.st, et: model.et, finish: { (lists, error) in
                if error == nil{
                    self.errorType = .None
                    self.datas = lists
                    self.playView(url: (lists?.first)!)
                }else{
                    self.errorType = .Default
                }
            })
        }
    }

    func playView(url:String){

        guard let uurl = URL(string: url) else {
            return
        }
        print("");
        playerView.playVideo(url: uurl, title: (model?.t)!, seekPos: 0.0)
    }

    deinit {
        unInstallPlayerView()
    }

    func unInstallPlayerView(){
        playerView.unInstallPlayer()
        playerView.removeFromSuperview()
    }

    override func leftBtnClick() {
        unInstallPlayerView()
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .landscape
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
}


extension PlayerViewController : TTVideoPlayerViewDelegate{
    func videoPlayerDidPlayToEnd() {

    }

    func videoPlayerDidControlByEvent(event: TTVideoPlayerControlEvent) {
        switch event {
        case .Back:
            print("---")
            playerView.unInstallPlayer()
            let _ = navigationController?.popViewController(animated: true)
        case .FullScreen:
            UIView.animate(withDuration: 0.5, animations: { 
                self.playerView.snp.makeConstraints({ (make) in
                    
                })
            })

        default: break

        }
    }

    func videoPlayerHandleErrorCode(errorMsg: String) {

    }
}


extension PlayerViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PlayerViewCell.cellWithTableView(tableView: tableView)
//        let model = datas?[indexPath.row]
//        cell.model = model
        cell.index = indexPath.row
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let playVc = PlayerViewController()
//        let model = datas?[indexPath.row]
//        playVc.model = model
//        playVc.channelId = channelId
//        navigationController?.pushViewController(playVc, animated: true)

//        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}





