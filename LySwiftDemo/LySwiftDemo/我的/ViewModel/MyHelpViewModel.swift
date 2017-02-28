//
//  MyHelpViewModel.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/28.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit
enum MyHelpViewModelType {
    case online
    case phone
    case qq
    case weixin
}
class MyHelpViewModel: NSObject {

    var model : MyHelpModel?
    
    var time : String?
    var title : String?
    var number : String?
    var icon : UIImage?
    
    init(model : MyHelpModel , type : MyHelpViewModelType) {
        super.init()
        
        self.model = model
        
        time = "人工服务时段:\((model.service_time)!)\n其他时段(请留言)"
        
        switch type {
        case .online:
            self.title = "在线咨询"
            self.number = "与客服在线即时对话"
            self.icon = UIImage.init(named: "apply_bottom_ic_mine")
        case .phone:
            self.title = "电话客服"
            self.number = model.phone
            self.icon = UIImage.init(named: "apply_share_ic_qzone")
        case .qq:
            self.title = "qq客服"
            self.number = model.qq
            self.icon = UIImage.init(named: "apply_share_ic_qq")
        case .weixin:
            self.title = "官方微信"
            self.number = model.weixin
            self.icon = UIImage.init(named: "apply_share_ic_wechat")
        }
    }
}
