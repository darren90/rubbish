//
//  FullCalendarController.swift
//  SwiftExample
//
//  Created by Fengtf on 2017/1/7.
//  Copyright © 2017年 wenchao. All rights reserved.
//

import UIKit

class FullCalendarController: UIViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initLunarCanlendar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    //MARK: --- 属性
    lazy var calendar:FSCalendar = FSCalendar()
    lazy var lunarCanlendar = Calendar(identifier: .chinese) //农历
    var lunarChars:[String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()


        loadCalendar()
        initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension FullCalendarController {

    func initCalendar(){

    }

    //MARK:-- 农
    func initLunarCanlendar(){
        lunarCanlendar.locale = Locale(identifier: "zh-CN");
        lunarChars = ["初一","初二","初三","初四","初五","初六","初七","初八","初九","初十","十一","十二","十三","十四","十五","十六","十七","十八","十九","二十","二一","二二","二三","二四","二五","二六","二七","二八","二九","三十"];

    }

    func loadCalendar(){
        view.addSubview(calendar)

        calendar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        calendar.backgroundColor = UIColor.white
        calendar.delegate =  self
        calendar.dataSource = self
        calendar.pagingEnabled = false
        calendar.allowsMultipleSelection = true
        calendar.firstWeekday = 2
        calendar.placeholderType = .fillHeadTail
//        calendar.appearance.caseOptions = [ .headerUsesUpperCase | .weekdayUsesUpperCase]
        view.addSubview(calendar)
    }


    func initUI(){
        let todayItem = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(self.todayItemClicked))

        let lunarItem = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(self.lunarItemClicked))

        let eventItem = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(self.eventItemClicked))

        navigationItem.rightBarButtonItems = [todayItem,lunarItem,eventItem]
    }

//MARK: --- 回到今天
    func todayItemClicked(){
        calendar.setCurrentPage(Date(), animated: false)
    }

//MARK: --- 显示农历
    func lunarItemClicked(){

    }

//MARK: --- 回到事件
    func eventItemClicked(){

    }



}




extension FullCalendarController : FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance{

}

































