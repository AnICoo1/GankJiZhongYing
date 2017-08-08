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

    
    static func loadGankRequest(type: String, page: Int, success: @escaping Success, failure: @escaping Failure){
        let url = baseURL + "data/\(type)/20/\(page)"
        requestData(url, success: { (result) -> (Void) in
            print(result)
            let dict = JSON(result)
            let datas: [CLHGankModel]
            // 创建一个组队列
            let group = DispatchGroup()
            let urlconfig = URLSessionConfiguration.default
            urlconfig.timeoutIntervalForRequest = 2
            urlconfig.timeoutIntervalForResource = 2
            
            datas = dict["results"].arrayValue.map({ dict in
                let model = CLHGankModel(dict: dict)
                
                if let images = model.images, model.images?.count == 1 {
                    let urlString = images.first! + "?imageInfo"
                    let url = URL(string: urlString)
                    
                    let session = URLSession(configuration: urlconfig)
                    // 当前线程加入组队列
                    group.enter()
                    let tast = session.dataTask(with: url!, completionHandler: { (data: Data?, _, error: Error?) in
                        if let data = data {
                            let json = JSON(data: data)
                            if let width = json["width"].object as? CGFloat {
//                                model.imageW = width
                            }
                            if let height = json["height"].object as? CGFloat {
//                                model.imageH = height
                            }
                        }
                        // 当前线程离开组队列
                        group.leave()
                    })
                    tast.resume()
                    // 防止内存泄漏
                    session.finishTasksAndInvalidate()
                }
                return model
            })
            
            // 等组队列执行完, 在主线程回调
            group.notify(queue: DispatchQueue.main, execute: {
                success(datas)
            })

        }) { (error) -> (Void) in
            print(error)
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
    
    // 请求首页数据
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
    
    // 请求搜索数据
    static func loadSearchRequest(text: String, page: Int, success: @escaping Success, failure: @escaping Failure) {
        let url = baseURL + "search/query/\(text)/category/all/count/20/page/\(page)"
        
        requestData(url, success: { (result: Any) in
            let dicts = JSON(result)
            let datas: [CLHSearchGankModel]
            
            datas = dicts["results"].arrayValue.map({ dict in
                CLHSearchGankModel(dict: dict)
            })
            
            success(datas)
            
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
