//
//  CLHTagGankViewController.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/8/2.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit

class CLHTagGankViewController: CLHBaseViewController {
    
    var type: String!
    
    var dataArray: [CLHGankModel] = [CLHGankModel]()
    
    var currentPage: Int = 1
    
    var lastPage: Int?
    
    lazy var tableView: UITableView = {
        let tableV = UITableView(frame: CGRect(x: 0, y: 0, width: KScreenW, height: KScreenH - KNavHeight - KBottomBarHeight), style: .plain)
        tableV.backgroundColor = UIColorMainBG
        tableV.delegate = self
        tableV.dataSource = self
//        tableV.contentInset.top = 35
        tableV.separatorStyle = .none
        
        tableV.register(CLHTagGankCell.self, forCellReuseIdentifier: "tagGankCellID")
        return tableV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.type = self.title
        setUpAll()
        loadData()
    }

    
    func loadData() {
        // 当前加载的页码
        let currentPage: Int = 1
        // 更新最后一次请求的页码
        self.lastPage = currentPage
        CLHNetworking.loadGankRequest(type: self.type, page: currentPage, success: { (result) -> (Void) in
            if currentPage != self.lastPage {
                return
            }
            guard let datasArray = result as? [CLHGankModel] else {
                return
            }
            
            self.dataArray.append(contentsOf: datasArray)
            self.tableView.reloadData()
            self.currentPage = currentPage
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) { (error) -> (Void) in
            
        }
        
        /*
        CLHNetworking.loadClassRequest(tpye: self.type, page: currentPage, success: { (result) in
            if self.lastPage != currentPage { return }
            
            self.loadingView.isHidden = true
            guard let datasArray = result as? [AHClassModel] else {
                self.tableView.mj_header.endRefreshing()
                return
            }
            self.datasArray = datasArray
            self.tableView.reloadData()
            self.currentPage = currentPage
            self.tableView.mj_header.endRefreshing()
            
        }, failure: { (error) in
            if self.lastPage != currentPage { return }
            self.loadingView.isHidden = true
            
            AHLog("\(self.title!)----下拉刷新失败-----\(error)")
            self.tableView.mj_header.endRefreshing()
        })
         */
    }
    
}


extension CLHTagGankViewController {
    func  setUpAll() {
        view.addSubview(tableView)
    }
}

extension CLHTagGankViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(dataArray.count)
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataArray[indexPath.row].cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tagGankCellID", for: indexPath) as! CLHTagGankCell
//        cell.textLabel?.text = "hello world"
        cell.selectionStyle = .none
        cell.indexPath = indexPath
        cell.gankModel = dataArray[indexPath.row]
        cell.moreButtonClickHandler = { [unowned self] (indexPath: IndexPath) in
            let model = self.dataArray[indexPath.row]
            model.isOpen = !model.isOpen
            self.tableView.reloadRows(at: [indexPath], with: .fade)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataArray[indexPath.row]
        let webVC = CLHHomeWebViewController()
        webVC.webURL = model.url
        webVC.gankModel = model
        webVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
}
