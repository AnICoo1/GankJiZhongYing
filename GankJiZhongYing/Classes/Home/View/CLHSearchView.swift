//
//  CLHSearchView.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/7/24.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit
import SnapKit

class CLHSearchView: UIView {

    
    var searchLabel: UILabel = {
        let label = UILabel()
        label.text = "搜索"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        return label
    }()
    var searchImage: UIImageView = {
        let imageV = UIImageView(image: UIImage(named: "icon_search_blue.png"))
        return imageV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAll()
        let tap = UITapGestureRecognizer(target: self, action: #selector(showSearchVC))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpAll() {
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        self.backgroundColor = UIColorTextBlue
        self.addSubview(searchImage)
        self.addSubview(searchLabel)
        searchImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(self).offset(5)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        searchLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(searchImage).offset(searchImage.Width + 5)
        }
    }
    
    func showSearchVC() {
        
    }
    
}
