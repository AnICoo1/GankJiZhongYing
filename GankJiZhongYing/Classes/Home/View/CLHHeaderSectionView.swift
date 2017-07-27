//
//  CLHHeaderSectionView.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/7/27.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit
import SnapKit

class CLHHeaderSectionView: UIView {

    var lineView: UIView = {
        let lineV = UIView()
        lineV.backgroundColor = UIColorMainBlue
        return lineV
    }()
    
    var titleLabel: UILabel = {
        let titleL = UILabel()
        titleL.font = UIFont.boldSystemFont(ofSize: 13.0)
        titleL.textColor = .black
        return titleL
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAll()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setUpAll() {
        addSubview(lineView)
        addSubview(titleLabel)
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(11)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(3)
            make.height.equalTo(12)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(lineView.snp.right).offset(10)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
}
