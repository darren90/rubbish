//
//  HomeCell.swift
//  TVLive
//
//  Created by Tengfei on 2017/3/4.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
    
    class func cellWithTableView(tableView:UITableView) -> HomeCell{
        let id = "HomeCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: id) as? HomeCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed(id, owner: nil, options: nil)?.first as? HomeCell
        }
        return cell!
    }

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var stateL: UILabel!
    @IBOutlet weak var playingL: UILabel!
    
    
    var model:TVListModel?{
        didSet{
            guard let model = model else {
                return
            }

            titleL.text = model.title

            switch model.modelType {
            case .YES:
                playingL.text = model.t
                stateL.textColor = UIColor.red
                playingL.isHidden = false
            case .NO:
                stateL.text = "暂无节目"
                stateL.textColor = UIColor.lightGray
                playingL.isHidden = true
            default:
                stateL.text = "正在播放..."
                stateL.textColor = UIColor.red
                playingL.isHidden = false
            }

            guard let url = model.iconUrl else {
                return
            }
            self.iconView.setImageWith(url, placeholder: KPlaceImg, options: .setImageWithFadeAnimation, completion: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
