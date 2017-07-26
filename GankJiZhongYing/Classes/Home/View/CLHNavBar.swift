//
//  CLHNavBar.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/7/24.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit

class CLHNavBar: UIView {
    
    lazy var searchView: CLHSearchView = {
        let W: CGFloat = 80
        let searchV = CLHSearchView(frame: CGRect(x: KScreenW - W - 15, y: 27, width: W, height: 30))
        return searchV
    }()
    
    var bgColorAlpha: CGFloat = 0 {
        didSet{
            self.backgroundColor = UIColorMainBlue.withAlphaComponent(bgColorAlpha)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        addSubview(searchView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLongSearchView() {
        UIView.animate(withDuration: 0.5) {
            self.searchView.frame = CGRect(x: 15, y: 27, width: KScreenW - 30, height: 30)
            self.searchView.searchLabel.text = "搜索更多干货"
            self.searchView.searchLabel.sizeToFit()
        }
    }
    
    func showShortSearchView() {
        let W: CGFloat = 80
        UIView.animate(withDuration: 0.5) {
            self.searchView.frame = CGRect(x: KScreenW - W - 15, y: 27, width: W, height: 30)
            self.searchView.searchLabel.text = "搜索"
            self.searchView.searchLabel.sizeToFit()
        }
    }
}
