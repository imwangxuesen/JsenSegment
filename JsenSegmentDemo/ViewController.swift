//
//  ViewController.swift
//  JsenSegmentDemo
//
//  Created by WangXuesen on 2017/12/11.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        
        /// initial
        let segment = JsenSegment.init(frame: CGRect.init(x: 0, y: 50, width: self.view.bounds.width, height: 50))
        
        /// title
        let title = NSAttributedString.init(string: "Click Me",
                                            attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15) ,
                                                         NSAttributedStringKey.foregroundColor : UIColor.blue])
        
        /// selected title
        let selectedTitle = NSAttributedString.init(string: "Selected",
                                                    attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17) ,
                                                                 NSAttributedStringKey.foregroundColor : UIColor.red])
        
        /// itemAttribute
        let itemAttribute = JsenSegmentItemAttribute.init(title: title,
                                                          backgroundColor: UIColor.yellow,
                                                          type: .text, imageName: nil,
                                                          selectedTitle: selectedTitle,
                                                          selectedBackgroundColor: UIColor.groupTableViewBackground,
                                                          selectedType: .text, selectedImageName: nil)
        
        /// itemAttribute2
        let itemAttribute2 = JsenSegmentItemAttribute(title: title,
                                                      backgroundColor: UIColor.yellow,
                                                      selectedTitle: selectedTitle,
                                                      selectedBackgroundColor: UIColor.groupTableViewBackground)
        
        /// indicatorAttribute
        let indicatorAttribute = JsenSegmentIndicatorAttribute.init(color: UIColor.green, type: .slider, height: 3.0, position: .bottom)
        
        /// config
        segment.config(with: indicatorAttribute, dataSource: [itemAttribute,itemAttribute2,itemAttribute,itemAttribute2], selectedIndex: 0 ,panAble: true) { (index) in
            print("segment current index:" + String(index))
        }
        
        self.view.addSubview(segment)
        
        
        let segment2 = JsenSegment.init(frame: CGRect.init(x: 0, y: 200, width: self.view.bounds.width, height: 50))
        
        let indicatorAttribute2 = JsenSegmentIndicatorAttribute()

        let itemAttribute3 = JsenSegmentItemAttribute.config(backgroundColor: UIColor.white, imageName: "jsen_segment_car_nor1", selectedBackgroundColor: UIColor.groupTableViewBackground, selectedImageName: "jsen_segment_car_sel1")
        segment2.config(with: indicatorAttribute2, dataSource: [itemAttribute3,itemAttribute3,itemAttribute3,itemAttribute3], selectedIndex: 0 ,panAble: true) { (index) in
            print("segment2 current index:" + String(index))
        }
        self.view.addSubview(segment2)
        
        let indicatorAttribute3 = JsenSegmentIndicatorAttribute.init(color: UIColor.green, type: .slider, height: 3.0, position: .top)

        let segment3 = JsenSegment.init(frame: CGRect.init(x: 0, y: 400, width: self.view.bounds.width, height: 50))
        segment3.config(with: indicatorAttribute3, dataSource: [itemAttribute3,itemAttribute2,itemAttribute3,itemAttribute], selectedIndex: 0 ,panAble: true) { (index) in
            print("segment3 current index:" + String(index))
        }
        self.view.addSubview(segment3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

