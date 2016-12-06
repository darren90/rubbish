//
//  FilmDetailViewController.swift
//  iTVshows
//
//  Created by Fengtf on 2016/12/1.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class FilmDetailViewController: BaseTableViewController {

    var filmId:String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func request() {
        guard let filmId = filmId else{
            return
        }
        //影视详情
        FilmResDetailModel.getFilmDetail(id: filmId) { (model : FilmResDetailModel?, error : NSError?) -> () in

        }
    }

}

extension FilmDetailViewController {

}
