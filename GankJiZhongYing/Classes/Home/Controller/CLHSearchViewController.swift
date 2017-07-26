//
//  CLHSearchViewController.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/7/26.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit

class CLHSearchViewController: CLHBaseViewController {

    
    var searchView: CLHSubSearchView = {
       let searchV = CLHSubSearchView()
        return searchV
    }()
    
    var cancelButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("取消", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        btn.setTitleColor(UIColorTextBlue, for: .normal)
        btn.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        return btn
    }()
    
    var bottomLineView: UIView = {
        let lineV = UIView()
        lineV.backgroundColor = UIColorLine
        return lineV
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: KScreenW, height: KScreenH), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        tableView.separatorInset = .zero
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 60
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "searchCell")
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        view.backgroundColor = .white
    }

    func setUpUI() {
        self.view.addSubview(searchView)
        self.view.addSubview(cancelButton)
        self.view.addSubview(bottomLineView)
        self.view.addSubview(tableView)
        
        searchView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(27)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-60)
            make.height.equalTo(30)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(27)
            make.left.equalTo(searchView.snp.right)
            make.right.equalTo(self.view).offset(0)
            make.height.equalTo(30)
        }
        
        bottomLineView.snp.makeConstraints { (make) in
            make.top.equalTo(searchView.snp.bottom).offset(3)
            make.left.equalTo(self.view).offset(0)
            make.right.equalTo(self.view).offset(0)
            make.height.equalTo(0.5)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(bottomLineView.snp.bottom).offset(0)
            make.left.equalTo(self.view).offset(0)
            make.right.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(0)
        }
        
        
        
    }
    
    func cancelButtonClick() {
        print("cancelButtonClick")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        if (self.navigationController?.viewControllers.count)! > 1 {
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
}

extension CLHSearchViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        cell.textLabel?.text = "hello world"
        return cell
    }
}
