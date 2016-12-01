//
//  BaseNaviBar.swift
//  01_ProjectBase
//
//  Created by Tengfei on 2016/12/2.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class BaseNaviBar: UIView {
    // MARK:-- 左侧返回按钮
    lazy var leftButton:UIButton = UIButton(type: .custom)
    
    lazy var rightButton:UIButton = UIButton(type: .custom)
    
    lazy var navTitle:UILabel = UILabel()
    
    lazy var navBgImage:UIImageView = UIImageView()
    
    lazy var navTitleImage:UIImageView = UIImageView()
    
    lazy var lineView:UIView = UIView()
    
    override init(frame: CGRect) {
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64)
        super.init(frame: rect)
        
    }
    
    
    func addFunViews() {
        let width = UIScreen.main.bounds.width
        
        leftButton.frame = CGRect(x: 0, y: 20, width: 44, height: 44)
        leftButton.contentHorizontalAlignment = .center
        leftButton.setTitleColor(UIColor.white, for: .normal)
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        leftButton.setImage(UIImage(named: "nav_btn_back_h"), for: .normal)
        addSubview(leftButton)
        
        rightButton.frame = CGRect(x: width - 80, y: 20, width: 65, height: 44)
        rightButton.contentHorizontalAlignment = .right
        rightButton.setTitleColor(UIColor.white, for: .normal)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        rightButton.setImage(UIImage(named: "nav_btn_back_h"), for: .normal)
        rightButton.isHidden = true
        addSubview(rightButton)
        
        navTitle.frame = CGRect(x: 80, y: 24, width: width - 80 - 80, height: 40)
        navTitle.textColor = UIColor.white
        navTitle.textAlignment = .center
        navTitle.font = UIFont.systemFont(ofSize: 18)
        addSubview(navTitle)
        
        navTitleImage.center = navTitle.center
        navTitleImage.bounds = CGRect(x: 0, y: 0, width: 83, height: 27)
        navTitleImage.contentMode = .scaleAspectFit
        addSubview(navTitleImage)
        
        lineView.frame = CGRect(x: 0, y: 64, width: width, height: 0.5)
        let colorNum:Float = 250 / 255.0
        lineView.backgroundColor = UIColor(colorLiteralRed: colorNum, green: colorNum, blue: colorNum, alpha: 1.0)
        addSubview(lineView)
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
