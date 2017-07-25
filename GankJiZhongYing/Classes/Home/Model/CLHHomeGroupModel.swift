//
//  CLHHomeGroupModel.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/7/24.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit
import SwiftyJSON

class CLHHomeGroupModel: NSObject, NSCoding {

    var groupTitle: String
    
    var homeGanks: [CLHHomeModel]
    
    init(dict: JSON, key: String) {
        groupTitle = key
        homeGanks = dict[key].arrayValue.map({ dict in
            CLHHomeModel(dict: dict)
        })
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.homeGanks = aDecoder.decodeObject(forKey: "homeGanks") as! [CLHHomeModel]
        self.groupTitle = aDecoder.decodeObject(forKey: "groupTitle") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(homeGanks, forKey: "homeGanks")
        aCoder.encode(groupTitle, forKey: "groupTitle")
    }
    
}
