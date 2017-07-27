//
//  CLHSearchListView.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/7/27.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit

class CLHSearchListView: UIView {

    
    var tagButtonArray = [CLHSearchTagButton]()
    var tagButtontitleArray = [String]()
    
    
    
    fileprivate var nowHeight :  CGFloat {
        get{
            return (tagButtonArray.count <= 0 ? 30.0 : ((tagButtonArray.last?.MaxY)! + margin))
        }
    }
    
    var listLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13.0)
        label.textColor = UIColorTextBlock
        label.text = "历史搜索"
        label.sizeToFit()
        return label
    }()
    
    var cleanButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "icon_clean"), for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = .blue
        setUpUI()
    }
    
    func setUpUI() {
        addSubview(listLabel)
        addSubview(cleanButton)
        
        listLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(10)
        }
        
        cleanButton.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - Method
extension CLHSearchListView{
    //添加一个tag按钮
    func addTag(tagTitle: String) {
        self.isHidden = false
        
        let newBtn = CLHSearchTagButton()
        newBtn.tag = tagButtonArray.count
        newBtn.setTitle(tagTitle, for: .normal)
        //新按钮添加长按手势
        let longPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(tagButtonLongPress(longPress:)))
        newBtn.addGestureRecognizer(longPress)
        //新按钮添加点击事件
        newBtn.addTarget(self, action: #selector(tagButtonClick(button:)), for: .touchUpInside)
        
        tagButtonArray.insert(newBtn, at: 0)
        
        tagButtontitleArray.insert(tagTitle, at: 0)
        
        updateTag()
        
        updateAllTagButton()
        
        
        self.Height = self.nowHeight
        self.addSubview(newBtn)
        //print("self.height = \(self.Height)")
    }
    //添加多个tag按钮
    func addSomeTags(tags: [String]) {
        for i in 0..<tags.count {
            addTag(tagTitle: tags[tags.count - 1 - i])
        }
    }
    //删除一个按钮
    func deleteTag(button: CLHSearchTagButton) {
        button.removeFromSuperview()
        tagButtonArray.remove(at: button.tag)
        tagButtontitleArray.remove(at: button.tag)
        
        updateTag()
        
        updateAllTagButton()
        
        // 更新当前View的frame
        UIView.animate(withDuration: 0.25, animations: {
            if self.tagButtonArray.count == 0 {
                self.Height = 0
                self.isHidden = true
            } else {
                self.Height = self.nowHeight
            }
        })
    }
    //删除全部按钮
    func deleteAllTag() {
        
    }
    //更新按钮的tag
    func updateTag() {
        for i in 0..<tagButtonArray.count {
            let button = tagButtonArray[i]
            button.tag = i
        }
    }
    //更新所有按钮位置
    func updateAllTagButton() {
        
        for i in 0..<tagButtonArray.count {
            let button = tagButtonArray[i]
            var lastButton: CLHSearchTagButton? = nil
            if i > 0 {
                lastButton = tagButtonArray[i - 1]
            }
            button.frame = getCurrentTagButtonFrame(button: button, lastButton: lastButton)
            
        }
    }
    //获取按钮应该在的位置
    func getCurrentTagButtonFrame(button: CLHSearchTagButton, lastButton: CLHSearchTagButton?) -> CGRect {
        var btnX: CGFloat = 0
        var btnY: CGFloat = 0
        var btnW: CGFloat = 0
        var btnH: CGFloat = 0
        
        if  let lastButton = lastButton {
            btnX = margin + lastButton.frame.maxX
            btnY = lastButton.Y
        } else {
            btnX = margin
            btnY = margin * 4.0
        }
        
        let text = button.titleLabel!.text! as NSString
        let titleW = text.size(attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 12)]).width
        let titleH = text.size(attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 12)]).height
        
        btnH = titleH + 2 * button.margin
        btnW = (titleW + 2 * button.margin) > (KScreenW - 2 * margin) ? (KScreenW - 2 * margin) : (titleW + 2 * button.margin)
        
        let rightWidth = self.Width - btnX
        
        if rightWidth - margin < btnW {
            if  let lastButton = lastButton {
                btnX = margin
                btnY = margin + lastButton.frame.maxY
            } else {
                btnX = margin
                btnY = margin * 4.0
            }
        }
        
        let frame: CGRect = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
        return frame
    }
    //长按按钮触发事件
    func tagButtonLongPress(longPress: UILongPressGestureRecognizer) {
        let point = longPress.location(in: self)
        
        let button = getFocusButton(point: point)
        
        if longPress.state == .began {
            enterEditModel(button: button)
        }
    }
    //获取选中的按钮
    func getFocusButton(point: CGPoint) -> CLHSearchTagButton {
        var button: CLHSearchTagButton? = nil
        for btn in tagButtonArray {
            if btn.frame.contains(point) {
                button = btn
                break
            }
        }
        return button!
    }
    //按钮进入编辑状态
    func enterEditModel(button: CLHSearchTagButton) {
        button.setImage(UIImage(named: "close_button"), for: .normal)
    }
    
    func tagButtonClick(button: CLHSearchTagButton) {
//        deleteTag(button: button)
        guard let image = button.imageView?.image else {
            print("click button")
            return
        }
        deleteTag(button: button)
    }
}

