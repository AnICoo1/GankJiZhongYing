//
//  CLHSubSearchView.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/7/26.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit

class CLHSubSearchView: UIView {

    
    var imageView: UIImageView = {
        let imageV = UIImageView(image: UIImage(named: "icon_search_blue.png"))
        return imageV
    }()
    
    var inputTextField: UITextField = {
        let inputTF = UITextField()
        inputTF.placeholder = "搜索更多干货"
        inputTF.font = UIFont.boldSystemFont(ofSize: 14.0)
        return inputTF
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAll()
    }
    
    func setUpAll() {
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        self.backgroundColor = RGBColor(r: 243.0, g: 243.0, b: 243.0, alpha: 1.0)
        self.addSubview(imageView)
        self.addSubview(inputTextField)
        
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self).offset(3)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        inputTextField.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(5)
            make.right.equalTo(self).offset(-5)
            make.top.equalTo(imageView)
            make.height.equalTo(30)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
