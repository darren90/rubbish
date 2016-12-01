//
//  ScheduleListCell.swift
//  iTVshows
//
//  Created by Tengfei on 2016/11/30.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class ScheduleListCell: UICollectionViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleBgView: UIView!
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var enTitleL: UILabel!
    @IBOutlet weak var updateL: UILabel!
    
    var model:ScheduleModel? {
        didSet {
            let url = URL(string: (model?.poster) ?? "")
            if url == nil {
                iconView.image = KPlaceImg
            }else{
                iconView?.yy_setImage(with: url, placeholder: KPlaceImg, options:  .setImageWithFadeAnimation, completion: nil)// .progressiveBlur |
            }
            titleL.text = model?.cnname
            enTitleL.text = model?.enname
            updateL.text = "S" + (model?.season)! + " : E" + (model?.episode)!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        iconView.layer.cornerRadius = 6
        iconView.clipsToBounds = true
        
        //图片添加阴影
        iconView.layer.shadowOpacity = 0.8
        iconView.layer.shadowColor = UIColor.black.cgColor
        iconView.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        bgView.backgroundColor = UIColor.clear//comforColor()
        titleBgView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
    
    lazy var colorArr:[UIColor] = {
        let c1 = UIColor(colorLiteralRed: 53/255.0, green: 202/255.0, blue: 181/255.0, alpha: 1.0)
        
        let c2 = UIColor(colorLiteralRed: 147/255.0, green: 197/255.0, blue: 187/255.0, alpha: 1.0)
        
        let c3 = UIColor(colorLiteralRed: 167/255.0, green: 238/255.0, blue: 237/255.0, alpha: 1.0)
        
        let c4 = UIColor(colorLiteralRed: 195/255.0, green: 237/255.0, blue: 210/255.0, alpha: 1.0)
        
        let c5 = UIColor(colorLiteralRed: 189/255.0, green: 202/255.0, blue: 118/255.0, alpha: 1.0)
        
        let c6 = UIColor(colorLiteralRed: 251/255.0, green: 104/255.0, blue: 181/255.0, alpha: 1.0)
        
        let c7 = UIColor(colorLiteralRed: 242/255.0, green: 175/255.0, blue: 165/255.0, alpha: 1.0)
        
        let c8 = UIColor(colorLiteralRed: 235/255.0, green: 206/255.0, blue: 180/255.0, alpha: 1.0)
        
        let c9 = UIColor(colorLiteralRed: 213/255.0, green: 185/255.0, blue: 127/255.0, alpha: 1.0)
        
        let c10 = UIColor(colorLiteralRed: 53/255.0, green: 202/255.0, blue: 181/255.0, alpha: 1.0)
        
        let colorArr = [c1,c2,c3,c4,c5,c6,c7,c8,c9,c10]

        return colorArr
    }()
    
    func comforColor() -> UIColor{
//        rgb(53, 202, 181)
//        rgb(147, 197, 187)
//        rgb(167, 238, 231)
//        rgb(195, 235, 237)
//        rgb(189, 237, 210)
//        rgb(251, 104, 118)
//        rgb(242, 175, 165)
//        rgb(235, 206, 180)
//        rgb(213, 185, 127)
//        rgb(215, 211, 183)
        
        let num = Int(arc4random()%10)
                 
        let resColr = colorArr[num]
        
        return resColr
    }
    
//    class func cellWithC

}









