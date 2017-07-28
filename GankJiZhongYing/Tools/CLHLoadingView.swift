//
//  CLHLoadingView.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/7/28.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit

class CLHLoadingView: UIView {

    
    var loadingImageview: UIImageView = {
        
        let imageV = UIImageView()
        return imageV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        addSubview(loadingImageview)
        loadingImageview.snp.makeConstraints { (make) in
            make.height.equalTo(300)
            make.width.equalTo(300)
            make.center.equalTo(self)
        }
        var images = [UIImage]()
        for i in 1...8 {
            let image = UIImage(named: "loading\(i)")
            images.append(image!)
        }
        loadingImageview.animationDuration = 1
        loadingImageview.animationRepeatCount = Int(MAXINTERP)
        loadingImageview.animationImages = images
        loadingImageview.startAnimating()
//        loadingImageview.center = self.center
    }

}
