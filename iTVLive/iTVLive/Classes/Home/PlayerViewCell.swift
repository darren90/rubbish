//
//  PlayerViewCell.swift
//  iTVLive
//
//  Created by Fengtf on 2017/3/7.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class PlayerViewCell: UITableViewCell {

    class func cellWithTableView(tableView:UITableView) -> PlayerViewCell{
        let id = "PlayerViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: id) as? PlayerViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed(id, owner: nil, options: nil)?.first as? PlayerViewCell
        }
        return cell!
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var titleL: UILabel!

    var index: Int?{
        didSet{
            titleL.text = "回拨片段-\(index ?? 0)"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
