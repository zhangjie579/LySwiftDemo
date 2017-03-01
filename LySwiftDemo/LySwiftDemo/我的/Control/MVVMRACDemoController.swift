//
//  MVVMRACDemoController.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/28.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class MVVMRACDemoController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    private func creatSignal() {
        let producer = SignalProducer<Any, NoError>.init { (observer, _) in
            print("新的订阅，启动操作")
            observer.send(value: "Hello")
            observer.send(value: "World")
        }
        
        let (signalEmpty , observe) = Signal<Any, NoError>.pipe()
        
        let emptySignal = Signal<Any, NoError>.empty
        let observer = Observer<Any, NoError> { (_) in
            
        }
        Observer<Any, NoError> { (text) in
            
        }

        emptySignal.observe(observe)
        observe.send(value: "")
        emptySignal.observe(observer)
    }

    

}
