//
//  CLHBaseViewController.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/7/24.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit

class CLHBaseViewController: UIViewController {

    
    var popHandler: (() -> (Void))?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNav()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if navigationController?.viewControllers.count == 1 {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
        else {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }
    
    fileprivate func setUpNav() {
        //是否具有右滑返回功能
        if (navigationController?.viewControllers.count)! > 1 {
            navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
            popHandler = { [unowned self] in
                guard let navigationController = self.navigationController else { return }
                navigationController.popViewController(animated: true)
                
            }
        }
        
        
        self.navigationController?.navigationBar.barTintColor = UIColorMainBlue
        let titleColor = UIColor.white
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: titleColor, NSFontAttributeName: UIFont.systemFont(ofSize: 19)]
        
        if (navigationController?.viewControllers.count)! > 1 {
            navigationController?.navigationBar.tintColor = UIColorMainBlue
            let oriImage = UIImage(named: "nav_back_blue")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: oriImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
        }

    }
    
    func back() {
        if popHandler != nil {
            popHandler!()
        }
    }

}
