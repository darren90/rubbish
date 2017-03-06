//
//  DetailListCell.swift
//  iTVLive
//
//  Created by Fengtf on 2017/3/6.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class DetailListCell: UITableViewCell {

    class func cellWithTableView(tableView:UITableView) -> DetailListCell{
        let id = "DetailListCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: id) as? DetailListCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed(id, owner: nil, options: nil)?.first as? DetailListCell
        }
        return cell!
    }

    @IBOutlet weak var timeL: UILabel!
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var stateL: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    var model : TVDetailModel?{
        didSet{
            guard let model = model else {
                return
            }

            titleL.text = model.t
            timeL.text = "\(model.duration)"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
