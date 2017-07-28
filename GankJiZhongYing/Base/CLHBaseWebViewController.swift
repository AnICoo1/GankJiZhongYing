//
//  CLHBaseWebViewController.swift
//  GankJiZhongYing
//
//  Created by AnICoo1 on 2017/7/28.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

import UIKit
import WebKit

class CLHBaseWebViewController: CLHBaseViewController {

    var webURL: String?
    
    var webView: WKWebView = {
        let webV = WKWebView(frame: CGRect(x: 0, y: 0, width: KScreenW, height: KScreenH))
        webV.isMultipleTouchEnabled = true
        webV.autoresizesSubviews = true
        webV.scrollView.alwaysBounceVertical = true
        return webV
    }()
    
    var  progressBar: UIProgressView = {
        let progressV = UIProgressView(progressViewStyle: .default)
        progressV.frame = CGRect(x: 0, y: KNavHeight, width: KScreenW, height: 2)
        progressV.progressTintColor = UIColorTextBlue
        progressV.trackTintColor = UIColor.white
        progressV.alpha = 0.0
        return progressV
    }()
    
    var loadingView: CLHLoadingView = {
        let loadingV = CLHLoadingView(frame: CGRect(x: 0, y: 0, width: KScreenW, height: KScreenH))
        return loadingV
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        loadWithURLString(urlString: webURL)
    }

    fileprivate func setUpUI() {
        view.addSubview(webView)
        view.addSubview(progressBar)
        view.addSubview(loadingView)
        
        webView.navigationDelegate = self
        //添加网页加载监听
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        popHandler = { [unowned self] in
            self.didBackButtonClick()
        }
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressBar.alpha = 1.0
            let animated = CGFloat(webView.estimatedProgress) > CGFloat(self.progressBar.progress)
            progressBar.setProgress(Float(webView.estimatedProgress), animated: animated)
            
            if webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.5, animations: {
                    self.progressBar.alpha = 0.0
                }, completion: { (_) in
                    self.progressBar.setProgress(0.0, animated: false)
                })
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.navigationDelegate = nil
    }
    
    func setupLeftBarButtonItems(shouldShow: Bool) {
        if shouldShow {
            let backImage = UIImage(named: "nav_back")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            let backBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
            backBtn.setImage(backImage, for: .normal)
            backBtn.addTarget(self, action: #selector(didBackButtonClick), for: .touchUpInside)
            let backItem = UIBarButtonItem(customView: backBtn)
            
            let spaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil)
            spaceItem.width = 25
            
            let closeImage = UIImage(named: "icon_close_second")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            let closeBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
            closeBtn.setImage(closeImage, for: .normal)
            closeBtn.addTarget(self, action: #selector(webViewPop), for: .touchUpInside)
            let closeItem = UIBarButtonItem(customView: closeBtn)
            
            navigationItem.leftBarButtonItems = [backItem, spaceItem, closeItem]
        }
    }
    
    func loadWithURLString(urlString: String?) {
        
        guard let urlString = urlString else { return }
        guard let url = URL(string: urlString) else { return }
        
        self.webView.load(URLRequest(url: url))
    }
    
    func didBackButtonClick() {
        if self.webView.canGoBack {
            self.webView.goBack()
            setupLeftBarButtonItems(shouldShow: true)
        } else {
            webViewPop()
            setupLeftBarButtonItems(shouldShow: false)
        }
    }
    
    func webViewPop() {
        guard let navigationController = self.navigationController else { return }
        navigationController.popViewController(animated: true)
    }
    
}

extension CLHBaseWebViewController: WKNavigationDelegate {
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.title = "详细内容"
    }
    
    // 开始获取到网页内容时返回
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        loadingView.isHidden = true
    }
}
