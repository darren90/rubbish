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

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var topHieigh: NSLayoutConstraint!
    @IBOutlet weak var topView: UIImageView!
    
    @IBOutlet weak var cnTitleL: UILabel!
    @IBOutlet weak var scoreL: UILabel!
    @IBOutlet weak var enTitleL: UILabel!
    @IBOutlet weak var viewsL: UILabel!
    @IBOutlet weak var areaL: UILabel!
    @IBOutlet weak var premiereL: UILabel!
    @IBOutlet weak var playStatusL: UILabel!
    @IBOutlet weak var remarkL: UILabel!
    @IBOutlet weak var contentL: UILabel!
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.bringSubview(toFront: topView)
        self.view.bringSubview(toFront: navBarView.leftButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    func initUI(){
        tableView.separatorStyle = .none
        self.tableView.contentInset = UIEdgeInsetsMake(200+300, 0, 0, 0)
    }

    override func request() {
        guard let filmId = filmId else{
            return
        }
        //影视详情
        FilmResDetailModel.getFilmDetail(id: filmId) { (model : FilmResDetailModel?, error : NSError?) -> () in
            
            if(error == nil){
                self.errorType = .None
                self.getDataSuccess(model: model!)
            }else{
                self.errorType = .Default
            }
        }
    }
    
    
    func getDataSuccess(model:FilmResDetailModel){
        navTitleStr = model.cnname
//        enTitleL.text = model.enname
        scoreL.text = "Score:\(model.score)"
        viewsL.text = "Views:\(model.views)"
        areaL.text = "\(model.area ?? "")/\(model.category ?? "")"
        premiereL.text = "Premiere:\(model.premiere)"
        playStatusL.text = model.play_status
        remarkL.text = model.remark
        contentL.text = model.content
        
        guard let enName = model.enname else {
            return
        }
        guard let cnName = model.cnname else {
            return
        }
        cnTitleL.text = cnName + "/" + enName
        
        guard let urlStr = model.poster_a , let url = URL(string: urlStr) else{
            return
        }
        topView.yy_setImage(with: url, placeholder: KPlaceImg)
    }

}

extension FilmDetailViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
//        cell?.textLabel?.text = "Indexpath:\(indexPath.row)"
        return cell!
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y - (-500)
        let h = 200 - offsetY
        
        topHieigh.constant = h
 
    }

}















