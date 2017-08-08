//
//  CLHTagGankCell.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/8/3.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit
import SnapKit

class CLHTagGankCell: UITableViewCell {

    /// 全文按钮点击
    var moreButtonClickHandler: ((_ indexPath: IndexPath) -> (Void))?
    lazy var lineView: UIView = {
        let lineV = UIView()
        lineV.backgroundColor = UIColorLine
        self.contentView.addSubview(lineV)
        return lineV
    }()
    //首行没有上面的分割线
    var indexPath: IndexPath! {
        didSet{
            self.lineView.isHidden = (indexPath.row == 0)
        }
    }
    
    var gankModel: CLHGankModel! {
        didSet{
            contentLabel.text = gankModel.desc
            bottomView.dataButton.setTitle(gankModel.publishedAt, for: .normal)
            bottomView.authorButton.setTitle(gankModel.author, for: .normal)
            
            moreButton.isHidden = !gankModel.isShouldOpen
            if gankModel.isOpen {
                contentLabel.numberOfLines = 0
                moreButton.setTitle("收起", for: .normal)
            } else {
                contentLabel.numberOfLines = 3
                moreButton.setTitle("全文", for: .normal)
            }
            if gankModel.isShouldOpen == false {
                moreButton.snp.remakeConstraints({ (make) in
                    make.top.equalTo(contentLabel.snp.bottom).offset(0)
                    make.left.equalTo(contentLabel)
                    make.height.equalTo(0)
                    make.width.equalTo(0)
                })
            }
            
        }
    }
    /// 内容
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = UIColor.black
        self.contentView.addSubview(label)
        return label
    }()
    /// 收起按钮
    lazy var moreButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("全文", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.titleLabel?.textAlignment = .left
        btn.setTitleColor(UIColorMainBlue, for: .normal)
        btn.addTarget(self, action: #selector(moreButtonClick(button:)), for: .touchUpInside)
        self.contentView.addSubview(btn)
        return btn
    }()
    /// 图片
    var photoView: CLHMiddleImageView = {
        let middleV = CLHMiddleImageView(frame: CGRect.zero)
        return middleV
    }()
    /// 底部信息栏
    lazy var bottomView: CLHBottomView = {
        let bottomV = CLHBottomView()
//        bottomV.backgroundColor = .red
        self.contentView.addSubview(bottomV)
        return bottomV
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpAll()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}


extension CLHTagGankCell {
    fileprivate func setUpAll() {
        
        
//        contentView.addSubview(moreButton)
        contentView.addSubview(photoView)
        
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.right.equalTo(self).offset(0)
            make.height.equalTo(2)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.left.equalTo(contentLabel)
            make.height.equalTo(20)
            make.width.equalTo(40)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(self).offset(0)
            make.height.equalTo(30)
        }
        
    }
    
    func moreButtonClick(button: UIButton) {
        self.gankModel._cellHeight = nil
        if moreButtonClickHandler != nil {
            moreButtonClickHandler!(self.indexPath)
        }
    }
}

