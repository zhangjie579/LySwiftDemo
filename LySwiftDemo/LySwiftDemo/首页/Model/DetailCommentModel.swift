//
//  DetailCommentModel.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/23.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class DetailCommentModel: NSObject {

    var id : String?
    var content : String?
    var u_header : String?
    var u_username : String?
    var praise_num : String?
    var created_at : String?
    var is_praise : String?
    
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKeyPath keyPath: String) {
        super.setValue(value, forKeyPath: keyPath)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
