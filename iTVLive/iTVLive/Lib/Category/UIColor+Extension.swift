//
//  UIColor+Extension.swift
//  iTVshows
//
//  Created by Tengfei on 2017/2/16.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

extension UIColor {
    func createImageWithColor(color: UIColor) -> UIImage
    {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.addRect(rect)
//        context!.fillCGContextFillRect(context!, rect)
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage!
    }
}

