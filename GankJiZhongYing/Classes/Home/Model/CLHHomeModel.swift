//
//  CLHHomeModel.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/7/24.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit

let lineHeight: CGFloat = 1
let nameLabelHeight: CGFloat  = 10
let dataLabelHeight: CGFloat  = 10
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
            _cellHeight = lineHeight + nameLabelHeight + dataLabelHeight + margin * 3.0
            //获取文字高度
            let descHeight = desc?.boundingRect(with: CGSize(width: KScreenW - 20, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 15)], context: nil).size.height
            var finalDescHeight: CGFloat = descHeight!
            //如果超出三行，全文按钮显示
            if descHeight! > UIFont.systemFont(ofSize: 15).lineHeight * 3 {
                finalDescHeight = UIFont.systemFont(ofSize: 15).lineHeight * 3
                shouldOpen = true
            }
            if isOpen {
                finalDescHeight = descHeight!
            }
            
            _cellHeight = _cellHeight! + finalDescHeight
        }
        return _cellHeight!
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
