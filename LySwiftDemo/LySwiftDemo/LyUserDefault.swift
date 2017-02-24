//
//  LyUserDefault.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/22.
//  Copyright © 2017年 张杰. All rights reserved.
//  定义宏，常量

import UIKit

class LyUserDefault: NSObject {

    
    //MARK: UserInfo，登录的时候需要缓存的
    //用户token
    let UserInfo_token = "UserInfo_token"
    //年级id
    let UserInfo_gid = "UserInfo_gid"
    //用户phonenumber
    let UserInfo_phonenumber = "UserInfo_phonenumber"
    //用户头像
    let UserInfo_icon = "UserInfo_icon"
    
    //MARK: 常量
    let IS_IOS7 = (UIDevice.current.systemVersion as NSString).doubleValue >= 7.0
    //屏幕宽
    let screenW = UIScreen.main.bounds.size.width
    //屏幕高
    let screenH = UIScreen.main.bounds.size.height
    //NavBarHeight
    let NavBarHeight = (UIDevice.current.systemVersion as NSString).doubleValue >= 7.0 ? 64 : 44
    
    let BottomHeight = 49
    
    //MARK:颜色
    let ColorWhite = UIColor.white
    let ColorGray = UIColor.init(colorLiteralRed: 243/255.0, green: 244/255.0, blue: 245/255.0, alpha: 1)
    let ColorBlue = UIColor.init(colorLiteralRed: 52/255.0, green: 157/255.0, blue: 246/255.0, alpha: 1)
    let ColorDarkGrey = UIColor.init(colorLiteralRed: 17/255.0, green: 17/255.0, blue: 17/255.0, alpha: 1)
    let ColorLightGray = UIColor.init(colorLiteralRed: 151/255.0, green: 151/255.0, blue: 151/255.0, alpha: 1)
    
    //Mark:字体
    let FontLarge = UIFont.systemFont(ofSize: 15)
    let FontNormal = UIFont.systemFont(ofSize: 14)
    let FontSmall = UIFont.systemFont(ofSize: 13)
    
    //MARK:分割线
    let seperateLineW = 10
}
