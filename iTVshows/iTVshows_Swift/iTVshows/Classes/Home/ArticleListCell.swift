//
//  ArticleListCell.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/30.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class ArticleListCell: UITableViewCell {

    class func cellWithTableView(tableView:UITableView) -> ArticleListCell{
        let id = "ArticleListCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: id) as? ArticleListCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed(id, owner: nil, options: nil)?.first as? ArticleListCell
        }
        return cell!
    }

    @IBOutlet weak var imgView: UIImageView!

    @IBOutlet weak var titleL: UILabel!

    @IBOutlet weak var bgView: UIView!

    var model:ArticleModel? {
        didSet {
            let url = URL(string: (model?.poster)!)!
            imgView?.yy_setImage(with: url, placeholder: KPlaceImg, options:  .setImageWithFadeAnimation, completion: nil)// .progressiveBlur |
            self.titleL.text = model?.title
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.backgroundColor = KBgViewColor
        self.contentView.sendSubview(toBack: bgView)
        imgView.layer.cornerRadius = 6
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
