//
//  CLHBottomView.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/8/3.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit

class CLHBottomView: UIView {

    var  authorButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(UIColor.lightGray, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12.0)
        btn.setImage(UIImage(named: "icon_editor.png"), for: .normal)
        return btn
    }()
    
    var  dataButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(UIColor.lightGray, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12.0)
        btn.setImage(UIImage(named: "icon_time.png"), for: .normal)
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAll()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setUpAll() {
        addSubview(dataButton)
        addSubview(authorButton)
        
        dataButton.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(0)
            make.left.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
            make.width.equalTo(self.Width * 0.5)
        }
        
        authorButton.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(0)
            make.left.equalTo(dataButton.snp.right).offset(0)
            make.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
    }
}
