//
//  CLHTopChooseViewController.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/8/2.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit

class CLHTopChooseViewController: CLHBaseViewController{

    /// 按钮字体大小
    open var buttonTitleFont: CGFloat = 12.0
    /// 按钮之间的间距
    open var buttonMarigin: CGFloat = 30.0
    /// 按钮背景颜色
    open var buttonBackgroudColor: UIColor = .white
    /// 按钮字体颜色
    open var buttonTitleColor: UIColor = .black
    /// 选中按钮字体颜色
    open var buttonTitleSelectColor: UIColor = .red
    /// 选中按钮底部下划线颜色
    open var buttonSelectedLineColor: UIColor = .red
    /// 选择下划线的高度
    open var buttonSelectedLineHeight: CGFloat = 2.0
    /// 是否显示选中下划线
    open var buttonSelectedLineHiden: Bool = false
    /// 顶部View高度
    open var titleViewHeight: CGFloat = 44.0
    /// 顶部背景颜色
    open var titleViewBackgroudColor: UIColor = .white
    /// 内容背景颜色
    open var contentViewBackgroudColor: UIColor = .white
    
    //标题按钮
    var titleButtons: [UIButton] = {
        var buttons = [UIButton]()
        return buttons
    }()
    //标题下的线
    var titleButtonLine: UIView = {
        let line = UIView()
        return line
    }()
    //顶部滚动条
    var titleScrollView: UIScrollView = {
        let scrollV = UIScrollView()
        return scrollV
    }()
    var selectedButton: UIButton?
    //内容
    var contentScrollView: UIScrollView = {
        let scrollV = UIScrollView()
        return scrollV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "AnICoo1"
        self.automaticallyAdjustsScrollViewInsets = false
        
    }
    
}

extension CLHTopChooseViewController {
    func setUpUI() {
        //        setUpChildViewController()
        setUpTitleView()
        setUpTitleLine()
        setUpContentView()
    }
    
    /// 初始化顶部
    fileprivate func setUpTitleView() {
        titleScrollView.frame = CGRect(x: 0, y: KNavHeight, width: KScreenW, height: titleViewHeight)
        titleScrollView.backgroundColor = titleViewBackgroudColor
        view.addSubview(titleScrollView)
        let btnW: CGFloat = 100
        let btnH: CGFloat = self.titleScrollView.bounds.size.height
        var btnX: CGFloat = 0
        let btnY: CGFloat = 0
        
        let count = childViewControllers.count
        //添加按钮
        var dis: CGFloat = 0.0
        for i in 0..<count {
            let btn = UIButton(type: .custom)
            btn.setTitle(childViewControllers[i].title, for: .normal)
            btn.setTitleColor(buttonTitleColor, for: .normal)
            btn.setTitleColor(buttonTitleSelectColor, for: .selected)
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: buttonTitleFont)
            btn.tag = i
            btnX = dis
            btn.frame = CGRect(x: btnX + buttonMarigin, y: btnY, width: btnW, height: btnH)
            btn.addTarget(self, action: #selector(titleButtonClick(button:)), for: .touchUpInside)
            btn.sizeToFit()
            dis = dis + btn.Width + buttonMarigin
            titleScrollView.addSubview(btn)
            titleButtons.append(btn)
            if i == 0 {
                titleButtonClick(button: btn)
            }
        }
        //设置标题滚动范围
        titleScrollView.contentSize = CGSize(width: dis + buttonMarigin, height: 0)
        titleScrollView.showsHorizontalScrollIndicator = false
    }
    //设置选中下划线
    fileprivate func setUpTitleLine() {
        titleButtonLine.isHidden = buttonSelectedLineHiden
        guard self.titleScrollView.subviews.count > 0 else {
            return
        }
        //获取第一个按钮
        let firstButton: UIButton = titleScrollView.subviews.first as! UIButton
        titleButtonLine.Height = buttonSelectedLineHeight
        titleButtonLine.Y = self.titleScrollView.Height - titleButtonLine.Height
        titleButtonLine.backgroundColor = buttonSelectedLineColor
        titleScrollView.addSubview(titleButtonLine)
        //第一个按钮选中
        firstButton.isSelected = true
        selectedButton = firstButton
        
        firstButton.titleLabel?.sizeToFit()
        titleButtonLine.Width = (firstButton.titleLabel?.Width)! + 10
        titleButtonLine.center = CGPoint(x: firstButton.center.x, y: self.titleButtonLine.center.y)
        
    }
    
    fileprivate func setUpContentView() {
        let maxY: CGFloat = self.titleScrollView.frame.maxY
        contentScrollView.frame = CGRect(x: 0, y: maxY, width: KScreenW, height: self.view.bounds.size.height - maxY)
        print(contentScrollView.frame)
        view.addSubview(contentScrollView)
        contentScrollView.isPagingEnabled = true
        contentScrollView.bounces = false
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.delegate = self
        //设置内容滚动范围
        contentScrollView.contentSize = CGSize(width: contentScrollView.bounds.size.width * CGFloat(childViewControllers.count), height: contentScrollView.bounds.size.height)
        
    }
    /*
     func addChildViewController() {
     
     }
     
     
     fileprivate func setUpChildViewController() {
     let vc1 = UIViewController()
     vc1.view.backgroundColor = .red
     vc1.title = "v11241"
     addChildViewController(vc1)
     
     let vc2 = UIViewController()
     vc2.view.backgroundColor = .yellow
     vc2.title = "v2412"
     addChildViewController(vc2)
     for i in 0...5 {
     let vc3 = UIViewController()
     vc3.view.backgroundColor = .blue
     vc3.title = "v32"
     addChildViewController(vc3)
     }
     }
     */
}

extension CLHTopChooseViewController {
    func titleButtonClick(button: UIButton) {
        //1.标题改变
        buttonClick(button: button)
        UIView.animate(withDuration: 0.25, animations: {
            self.titleButtonLine.Width = (button.titleLabel?.Width)! + 10
            self.titleButtonLine.center = CGPoint(x: button.center.x, y: self.titleButtonLine.center.y)
        }) { (finished) in
            //2.内容滚动
            self.contentChange(To: button.tag)
            //标题居中
            self.titleInMiddlePlace(button: button)
        }
        
    }
    fileprivate func buttonClick(button: UIButton) {
        selectedButton?.isSelected = false
        button.isSelected = true
        selectedButton = button
    }
    
    fileprivate func contentChange(To: NSInteger) {
        let VC = self.childViewControllers[To]
        VC.view.frame = CGRect(x: CGFloat(To) * KScreenW, y: 0, width: KScreenW, height: contentScrollView.bounds.size.height)
        contentScrollView.addSubview(VC.view)
        //内容滚动视图滚到相应的位置
        contentScrollView.contentOffset = CGPoint(x: CGFloat(To) * KScreenW, y: 0)
        
    }
    
    fileprivate func titleInMiddlePlace(button: UIButton) {
        var offsetX: CGFloat = button.center.x - KScreenW * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        
        let maxOffsetX: CGFloat = self.titleScrollView.contentSize.width - KScreenW
        if offsetX > maxOffsetX {
            offsetX = maxOffsetX
        }
        
        titleScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

extension CLHTopChooseViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //计算标题的变化位置
        let i: NSInteger = NSInteger(scrollView.contentOffset.x / view.bounds.size.width)
        titleButtonClick(button: titleScrollView.subviews[i] as! UIButton)
    }
}
