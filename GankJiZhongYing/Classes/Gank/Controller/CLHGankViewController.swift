//
//  CLHGankViewController.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/7/24.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit

class CLHGankViewController: CLHTopChooseViewController {

    
    var focusTagArray: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAll()
        setUpUI()
    }
}

//MARK: - UI
extension CLHGankViewController {
    fileprivate func setUpAll() {
        setUpTopView()
        focusTagArray = ["干货", "iOS", "前端", "Android", "拓展资源", "视频"]
        // 从本地读取频道列表
        let saveFocusTagArray = NSKeyedUnarchiver.unarchiveObject(withFile: "saveFocusTagArray".cachesDir()) as? [String]
        if saveFocusTagArray != nil {
            focusTagArray = saveFocusTagArray!
        }
        setUpChildViewController(tagArray: focusTagArray)
        
    }
    
    fileprivate func setUpTopView() {
        buttonTitleFont = 14.0
        buttonSelectedLineColor = UIColorTextBlue
        buttonTitleSelectColor = UIColorTextBlue
        buttonTitleColor = UIColorTextLightGray
        titleViewHeight = 35.0
        titleViewBackgroudColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.95)
    }
    
    fileprivate func setUpChildViewController(tagArray: [String]) {
        focusTagArray.removeAll()
        for tag in tagArray {
            let vc = CLHTagViewController()
            vc.title = tag
            addChildViewController(vc)
            focusTagArray.append(tag)
        }
        NSKeyedArchiver.archiveRootObject(focusTagArray, toFile: "saveFocusTagArray".cachesDir())
    }
}
