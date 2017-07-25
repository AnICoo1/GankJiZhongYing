//
//  CLHHomeCell.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/7/24.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit
import SnapKit

class CLHHomeCell: UITableViewCell {

    
    
    
    fileprivate var lineView: UIView = {
        let lineV = UIView()
        lineV.backgroundColor = UIColorLine
        return lineV
    }()
    
    fileprivate var nameButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("AnICoo1", for: .normal)
        btn.setImage(UIImage(named: "icon_user1.png") , for: .normal)
        btn.setTitleColor(RGBColor(r: 47.0, g: 47.0, b: 47.0, alpha: 1.0), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12.0)
        print("test")
        return btn
    }()
    
    fileprivate var contentLabel: UILabel = {
       let label = UILabel()
        label.text = "hello worldhello worldhello worldhello worldhello worldhello worldhello world"
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = RGBColor(r: 47.0, g: 47.0, b: 47.0, alpha: 1.0)
        return label
    }()
    
    fileprivate var moreButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(UIColorTextBlue, for: .normal)
        btn.setTitle("全文", for: .normal)
        btn.setTitle("收起", for: .selected)
        return btn
    }()
    
    fileprivate var dataButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("2017-07-24", for: .normal)
        btn.setImage(UIImage(named: "icon_time.png") , for: .normal)
        btn.setTitleColor(UIColor.lightGray, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12.0)
        return btn
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpAll() {
        addSubview(lineView)
        addSubview(nameButton)
        addSubview(contentLabel)
        addSubview(dataButton)
        
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self)
            make.height.equalTo(1)
        }
        
        nameButton.snp.makeConstraints { (make) in
            make.top.equalTo(lineView).offset(8)
            make.left.equalTo(self).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(15)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(nameButton).offset(8)
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel).offset(10)
            make.left.equalTo(contentLabel)
            make.height.equalTo(10)
            make.width.equalTo(20)
        }
        
        dataButton.snp.makeConstraints { (make) in
            make.left.equalTo(contentLabel)
            make.right.equalTo(contentLabel)
            make.top.equalTo(contentLabel).offset(8)
            make.height.equalTo(15)
        }
    }
    
}
