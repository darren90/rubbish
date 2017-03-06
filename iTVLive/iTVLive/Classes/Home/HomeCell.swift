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
            titleL.text = model?.title
            playingL.text = model?.t
            guard let url = model?.iconUrl else {
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
