//
//  BaseViewController.swift
//  01_ProjectBase
//
//  Created by Tengfei on 2016/12/1.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController,UIGestureRecognizerDelegate {

    var navBarView:BaseNaviBar = BaseNaviBar()

    var leftImg:String? {
        didSet {
            self.navBarView.leftButton.contentHorizontalAlignment = .left
            self.navBarView.leftButton.setImage(UIImage(named: leftImg ?? ""), for: .normal)
            self.navBarView.leftButton.setTitle(nil, for: .normal)
            self.navBarView.leftButton.setImage(UIImage(named: leftImg ?? "")?.imageWithTintColor(color: UIColor.lightGray), for: .highlighted)
        }
    }

    var leftTitle:String? {
        didSet {
            self.navBarView.leftButton.contentHorizontalAlignment = .center
            self.navBarView.leftButton.setTitle(leftTitle, for: .normal)
            self.navBarView.leftButton.setImage(nil, for: .normal)
            self.navBarView.leftButton.setImage(nil, for: .highlighted)
        }
    }

    var rightImg:String? {
        didSet {
//            self.navBarView.rightButton.contentHorizontalAlignment = .left
            self.navBarView.rightButton.isHidden = false
            self.navBarView.rightButton.setImage(UIImage(named: rightImg ?? ""), for: .normal)
            self.navBarView.rightButton.setTitle(nil, for: .normal)
            self.navBarView.leftButton.setImage(UIImage(named: rightImg ?? "")?.imageWithTintColor(color: UIColor.lightGray), for: .highlighted)

        }
    }

    var rightTitle:String? {
        didSet {
            self.navBarView.rightButton.isHidden = false
            self.navBarView.rightButton.setTitle(rightTitle, for: .normal)
            self.navBarView.rightButton.setImage(nil, for: .normal)
            self.navBarView.rightButton.setImage(nil, for: .highlighted)
        }
    }

    var navTitleStr:String? {
        didSet {
            self.navBarView.navTitle.text = navTitleStr
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        automaticallyAdjustsScrollViewInsets = false
        navigationController?.isNavigationBarHidden = true

        navBarView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64)
        navBarView.leftButton.addTarget(self, action: #selector(BaseViewController.leftBtnClick), for: .touchUpInside)
        navBarView.rightButton.addTarget(self, action: #selector(BaseViewController.rightBtnClick), for: .touchUpInside)
        view.addSubview(navBarView)
//        navBarView.backgroundColor = UIColor.brown
    }

    func leftBtnClick() {
        self.navigationController?.popViewController(animated: true)
//        navigationController?.popViewController(animated: true)
        print("---leftBtnClick---")
    }

    func rightBtnClick() {
        print("---leftBtnClick---")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }

}
