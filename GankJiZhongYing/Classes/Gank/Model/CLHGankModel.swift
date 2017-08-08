//
//  CLHGankModel.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/8/2.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit
import SwiftyJSON


let cellMargin: CGFloat = 10

class CLHGankModel: CLHBaseModel {

    var images: [String]?
    
    /// 是否展开
    var isOpen: Bool = false
    /// 是否应该展示全文按钮
    var isShouldOpen: Bool = false
    
    var _cellHeight: CGFloat?
    
    var cellHeight: CGFloat {
        if _cellHeight == nil {
            _cellHeight = 5
            
            // 文字的高度
            let maxSize = CGSize(width: KScreenW - cellMargin * 2, height: CGFloat(MAXFLOAT))
            let descTextH = desc?.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 15)], context: nil).size.height
            var contentTextH: CGFloat = descTextH!
            if descTextH! > UIFont.systemFont(ofSize: 15).lineHeight * 3.0 {
                contentTextH = UIFont.systemFont(ofSize: 15).lineHeight * 3
                isShouldOpen = true
            }
            if isOpen {
                contentTextH = descTextH!
            }
            
            _cellHeight = _cellHeight! + contentTextH + cellMargin
            
            if isShouldOpen {
                _cellHeight = _cellHeight! + 20.0
            }
            /*
            if images?.count == 1 {
                
            }
            */
            _cellHeight = _cellHeight! + 20.0 + margin * 2
        }
        return _cellHeight!
    }
    init(dict: JSON) {
        super.init()
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
            case "images":
                self.images = (subJson.object as AnyObject) as? [String]
            default: break
            }
        }
        
        if let images = self.images {
            if images.count == 1 {
//                self.imageType = AHImageType.oneImage
            } else {
//                self.imageType = AHImageType.moreImage
            }
        }
        
        // 时间处理
        let time = self.publishedAt! as NSString
        self.publishedAt = time.substring(to: 10) as String
    }

}
