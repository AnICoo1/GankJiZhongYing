//
//  CLHSearchCell.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/7/27.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit

class CLHSearchCell: UITableViewCell {

    
    
    
    var searchModel: CLHSearchGankModel! {
        didSet{
            descriptionLabel.text = searchModel.desc
            dataButton.setTitle(searchModel.publishedAt, for: .normal)
            authorButton.setTitle(searchModel.author, for: .normal)
        }
    }
    
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColorTextBlock
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        return label
    }()
    
    var dataButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "icon_time.png"), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12.0)
        btn.setTitleColor(.lightGray, for: .normal)
        return btn
    }()
    
    var authorButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "icon_class.png"), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12.0)
        btn.setTitleColor(.lightGray, for: .normal)
        return btn
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layoutMargins = .zero
        setUpAll()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    fileprivate func setUpAll() {
        addSubview(descriptionLabel)
        addSubview(dataButton)
        addSubview(authorButton)
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.top.equalTo(self).offset(12)
        }
        
        dataButton.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.bottom.equalTo(self).offset(0)
            make.width.equalTo(97)
            make.height.equalTo(20)
        }
        
        authorButton.snp.makeConstraints { (make) in
            make.left.equalTo(dataButton).offset(0)
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(self).offset(0)
            make.height.equalTo(20)
        }
        
        dataButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
        authorButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
