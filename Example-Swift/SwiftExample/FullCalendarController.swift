//
//  FullCalendarController.swift
//  SwiftExample
//
//  Created by Fengtf on 2017/1/7.
//  Copyright © 2017年 wenchao. All rights reserved.
//

import UIKit
import EventKit

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

    var dateFormatter:DateFormatter = DateFormatter()

    var showsLunar:Bool = true //默认显示农历
    var showsEvents:Bool = false

    var minimumDate:Date = Date()
    var maximumDate:Date = Date()

    var  events:[EKEvent]?
//    var  lunarChars:[String]?
//    var cache:NSCache<EKEvent, Date>?


    override func viewDidLoad() {
        super.viewDidLoad()


        dateFormatter.dateFormat = "yyyy-MM-dd"

        minimumDate = getDate(dateStr: "2016-02-03")
        maximumDate = getDate(dateStr: "2018-04-10")

        loadCalendar()
        initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

//        self.cache?.removeAllObjects()
    }

    func getDate(dateStr:String) -> Date{
        let fm = DateFormatter()
        fm.dateFormat = "yyyy-MM-dd"
        let date = fm.date(from: dateStr)
        return date!
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

        calendar.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height-64)
        calendar.backgroundColor = UIColor.white
        calendar.delegate =  self
        calendar.dataSource = self
        calendar.pagingEnabled = false
        calendar.allowsMultipleSelection = true
        calendar.firstWeekday = 2
        calendar.allowsMultipleSelection = false
        calendar.placeholderType = .fillHeadTail
        calendar.appearance.caseOptions = [ .headerUsesUpperCase , .weekdayUsesUpperCase]
        view.addSubview(calendar)
    }


    func initUI(){
        let todayItem = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(self.todayItemClicked))

        let lunarItem = UIBarButtonItem(title: "Lunar", style: .plain, target: self, action: #selector(self.lunarItemClicked))

        let eventItem = UIBarButtonItem(title: "Event", style: .plain, target: self, action: #selector(self.eventItemClicked))

        navigationItem.rightBarButtonItems = [todayItem,lunarItem,eventItem]
    }

//MARK: --- 回到今天
    func todayItemClicked(){
        print("now:\(Date())")
        calendar.setCurrentPage(Date(), animated: false)
    }

//MARK: --- 显示农历
    func lunarItemClicked(){
        showsLunar = !showsLunar
        calendar.reloadData()
    }

//MARK: --- 回到事件
    func eventItemClicked(){
        showsEvents = !showsEvents
        calendar .reloadData()
    }



}




extension FullCalendarController : FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance{

    //MARK: --- FSCalendarDataSource
    func minimumDate(for calendar: FSCalendar) -> Date {
        return self.minimumDate
    }

    func maximumDate(for calendar: FSCalendar) -> Date {
        return self.maximumDate
    }

    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//        if showsEvents {
//
//        }
        if showsLunar {
            let day = lunarCanlendar.component(.day, from: date)
            return lunarChars[day - 1]
        }
        return nil
    }

    //MARK: --- FSCalendarDelegate

    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {

        print("did select :\(dateFormatter.string(from: date))")
    }

    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("did change page :\(dateFormatter.string(from: calendar.currentPage))")
    }

//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//
//    }


    //MARK: --- FSCalendarDelegateAppearance

}

//MARK: --- 方法补充 --  Private methods
extension FullCalendarController {

//    func eventsForDate:(date:Date) -> [EKEvent]? {
//        let evs = cache?.object(forKey: date)
////        if evs  {
//
////        }
//
//        return nil
//    }


}






























