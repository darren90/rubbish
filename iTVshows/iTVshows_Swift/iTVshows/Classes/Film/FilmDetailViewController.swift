//
//  FilmDetailViewController.swift
//  iTVshows
//
//  Created by Fengtf on 2016/12/1.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class FilmDetailViewController: BaseViewController {

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

extension FilmDetailViewController {

}
