//
//  BaseViewController.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/21.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

enum ErrorNetType:Int {
    case None //没有错误 --- 移除loadingView
    case Default  //默认错误
    case NoNet  //  无网络
    case ServerError// 服务器错误
}

class BaseViewController: UIViewController {

    var errorView:ErrorView = Bundle.main.loadNibNamed("ErrorView", owner: nil, options: nil)?.first as! ErrorView

    let loadingView : LoadingView = LoadingView()

    var timer:Timer?
    
    var errorType:ErrorNetType =  .Default {
        didSet{
            self.destoryTimer()
            errorView.isHidden = false
            loadingView.isHidden = true
            switch errorType {
            case .None:
                loadingView.removeFromSuperview()
                errorView.removeFromSuperview()
            case .Default:
                errorView.msgLabel.text = "网络错误"
                errorView.msgDetailLabel.text = "请检查网络连接"
            case .NoNet:
                errorView.msgLabel.text = "网络错误"
                errorView.msgDetailLabel.text = "请检查网络连接"
            case .ServerError:
                errorView.msgLabel.text = "出现错误"
                errorView.msgDetailLabel.text = "服务器出错，请稍后重试"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        request()
    }
    
    func request(){
        
    }

    // MARK:-- 加载loadingView
    func addLoadingView()  {
        view.addSubview(errorView)
        errorView.frame = view.frame;
        errorView.retryBtn.addTarget(self, action: #selector(BaseViewController.retryBtnClick), for: .touchUpInside)
        
        view.addSubview(loadingView)
        loadingView.frame = view.bounds
        
        addTimer()
    }
    
    func retryBtnClick() {
        self.addTimer()
        
        errorView.isHidden = true
        loadingView.isHidden = false
        
        request()
    }
    
    func timerAction() {
        loadingView.progress = loadingView.progress + 1
    }
    
    func addTimer() {
        if timer == nil {
            timer = Timer(timeInterval: 0.15, target: self, selector: #selector(BaseViewController.timerAction), userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: .commonModes)
        }
    }
    
    func destoryTimer() {
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
    
    deinit {
        destoryTimer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
