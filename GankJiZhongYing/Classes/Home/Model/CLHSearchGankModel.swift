//
//  CLHSearchGankModel.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/7/27.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit
import SwiftyJSON

class CLHSearchGankModel: CLHBaseModel {

    init(dict: JSON) {
        super.init()
        for (index, subJson) : (String, JSON) in dict {
            switch index {
            case "ganhuo_id":
                self.id = subJson.string
            case "desc":
                self.desc = subJson.string
            case "publishedAt":
                self.publishedAt = subJson.string
            case "url":
                self.url = subJson.string
            case "type":
                self.type = subJson.string
            case "who":
                self.author = subJson.string
            default: break
            }
        }
        // 时间处理
        let time = self.publishedAt! as NSString
        self.publishedAt = time.substring(to: 10) as String
    }

}
