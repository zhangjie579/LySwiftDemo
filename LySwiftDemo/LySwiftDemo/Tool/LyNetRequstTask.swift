//
//  LyNetRequstTask.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/24.
//  Copyright © 2017年 张杰. All rights reserved.
//  基于Alamofire的封装

import UIKit
import Alamofire
import SwiftyJSON

//请求的类型
enum LyNetRequstMethod {
    case POST
    case GET
}

class LyNetRequstTask: NSObject {

    //MARK: 基本网络请求
    func postRequest(urlString : String , parameters : [String : AnyObject]? = nil, headers : [String : String]? = nil, success :@escaping (_ response : [String : AnyObject])->() , failure : @escaping (_ error : Error)->()) {
        
        dataRequest(method: .POST, urlString: urlString, parameters: parameters, headers: headers, success: success, failure: failure)
    }
    
    func getRequest(urlString : String , parameters : [String : AnyObject]? = nil, headers : [String : String]? = nil, success :@escaping (_ response : [String : AnyObject])->() , failure : @escaping (_ error : Error)->()) {
        
        dataRequest(method: .GET, urlString: urlString, parameters: parameters, headers: headers, success: success, failure: failure)
    }
    
    private func dataRequest(method : LyNetRequstMethod , urlString : String , parameters : [String : AnyObject]? , headers : [String : String]? ,success : @escaping (_ response : [String : AnyObject])->() , failure : @escaping (_ error : Error)->()) {
        
        var string = HTTPMethod.get
        if method == .POST {
            string = HTTPMethod.post
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(urlString, method: string, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            switch response.result {
            case .success(let value) :
                success(value as! [String : AnyObject])
            case .failure(let error) :
                failure(error)
            }
            
        }
    }
    
    func postWithRequest(urlString : String , parameters : [String : String]? , header : [String : String]? , success :@escaping (_ response : [String : AnyObject])->() , failure : @escaping (_ error : Error)->()) {
        
        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: header).responseJSON { (responseData) in
            
            //当请求后response是我们自定义的，这个变量用于接受服务器响应的信息
            //使用switch判断请求是否成功，也就是response的result
            switch responseData.result {
            case .success(let value):
                //当响应成功是，使用临时变量value接受服务器返回的信息并判断是否为[String: AnyObject]类型 如果是那么将其传给其定义方法中的success
                //                    if let value = response.result.value as? [String: AnyObject] {
                success(value as! [String : AnyObject])
                //                    }
                let json = JSON(value)
                print(json)
                
            case .failure(let error):
                failure(error)
                print("error:\(error)")
            }
        }
        
    }
}
