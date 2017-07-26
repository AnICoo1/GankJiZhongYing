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

    
    
    var moreButtonClickHandler: ((_ indexPath: IndexPath) -> (Void))?
    
    //首行没有上面的分割线
    var indexPath: IndexPath! {
        didSet{
            self.lineView.isHidden = (indexPath.row == 0)
        }
    }
    
    
    var homeGank: CLHHomeModel! {
        didSet{
            nameButton.setTitle(homeGank.author, for: .normal)
            contentLabel.text = homeGank.desc
            
            if homeGank.isOpen {
                moreButton.setTitle("收起", for: .normal)
                contentLabel.numberOfLines = 0
            } else {
                moreButton.setTitle("全文", for: .normal)
                contentLabel.numberOfLines = 3
            }
            
            if homeGank.shouldOpen == false {
                moreButton.snp.remakeConstraints({ (make) in
                    make.top.equalTo(contentLabel.snp.bottom).offset(0)
                    make.left.equalTo(contentLabel)
                    make.height.equalTo(0)
                    make.width.equalTo(0)
                })
            }
            
            dataButton.setTitle(homeGank.publishedAt, for: .normal)
            
            
        }
    }
    
    lazy var lineView: UIView = {
        let lineV = UIView()
        lineV.backgroundColor = UIColorLine
        self.contentView.addSubview(lineV)
        return lineV
    }()
    
    lazy var nameButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("AnICoo1", for: .normal)
        btn.setImage(UIImage(named: "icon_user1.png") , for: .normal)
        btn.setTitleColor(RGBColor(r: 47.0, g: 47.0, b: 47.0, alpha: 1.0), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12.0)
        btn.backgroundColor = .red
        self.contentView.addSubview(btn)
        return btn
    }()
    
    lazy var contentLabel: UILabel = {
       let label = UILabel()
        //label.text = "hello worldhello worldhello worldhello worldhello worldhello worldhello world"
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = RGBColor(r: 47.0, g: 47.0, b: 47.0, alpha: 1.0)
        label.backgroundColor = .blue
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(UIColorTextBlue, for: .normal)
        btn.setTitle("全文", for: .normal)
        btn.backgroundColor = .yellow
        btn.addTarget(self, action: #selector(moreButtonClick(button:)), for: .touchUpInside)
        self.contentView.addSubview(btn)
        return btn
    }()
    
    lazy var dataButton: UIButton = {
        let btn = UIButton(type: .custom)
        //btn.setTitle("2017-07-24", for: .normal)
        btn.setImage(UIImage(named: "icon_time.png") , for: .normal)
        btn.setTitleColor(UIColor.lightGray, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12.0)
        btn.backgroundColor = .green
        self.contentView.addSubview(btn)
        return btn
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.isUserInteractionEnabled = true
        setUpAll()
        //nameButton.setTitle("AnICoo1", for: .normal)
        //contentLabel.text = "hello worldxxxxxxxx"
        //dataButton.setTitle("xxxxxx", for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpAll() {
        
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
            make.top.equalTo(nameButton.snp.bottom).offset(8)
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.left.equalTo(contentLabel)
            make.height.equalTo(20)
            make.width.equalTo(40)
        }
        
        dataButton.snp.makeConstraints { (make) in
            make.left.equalTo(contentLabel)
            make.right.equalTo(contentLabel)
            make.top.equalTo(moreButton.snp.bottom).offset(8)
            make.height.equalTo(15)
        }
        
    }
    
    func moreButtonClick(button: UIButton) {
        if moreButtonClickHandler != nil {
            moreButtonClickHandler!(self.indexPath)
        }
    }
}
