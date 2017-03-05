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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
