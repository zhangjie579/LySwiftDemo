//
//  MyHelpDataSource.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/28.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class MyHelpDataSource: NSObject {

    //获取数据的信号
    let (dataSourceSignal , observeData) = Signal<Any, NoError>.pipe()
    let (signalWithTap , observeTap) = Signal<Any, NoError>.pipe()
    
    override init() {
        super.init()
        
        getData()
        
        signalWithTap.observeValues { (value) in
            print("请求服务器")
        }
    }
    
    private func getData() {
        LyClassTool.loadingAnimation()
        manager.postRequest(urlString: "http://182.254.228.211:9000/index.php/Api/ServiceContact/index", parameters: ["uid" : "1" as AnyObject], success: {[weak self] (dict : [String : AnyObject]) -> () in
    
            let status = dict["status"] as! NSNumber
            let data = dict["data"] as? [String : AnyObject]
            if status == 0 && data != nil {
                
                LyClassTool.stopAnimation()
                
                let model = MyHelpModel(dict: data! as! [String : String])
                
                if model.qq != nil
                {
                    let viewModel = MyHelpViewModel(model: model, type: .qq)
                    self?.arrayModel.append(viewModel)
                }
                
                if model.phone != nil
                {
                    let viewModel = MyHelpViewModel(model: model, type: .phone)
                    self?.arrayModel.append(viewModel)
                }
                
                if model.weixin != nil
                {
                    let viewModel = MyHelpViewModel(model: model, type: .weixin)
                    self?.arrayModel.append(viewModel)
                }
                
                if model.online_service_url != nil
                {
                    let viewModel = MyHelpViewModel(model: model, type: .online)
                    self?.arrayModel.append(viewModel)
                }
                
                self?.observeData.send(value: self?.arrayModel ?? [MyHelpViewModel]())
            }
            else
            {
                LyClassTool.stopLoadingAnimation(string: dict["info"] as! String)
                self?.observeData.send(value: dict["info"] ?? String())
            }
//            self?.observeData.sendCompleted()
            
        }, failure: {[weak self](error : Error) -> () in
            LyClassTool.stopAnimation()
            self?.observeData.send(error: error as! NoError)
            self?.observeData.sendCompleted()
        })
    }
    
    private lazy var manager : LyNetRequstTask = {
        let manager = LyNetRequstTask()
        return manager
    }()
    
    private var arrayModel = [MyHelpViewModel]()
}
