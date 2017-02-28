//
//  MyHelpModel.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/28.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class MyHelpModel: NSObject {

    var phone : String?
    var qq : String?
    var weixin : String?
    var service_time : String?
    var online_service_url : String?
    
    init(dict : [String : String]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKeyPath keyPath: String) {
        super.setValue(value, forKeyPath: keyPath)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
