//
//  ChannelViewCell.swift
//  TVLive
//
//  Created by Tengfei on 2017/3/5.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

protocol ChannelViewCellDelegate {
    func cellDidClick(model:ChannelModel)
}

class ChannelViewCell: UICollectionViewCell {
    @IBOutlet weak var btn: ChannelBtn!
    
    var deledate:ChannelViewCellDelegate?
    
    var model:ChannelModel?{
        didSet{
            guard let model = model else {
                return
            }
            
            self.btn.model = model
            self.btn.setTitle(model.title, for: .normal)
            self.btn.setImage(UIImage(named:model.imgName ?? "box_yangshi_normal"), for: .normal)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    @IBAction func btnAcion(_ sender: ChannelBtn) {
        deledate?.cellDidClick(model: sender.model!)
    }

}

class ChannelBtn: UIButton {
    
    var model:ChannelModel?
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.imageView?.tintColor = UIColor.clear
        
        self.titleLabel?.textAlignment = .center
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = self.width

        
        self.imageView?.frame = CGRect(x: 0, y: 0, width: w, height: w-30)
        self.titleLabel?.frame = CGRect(x: 0, y: (self.imageView?.height)! - 15, width: w, height: 30)
    }
    
}













