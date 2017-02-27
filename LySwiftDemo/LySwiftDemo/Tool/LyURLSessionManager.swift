//
//  LyURLSessionManager.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/25.
//  Copyright © 2017年 张杰. All rights reserved.
//  网络请求

import UIKit

enum LyURLSessionMethod {
    case post
    case get
}

class LyURLSessionManager: NSObject {

    override init() {
        super.init()
    }
    
    func post(urlString : String , heard : [String : AnyObject]? = nil, paramer : [String : AnyObject]? = nil, success : @escaping (_ dict : [String : AnyObject])->() , failure : @escaping (_ error : Error)->()) {
        
        dataTask(method: .post, urlString: urlString, heard: heard, paramer: paramer, success: success, failure: failure)
    }
    
    func get(urlString : String , heard : [String : AnyObject]? = nil, paramer : [String : AnyObject]? = nil, success : @escaping (_ dict : [String : AnyObject])->() , failure : @escaping (_ error : Error)->()) {
        
        dataTask(method: .get, urlString: urlString, heard: heard, paramer: paramer, success: success, failure: failure)
    }
    
    private func dataTask(method : LyURLSessionMethod ,urlString : String , heard : [String : AnyObject]? = nil, paramer : [String : AnyObject]? = nil, success : @escaping (_ dict : [String : AnyObject])->() , failure : @escaping (_ error : Error)->()) -> URLSessionTask {
        
        let request = setUpRequest(method: method, urlString: urlString, heard: heard, paramer: paramer)
        
        let dataTask = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            
            for i in 0 ..< self.arrayTask.count
            {
                if self.arrayTask[i] == response {
                    self.arrayTask.remove(at: i)
                }
            }
            if let err = error
            {
                failure(err)
            }
            else
            {
                let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                success(dict as! [String : AnyObject])
            }
        })
        dataTask.resume()
        
        if let response = dataTask.response{
            arrayTask.append(response)
        }
        return dataTask
    }
    
    //MARK:创建URLRequest
    private func setUpRequest(method : LyURLSessionMethod ,urlString : String , heard : [String : AnyObject]? , paramer : [String : AnyObject]?) -> URLRequest {
        
        var request : URLRequest? = nil
        
        if method == .get
        {
            request = URLRequest.init(url: URL(string: urlString)!, cachePolicy: URLRequest.CachePolicy.returnCacheDataDontLoad, timeoutInterval: 30)
            request?.httpMethod = "POST"
            //请求体
            if let body = paramer {
                request?.httpBody = setBody(paramer: body).data(using: String.Encoding.utf8)
            }
        }
        else
        {
            var string : String?
            if let body = paramer {
                string = urlString + "?" + setBody(paramer: body)
            }
            else {
                string = urlString
            }
            let url = URL(string: string!)
            request = URLRequest.init(url: url!, cachePolicy: URLRequest.CachePolicy.returnCacheDataDontLoad, timeoutInterval: 30)
            request?.httpMethod = "GET"
        }
        
        if let header = heard {
            //请求头
            for (key , value) in header
            {
                request?.setValue(value as? String, forHTTPHeaderField: key)
            }
        }
        
        return request!
    }
    
    //拼接请求参数
    private func setBody(paramer : [String : AnyObject]) -> String {
        
        var string : String?
        
        var array = [String]()
        
        for (key , value) in paramer
        {
            array.append(key)
            
            if array.count == 1
            {
                string?.append("\(key)=\(value)&")
            }
            else
            {
                string?.append("\(key)=\(value)")
            }
        }
        return string!
    }
    
    private lazy var session : URLSession = {
       
        let session = URLSession(configuration: URLSessionConfiguration.default)
        return session
    }()
    
    private var arrayTask = [URLResponse]()
}
