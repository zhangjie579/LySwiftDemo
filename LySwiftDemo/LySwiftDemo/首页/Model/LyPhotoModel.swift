//
//  LyPhotoModel.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/23.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class LyPhotoModel: NSObject {

    var id : String?
    var img : String?
    var content : String?
    var type : String?
    var web_url : String?
    var vid : String?
    
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
