//
//  CLHTagGankViewController.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/8/2.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit

class CLHTagGankViewController: CLHBaseViewController {
    
    
    lazy var tableView: UITableView = {
        let tableV = UITableView(frame: CGRect(x: 0, y: 0, width: KScreenW, height: KScreenH - KNavHeight - KBottomBarHeight), style: .plain)
        tableV.backgroundColor = UIColorMainBG
        tableV.delegate = self
        tableV.dataSource = self
        tableV.contentInset.top = 35
        tableV.separatorStyle = .none
        tableV.register(CLHTagGankCell.self, forCellReuseIdentifier: "tagGankCellID")
        return tableV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension CLHTagGankViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tagGankCellID", for: indexPath)
        return cell
    }
    
    
    
}
