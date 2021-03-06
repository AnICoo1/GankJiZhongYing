//
//  CLHSearchViewController.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/7/26.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD

class CLHSearchViewController: CLHBaseViewController {

    
    var historySearchTags = [String]()
    
    var lastSearchText: String!
    
    var currentPage: Int = 1
    
    fileprivate var dataArray: [CLHSearchGankModel] = [CLHSearchGankModel]()
    
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
        tableView.separatorInset = .zero
        tableView.isHidden = true
        tableView.tableFooterView = UIView()
        tableView.contentInset.bottom = KBottomBarHeight
        tableView.rowHeight = 60
        tableView.register(CLHSearchCell.self, forCellReuseIdentifier: "searchCell")
        return tableView
    }()
    
    fileprivate lazy var historyScrollView: UIScrollView = {
        let historyV = UIScrollView(frame: CGRect(x: 0, y: KNavHeight, width: KScreenW, height: KScreenH - KNavHeight))
        return historyV
    }()
    
    fileprivate lazy var historySearch: CLHSearchListView = {
       let searchListV = CLHSearchListView(frame: CGRect(x: 0, y: 0, width: KScreenW, height: 0))
        searchListV.addSomeTags(tags: self.historySearchTags)
        
        searchListV.updateTagsHandler = { [unowned self] (titles) in
            self.historySearchTags = titles
            NSKeyedArchiver.archiveRootObject(self.historySearchTags, toFile: "saveRecentSearchTitles".cachesDir())
        }
        
        searchListV.cleanButtonClickHandler = { [unowned self] in
            self.showAlertController(locationVC: self, title: "清除历史记录", message: "", confrimClouse: { (action) in
                self.historySearch.deleteAllTag()
                self.historySearchTags.removeAll()
                NSKeyedArchiver.archiveRootObject(self.historySearchTags, toFile: "saveRecentSearchTitles".cachesDir())
            }) {_ in}
        }

        searchListV.tagButtonClickHandler = { [unowned self] (titles) in
            self.historySearchTags = titles
            self.searchView.inputTextField.text = self.historySearchTags[0]
            self.loadRequest(text: self.historySearchTags[0])
            NSKeyedArchiver.archiveRootObject(self.historySearchTags, toFile: "saveRecentSearchTitles".cachesDir())
        }
        
        return searchListV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        view.backgroundColor = .white
        setUpFooterRefresh()
    }

    fileprivate func setUpUI() {
        self.view.addSubview(searchView)
        self.view.addSubview(cancelButton)
        self.view.addSubview(bottomLineView)
        self.view.addSubview(tableView)
        
        searchView.inputTextField.becomeFirstResponder()
        searchView.inputTextField.delegate = self
        let saveRecentSearchTitles = NSKeyedUnarchiver.unarchiveObject(withFile: "saveRecentSearchTitles".cachesDir()) as? [String]
        if saveRecentSearchTitles != nil {
            historySearchTags = saveRecentSearchTitles!
        }
        
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
        
        historyScrollView.contentSize = CGSize(width: KScreenW, height: self.historySearch.Height)
        self.view.addSubview(historyScrollView)
        historyScrollView.addSubview(historySearch)
        
    }
    //设置底部刷新控件
    func setUpFooterRefresh() {
        let footerRefresh = MJRefreshBackNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreDataRequest))
        footerRefresh?.setTitle("上拉加载更多", for: .idle)
        footerRefresh?.setTitle("释放立即加载", for: .pulling)
        footerRefresh?.setTitle("干货加载中", for: .refreshing)
        tableView.mj_footer = footerRefresh
    }
    
    //底部刷新请求
    func loadMoreDataRequest() {
        let currentPage = self.currentPage + 1
        guard let text = self.searchView.inputTextField.text else { return }
        
        CLHNetworking.loadSearchRequest(text: text, page: currentPage, success: { (result) in
            guard let datas = result as? [CLHSearchGankModel] else {
                self.tableView.mj_footer.endRefreshing()
                return
            }
            
            self.dataArray.append(contentsOf: datas)
            self.tableView.reloadData()
            self.currentPage = currentPage
            self.tableView.mj_footer.endRefreshing()
            
        }) { (error) in
            self.tableView.mj_footer.endRefreshing()
        }
    }
    
    //取消按钮点击
    func cancelButtonClick() {
        print("cancelButtonClick")
        self.dismiss(animated: true, completion: nil)
    }
    
    func addHistorySearchTag(text: String) {
        for title in historySearchTags {
            if title == text { return }
        }
        self.historySearchTags.insert(text, at: 0)
        self.historySearch.addTag(tagTitle: text)
        NSKeyedArchiver.archiveRootObject(self.historySearchTags, toFile: "saveRecentSearchTitles".cachesDir())
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

//MARK: - 网络请求
extension CLHSearchViewController {
    func loadRequest(text: String) {
        self.lastSearchText = text
        SVProgressHUD.show(withStatus: "正在搜索干货")
        CLHNetworking.loadSearchRequest(text: text, page: 1, success: { (result) -> (Void) in
            if self.lastSearchText != text {
                return
            }
            guard let datasArray = result as? [CLHSearchGankModel] else { return }
//            print(result)
            self.tableView.isHidden = false
            self.historyScrollView.isHidden = true
            
            self.dataArray = datasArray
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }) { (error) -> (Void) in
            if self.lastSearchText != text { return }
            print(error)
        }
    }
}
//MARK: - UITableViewDelegate, UITableViewDataSource
extension CLHSearchViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataArray.count)
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! CLHSearchCell
        cell.searchModel = dataArray[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.dataArray[indexPath.row]
        let webVC = CLHHomeWebViewController()
        webVC.webURL = model.url
        webVC.gankModel = model
        self.navigationController?.pushViewController(webVC, animated: true)
    }
}
//MARK: - UITextFieldDelegate
extension CLHSearchViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        if text.unicodeScalars.count > 0 {
            loadRequest(text: text)
            self.addHistorySearchTag(text: text)
            self.view.endEditing(true)
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.tableView.isHidden = true
        self.historyScrollView.isHidden = false
    }
}

