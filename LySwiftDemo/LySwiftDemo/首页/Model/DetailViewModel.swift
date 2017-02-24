//
//  DetailViewModel.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/23.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class DetailViewModel: NSObject {

    var id : String?
    var video_url : String?
    var title : String?
    var face : String?
    var content : String?
    var study_phase : String?
    var textbook_version : String?
    var praise_num : String?
    var collect_num : String?
    var comment_num : String?
    var size : String?
    var duration : String?
    var volume_one : String?
    var gid : String?
    var grade_name : String?
    var sid : String?
    var subject_name : String?
    var subject_imgcode : String?
    var tid : String?
    var teacher_header : String?
    var teacher_realname : String?
    var played : String?
    var teacher_web_url : String?
    var video_web_url : String?
    var is_collect : String?
    var is_praise : String?
    
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
