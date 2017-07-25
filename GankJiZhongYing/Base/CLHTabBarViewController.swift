//
//  CLHTabBarViewController.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/7/24.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit

class CLHTabBarViewController: UITabBarController {

    lazy var homeVC: UINavigationController = {
        let homeVC = CLHHomeViewController()
        let nav = self.setUpNav(rootVC: homeVC, tabTitle: "首页", tabBarImage: UIImage(named: "tabbar_home")!, tabBarSelectImage: UIImage(named: "tabbar_home_highlighted")!, title: "最新干货")
        return nav
    }()
    
    lazy var gankVC: UINavigationController = {
        let gankVC = CLHGankViewController()
        let nav = self.setUpNav(rootVC: gankVC, tabTitle: "干货", tabBarImage: UIImage(named: "find")!, tabBarSelectImage: UIImage(named: "find_select")!, title: "干货")
        return nav
    }()
    
    lazy var mineVC: UINavigationController = {
        let mineVC = CLHMineViewController()
        let nav = self.setUpNav(rootVC: mineVC, tabTitle: "我的", tabBarImage: UIImage(named: "property")!, tabBarSelectImage: UIImage(named: "property_select")!, title: "我的")
        return nav
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTab()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    fileprivate func setUpNav(rootVC: CLHBaseViewController, tabTitle: String, tabBarImage: UIImage, tabBarSelectImage: UIImage, title: String) -> UINavigationController{
        rootVC.tabBarItem.title = tabTitle
        rootVC.tabBarItem.image = tabBarImage
        rootVC.tabBarItem.selectedImage = tabBarSelectImage
        rootVC.title = title
        let nav = UINavigationController(rootViewController: rootVC)
        return nav
    }
    
    func setUpTab() {
        viewControllers = [homeVC, gankVC, mineVC]
//        addChildViewController(homeVC)
//        addChildViewController(gankVC)
//        addChildViewController(mineVC)
        self.tabBar.backgroundImage = UIImage(named: "tabBar_bgwhiteColor")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
