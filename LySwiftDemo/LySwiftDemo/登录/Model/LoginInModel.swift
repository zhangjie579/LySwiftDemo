//
//  LoginInModel.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/22.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class LoginInModel: NSObject {

    var uid : String?
    var cellphone : String?
    var username : String?
    //性别(0:未选择，1:男，2:女).
    var sex : String?
    var header : String?
    //年级id(默认为0,表示未设置年级)
    var gid : String?
    var grade_name : String?
    var created_at : String?
    var updated_at : String?
    var token : String?
    
//    // print时会调用。相当于java中的 toString()。为了代码整洁下面的模型去了这个计算属性。测试时请下载demo
//    override internal var description: String {
//        return "token: \(token) \n header:\(header) \n"
//    }
    
    init(dict : [String : AnyObject]) {
        
        // 必须先初始化对象
        super.init()
        
        // 调用对象的KVC方法字典转模型
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}

class LoginDealModel: NSObject {
    
    //存登录的数据
    class func saveModel(model : LoginInModel) {
        
        let defaults = UserDefaults.standard
        let AllKeys = LyUserDefault()
        defaults.setValue(model.token!, forKey: AllKeys.UserInfo_token)
        defaults.setValue(model.header!, forKey: AllKeys.UserInfo_icon)
        defaults.setValue(model.gid!, forKey: AllKeys.UserInfo_gid)
        defaults.setValue(model.cellphone!, forKey: AllKeys.UserInfo_phonenumber)
        defaults.synchronize()
    }
    
    //删除登录存的数据
    class func removeModel(model : LoginInModel) {
        
        let defaults = UserDefaults.standard
        let AllKeys = LyUserDefault()
        defaults.setValue("", forKey: AllKeys.UserInfo_token)
        defaults.setValue("", forKey: AllKeys.UserInfo_icon)
        defaults.setValue("", forKey: AllKeys.UserInfo_gid)
        defaults.setValue("", forKey: AllKeys.UserInfo_phonenumber)
        defaults.synchronize()
    }
}
