//
//  CLHHomeViewController.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/7/24.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit

class CLHHomeViewController: CLHBaseViewController {

    
    fileprivate var dataArray: [CLHHomeGroupModel] = [CLHHomeGroupModel]()
    
    var model: CLHHomeModel = {
        let model = CLHHomeModel(id: "x", desc: "hello world   hello world hello world hello worldhello world   hello world hello world hello worldhello world   hello world hello world hello worldhello world   hello world hello world hello worldhello world   hello world hello world hello worldhello world   hello world hello world hello worldhello world   hello world hello world hello world", publishedAt: "x", type: "xx", author: "AnICoo1", url: "xx")
        return model
    }()
    
    
    fileprivate lazy var navBar: CLHNavBar = {
        let navB = CLHNavBar(frame:  CGRect(x: 0, y: 0, width: KScreenW, height: 64))
        return navB
    }()
    
    fileprivate lazy var headerView: UIImageView = {
        let headerView = UIImageView(frame: CGRect(x: 0, y: 0, width: KScreenW, height: KScreenH * 0.55))
        return headerView
    }()
    
    fileprivate lazy var tableView: UITableView = {
       let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: KScreenW, height: KScreenH), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(CLHHomeCell.self, forCellReuseIdentifier: "homeCell")
        tableView.tableHeaderView = self.headerView
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if (self.navigationController?.viewControllers.count)! > 1 {
            self.navigationController?.navigationBar.isHidden = false
        }
    }
    
    //初始化UI
    func setUpUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(tableView)
        view.addSubview(navBar)
    }

}

extension CLHHomeViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CLHHomeCell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! CLHHomeCell
//        cell.backgroundColor = .red
        cell.homeGank = self.model
        cell.indexPath = indexPath
        //全文按钮点击回调事件
        cell.moreButtonClickHandler = { [unowned self] (indexPath: IndexPath) in
            self.model.isOpen = !(self.model.isOpen)
            self.tableView.reloadRows(at: [indexPath], with: .fade)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    /*
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
    }
 */
}
