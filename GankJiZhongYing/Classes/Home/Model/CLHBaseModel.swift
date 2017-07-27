//
//  CLHBaseModel.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/7/27.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit

class CLHBaseModel: NSObject {

    //属性
    var id: String?
    var desc: String?
    var publishedAt: String?
    var type: String?
    var author: String?
    var url: String?
    
    
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
