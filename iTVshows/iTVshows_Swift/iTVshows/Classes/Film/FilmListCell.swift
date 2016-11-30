//
//  FilmListCell.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/30.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class FilmListCell: UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var markL: UILabel!
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var areaL: UILabel!
    @IBOutlet weak var updateL: UILabel!
    @IBOutlet weak var categoryL: UILabel!
    @IBOutlet weak var enTitleL: UILabel!


    var model:FilmResModel? {
        didSet {
            let url = URL(string: (model?.poster)!)!
            iconView?.yy_setImage(with: url, placeholder: nil, options:  .setImageWithFadeAnimation, completion: nil)// .progressiveBlur |
            titleL.text = model?.cnname
            enTitleL.text = model?.enname
            markL.text = String(model?.rank ?? 0)
            areaL.text = model?.area
            categoryL.text = model?.category
        }
    }

    class func cellWithTableView(tableView:UITableView) -> FilmListCell{
        let id = "FilmListCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: id) as? FilmListCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed(id, owner: nil, options: nil)?.first as? FilmListCell
        }
        return cell!
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = KBgViewColor
        bgView.backgroundColor = UIColor.white
        iconView.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
