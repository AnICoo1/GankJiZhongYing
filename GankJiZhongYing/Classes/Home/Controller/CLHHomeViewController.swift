//
//  CLHHomeViewController.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/7/24.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit
import SDWebImage

class CLHHomeViewController: CLHBaseViewController {

    
    fileprivate var dataArray: [CLHHomeGroupModel] = [CLHHomeGroupModel]()
    
    
    fileprivate lazy var navBar: CLHNavBar = {
        let navB = CLHNavBar(frame:  CGRect(x: 0, y: 0, width: KScreenW, height: 64))
        navB.searchView.locationVC = self
        return navB
    }()
    
    fileprivate lazy var headerView: CLHHeaderView = {
        
        let headerView = CLHHeaderView()
        headerView.frame = CGRect(x: 0, y: 0, width: KScreenW, height: KScreenH * 0.55)
        return headerView
    }()
    
    fileprivate lazy var tableView: UITableView = {
       let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: KScreenW, height: KScreenH), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInset.bottom = KBottomBarHeight
        tableView.register(CLHHomeCell.self, forCellReuseIdentifier: "homeCell")
        tableView.tableHeaderView = self.headerView
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setUpUI()
        sendRequest()
    }
    
    
    func sendRequest() {
        // 获取发过干货的日期
        CLHNetworking.loadDateRequest(success: { (result: Any) in
            guard let dateArray = result as? [String] else { return }
            guard let newestDate = dateArray.first else { return }
            
            let date = newestDate.replacingOccurrences(of: "-", with: "/")
            
            self.loadGanks(WithDate: date)
            
        }) { (error: Error) in
            print(error)
        }
    }
    
    func loadGanks(WithDate date: String) {
        CLHNetworking.loadHomeRequest(date: date, success: { (result: Any) in
            guard let datasArray = result as? [CLHHomeGroupModel] else { return }
//            self.loadingView.isHidden = true
            // UserDefaults.AHData.lastDate.store(value: date)
            //UserConfig.set(date, forKey: .lastDate)
            
            self.dataArray = datasArray
            self.setUpHeaderView()
            self.tableView.reloadData()
        }) { (error: Error) in
            print(error)
        }
    }
    
    func setUpHeaderView() {
        var newData = [CLHHomeGroupModel]()
        
        for data in dataArray {
            if data.groupTitle == "福利" {
                guard let urlString = data.homeGanks.first?.url else { return }
                let url = urlString + "?/0/w/\(KScreenH * 0.55)/h/\(KScreenW)"
                let Url: URL = URL(string: url)!
                headerView.imageView.sd_setImage(with: Url, placeholderImage: nil, options: SDWebImageOptions(rawValue: 0), progress: nil, completed: nil)
                continue
            }
            newData.append(data)
        }
        dataArray = newData

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
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray[section].homeGanks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CLHHomeCell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! CLHHomeCell
        cell.selectionStyle = .none
        cell.homeGank = dataArray[indexPath.section].homeGanks[indexPath.row]
        cell.indexPath = indexPath
        //全文按钮点击回调事件
        cell.moreButtonClickHandler = { [unowned self] (indexPath: IndexPath) in
            let model = self.dataArray[indexPath.section].homeGanks[indexPath.row]
            model.isOpen = !model.isOpen
            self.tableView.reloadRows(at: [indexPath], with: .fade)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = dataArray[indexPath.section].homeGanks[indexPath.row]
        let webVC = CLHHomeWebViewController()
        webVC.webURL = model.url
        webVC.gankModel = model
        webVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataArray[indexPath.section].homeGanks[indexPath.row].cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerSectionV = CLHHeaderSectionView()
        headerSectionV.titleLabel.text = dataArray[section].groupTitle
        return headerSectionV
    }
 
}

extension CLHHomeViewController: UIScrollViewDelegate {
    //根据滑动决定nav的背景色透明度和搜索框的大小
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        let alpha = offsetY / (KScreenH * 0.55 - KNavHeight)
        
        if offsetY > 0 {
            navBar.bgColorAlpha = alpha
            if alpha >= 1.0 {
                navBar.showLongSearchView()
            }
        } else{
            navBar.bgColorAlpha = 0.001
            navBar.showShortSearchView()
        }
    }
}

