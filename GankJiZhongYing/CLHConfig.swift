//
//  CLHConfig.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/7/24.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit
import Foundation

//MARK: - 屏幕
let KScreenW = UIScreen.main.bounds.size.width
let KScreenH = UIScreen.main.bounds.size.height
let KWindow = UIApplication.shared.keyWindow

//MARK: - 控件高度
let KStatusBarHeight: CGFloat = 20.0
let KTopBarHeight: CGFloat = 44.0
let KNavBarHeight: CGFloat = 64.0
let KBottomBarHeight: CGFloat = 49.0
//MARK: - 颜色
let UIColorMainBG = RGBColor(r: 239, g: 239, b: 245, alpha: 1)
let UIColorTextLightGray = RGBColor(r: 153, g: 153, b: 153, alpha: 1)
let UIColorTextGray = RGBColor(r: 99, g: 99, b: 99, alpha: 1)
let UIColorTextBlock = RGBColor(r: 47, g: 47, b: 47, alpha: 1)
let UIColorTextBlue = RGBColor(r: 40, g: 154, b: 236, alpha: 1)
let UIColorMainBlue = RGBColor(r: 30, g: 130, b: 210, alpha: 1)
let UIColorLine = RGBColor(r: 217, g: 217, b: 217, alpha: 1)

//MARK: - 网络请求
let baseURL = "http://gank.io/api/"

//通过十进制RGB
func RGBColor(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) -> UIColor{
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
}
//通过十六进制RGB
func RGBColor(_ hex: String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in:.whitespaces).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString = (cString as NSString).substring(from: 1)
    }
    
    let rString = (cString as NSString).substring(to: 2)
    let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
    let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    Scanner(string: rString).scanHexInt32(&r)
    Scanner(string: gString).scanHexInt32(&g)
    Scanner(string: bString).scanHexInt32(&b)
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
}
