//
//  TableViewController.swift
//  SwiftExample
//
//  Created by dingwenchao on 10/17/16.
//  Copyright © 2016 wenchao. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objects = [DIYExampleViewController.self, NSObject.self,DelegateAppearanceViewController.self, NSObject.self, LoadViewExampleViewController.self,FullCalendarController.self]
        if let ViewControllerClass = objects[indexPath.row] as? UIViewController.Type {
            self.navigationController?.pushViewController(ViewControllerClass.init(), animated: true)
        }
    }

    var current = Date()
    
    @IBAction func pickAction(_ sender: UIBarButtonItem) {
        let min = Date().addingTimeInterval(-60 * 60 * 24 * 15)
        let max = Date().addingTimeInterval(60 * 60 * 24 * 15)
        let picker = DateTimePicker.show(selected: current, minimumDate: min, maximumDate: max)
        picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.doneButtonTitle = "!! DONE DONE !!"
        picker.todayButtonTitle = "Today"
        picker.completionHandler = { date in
            self.current = date
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/YYYY" //"HH:mm dd/MM/YYYY"
            let selectDateStr = formatter.string(from: date)
            print("selct date :\(selectDateStr)")
            self.title = formatter.string(from: date)
        }

    }

}
