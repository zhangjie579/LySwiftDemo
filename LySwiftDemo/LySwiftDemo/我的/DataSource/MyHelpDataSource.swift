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
    
    var arrayModel = [MyHelpViewModel]()
    
    override init() {
        super.init()
        
        getData()
    }
    
    private func getData() {
        LyClassTool.loadingAnimation()
        manager.postRequest(urlString: "http://182.254.228.211:9000/index.php/Api/ServiceContact/index", parameters: ["uid" : "1" as AnyObject], success: {[weak self] (dict : [String : AnyObject]) -> () in
            
            LyClassTool.stopAnimation()
            let status = dict["status"] as! NSNumber
            let data = dict["data"] as? [String : AnyObject]
            if status == 0 && data != nil {
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
                
                self?.observeData.send(value: "")
                self?.observeData.sendCompleted()
            }
            
        }, failure: {(error : Error) -> () in
            LyClassTool.stopAnimation()
        })
    }
    
    private lazy var manager : LyNetRequstTask = {
        let manager = LyNetRequstTask()
        return manager
    }()
}
