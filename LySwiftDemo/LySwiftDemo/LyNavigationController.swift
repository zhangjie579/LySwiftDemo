//
//  LyNavigationController.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/21.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class LyNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBarTheme()
        setupBarButtonItemTheme()
    }

    //1.设置导航栏主题
    func setupNavBarTheme() {
        let navBar = UINavigationBar.appearance()
        
        //1.背景
        navBar.setBackgroundImage(LyClassTool.creatImageWithColor(color: UIColor.init(colorLiteralRed: 52/255.0, green: 157/255.0, blue: 246/255.0, alpha: 1)), for: UIBarMetrics.default)
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        navBar.shadowImage = UIImage.init()
        
        var textAttrs : [String : AnyObject] = [String : AnyObject]()
        textAttrs[NSForegroundColorAttributeName] = UIColor.white
        textAttrs[NSFontAttributeName] = UIFont.systemFont(ofSize: 15)
        navBar.titleTextAttributes = textAttrs
    }
    
    //2.设置导航栏按钮主题
    func setupBarButtonItemTheme() {
        let item = UIBarButtonItem.appearance()
        
        var textAttrs : [String : AnyObject] = [String : AnyObject]()
        
        // 设置文字属性
        textAttrs[NSForegroundColorAttributeName] = UIColor.white;
        textAttrs[NSFontAttributeName] = UIFont.systemFont(ofSize: 16);
        
        //正常状态下
        item.setTitleTextAttributes(textAttrs, for: UIControlState.normal)
        
        //高亮状态下
        item.setTitleTextAttributes(textAttrs, for: UIControlState.highlighted)
        
        var disableTextAttrs : [String : AnyObject] = [String : AnyObject]()
        
        disableTextAttrs[NSForegroundColorAttributeName] = UIColor.lightGray
        
        //失效状态下
        item.setTitleTextAttributes(disableTextAttrs, for: UIControlState.disabled)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if (self.viewControllers.count > 0) {
            viewController.hidesBottomBarWhenPushed = true
            
            initNav(viewController: viewController)
        }
        super.pushViewController(viewController, animated: animated)
    }

    private func initNav(viewController: UIViewController) {
        let left = UIBarButtonItem(title: "返回", style: .done, target: self, action: #selector(backTo))
//        let leftSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
//        leftSpace.width = -20
        viewController.navigationItem.leftBarButtonItem = left
    }
    
    @objc private func backTo() {
        self.popViewController(animated: true)
    }
}
