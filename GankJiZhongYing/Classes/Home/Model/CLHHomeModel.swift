//
//  CLHHomeModel.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/7/24.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit
import SwiftyJSON

let lineHeight: CGFloat = 1
let nameLabelHeight: CGFloat  = 15
let dataLabelHeight: CGFloat  = 15
let margin: CGFloat  = 8

class CLHHomeModel: NSObject {

    //属性
    var id: String?
    var desc: String?
    var publishedAt: String?
    var type: String?
    var author: String?
    var url: String?
    
    var shouldOpen: Bool = false
    var isOpen: Bool = false
    
    var _cellHeight: CGFloat?
    
    var cellHeight: CGFloat {
        
        
        if _cellHeight == nil {
            _cellHeight = lineHeight + nameLabelHeight + margin
            //获取文字高度
            let descHeight = desc?.boundingRect(with: CGSize(width: KScreenW - 20.0, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 15.0)], context: nil).size.height
            var finalDescHeight: CGFloat = descHeight!
            //如果超出三行，全文按钮显示
            if descHeight! > UIFont.systemFont(ofSize: 15.0).lineHeight * 3 {
                finalDescHeight = UIFont.systemFont(ofSize: 15.0).lineHeight * 3
                shouldOpen = true
            }
            if isOpen {
                finalDescHeight = descHeight!
            }
            
            _cellHeight = _cellHeight! + finalDescHeight + margin
            _cellHeight = _cellHeight! + dataLabelHeight + margin + 8
        }
        return _cellHeight! + 20.0
    }
    convenience  init(dict: JSON) {
        self.init()
        for (index, subJson) : (String, JSON) in dict {
            switch index {
            case "_id":
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
    
    convenience init(id: String, desc: String, publishedAt: String, type: String, author: String, url: String) {
        self.init()
        self.id = id
        self.desc = desc
        self.publishedAt = publishedAt
        self.type = type
        self.author = author
        self.url = url
    }
    
}
