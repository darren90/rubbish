//
//  PlayerViewController.swift
//  iTVLive
//
//  Created by Tengfei on 2017/3/6.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class PlayerViewController: BaseViewController {
    
    var model : TVDetailModel?
    var channelId:String?
    
    var datas:[String]?{
        didSet{
//            tableView.reloadData()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        getUrlAndPlay()
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
                
            })
        }else if model.modelType == .Back {
            GetPlayUrlTool.getLiveBackUrl(channelId:channelId, st: model.st, et: model.et, finish: { (lists, error) in
                if error == nil{
                    self.errorType = .None
                    self.datas = lists
                }else{
                    self.errorType = .Default
                }
            })
        }
    }

}
