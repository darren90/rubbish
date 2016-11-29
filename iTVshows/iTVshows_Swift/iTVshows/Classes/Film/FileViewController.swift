//
//  FileViewController.swift
//  iTVshows
//
//  Created by Fengtf on 2016/11/29.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class FileViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "FF"

        //影视列表
//        FilmResModel.getFilmList(page: 1) {(list : [FilmResModel]?, error : NSError?) -> () in
//            print("--list:\(list)")
//        }

        //影视详情
//        FilmResDetailModel.getFilmDetail(id: "26315") { (model : FilmResDetailModel?, error : NSError?) -> () in
//            
//        }

        LinkModel.getLink(id: "26315") {(link : LinkModel?, error : NSError?) -> () in

        }
    }





    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
