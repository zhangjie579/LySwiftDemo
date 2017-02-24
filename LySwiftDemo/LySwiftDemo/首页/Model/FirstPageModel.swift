//
//  FirstPageModel.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/22.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class FirstPageModel: NSObject {

    var id : String?
    var title : String?
    var praise_num : String?
    var collect_num : String?
    var comment_num : String?
    var duration : String?
    var gid : String?
    var grade_name : String?
    var sid : String?
    var subject_imgcode : String?
    var tid : String?
    var teacher_header : String?
    var teacher_realname : String?
    var teacher_web_url : String?
    var video_web_url : String?

    
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
