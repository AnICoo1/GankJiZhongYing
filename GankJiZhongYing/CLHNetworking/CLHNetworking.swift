//
//  CLHNetworking.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/7/24.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

typealias Success = (Any) -> (Void)
typealias Failure = (Error) -> (Void)

class CLHNetworking: NSObject {

    /// 请求首页数据
    static func loadHomeRequest(date: String, success: @escaping Success, failure: @escaping Failure) {
        let url = baseURL + "day/\(date)"
        requestData(url, success: { (result: Any) in
            print(result)
            let dicts = JSON(result)
            var datas = [CLHHomeGroupModel]()
            
            for dict in dicts["category"].arrayValue {
                let groupTitle = dict.stringValue
                let groupModel = CLHHomeGroupModel(dict: dicts["results"], key: groupTitle)
                datas.append(groupModel)
            }
            
            // 缓存首页数据
            //NSKeyedArchiver.archiveRootObject(datas, toFile: "homeGanks".cachesDir())
            
            success(datas)
            
        }) { (error: Error) in
            failure(error)
        }
    }
    
    // 请求发过干货日期数据
    static func loadDateRequest(success: @escaping Success, failure: @escaping Failure) {
        let url = baseURL + "day/history"
        
        requestData(url, success: { (result: Any) in
            let json = result as! [String: Any]
            guard let dateArray = json["results"] else { return }
            success(dateArray)
        }) { (error: Error) in
            failure(error)
        }
    }
    
     static func requestData(_ url: String, method: HTTPMethod = .get, encoding: ParameterEncoding = URLEncoding.default, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, success: @escaping Success, failure: @escaping Failure) {
        Alamofire.request(url, method: method, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .success:
                if let result = response.result.value {
                    success(result)
                }
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    
}
