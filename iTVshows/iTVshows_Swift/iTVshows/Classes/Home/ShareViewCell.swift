//
//  ShareViewCell.swift
//  iTVshows
//
//  Created by Fengtf on 2016/12/6.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class ShareViewCell: UICollectionViewCell {
    @IBOutlet weak var iconBtn: UIButton!

    @IBOutlet weak var titleL: UILabel!
    
    @IBAction func iconBtnClick(_ sender: UIButton) {

    }

    var model:ShareModel?{
        didSet{
            let image = UIImage(named: model?.name ?? "")
            iconBtn.setImage(image, for: .normal)

            let bgImage = UIImage(named: model?.name ?? "" + "_hover")
            iconBtn.setBackgroundImage(bgImage, for: .normal)

            titleL.text = model?.title
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.iconBtn.imageView?.contentMode = .scaleAspectFill
    }


}
