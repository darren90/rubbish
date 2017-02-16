//
//  TFCommon.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/30.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit




//rgb(214, 225, 227)

//#define KRandomColor     [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];

//#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:1]

//let KColor()

/// RandomColor
//let KRandomColor = UIColor(colorLiteralRed: Float(arc4random_uniform(256) / 255), green: Float(arc4random_uniform(256) / 255), blue: Float(arc4random_uniform(256) / 255), alpha: 1.0)

// 随机颜色但是不对，，，why
let red = CGFloat(arc4random()%256)/255.0
let green = CGFloat(arc4random()%256)/255.0
let blue = CGFloat(arc4random()%256)/255.0
let KRandomColor =  UIColor(red: red, green: green, blue: blue, alpha: 1.0)

/// View 的背景颜色 rgb(242, 246, 247)
let KBgViewColor = UIColor(colorLiteralRed: 242/255.0, green: 246/255.0, blue: 247/255.0, alpha: 1.0)


let KWidth = UIScreen.main.bounds.width
let KHeight = UIScreen.main.bounds.height


let KPlaceImg = UIImage(named: "kplace")


//rgb(45, 165, 252)
let KCommonColor = UIColor(colorLiteralRed: 45/255.0, green: 165/255.0, blue: 252/255.0, alpha: 1.0)


















































