//
//  MyMainViewController.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/27.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class MyMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        view.addSubview(textField)
        textField.frame = CGRect(x: 10, y: 10, width: 200, height: 20)
        view.addSubview(passwordtextField)
        passwordtextField.frame = CGRect(x: 10, y: 40, width: 200, height: 20)
        view.addSubview(btn)
        btn.frame = CGRect(x: 10, y: 100, width: 200, height: 20)
        view.addSubview(footView)
        
//        btnWithRAC()
        
        footDelegate()
    }
    
    //MARK: delegate
    private func footDelegate() {
    
        footView.sing1.observeValues { (value) in
            print("按钮点击\(value)")
        }
    }
    
    //MARK:通知
    private func noti() {
        
        NotificationCenter.default.reactive.notifications(forName: Notification.Name(rawValue: "UIKeyboardWillShowNotification"), object: nil).observeValues { (value) in
            
        }
        
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "name"), object: self)
    }
    
    //MARK:KVO
    private func kvoWithRac() {
        
        view.reactive.values(forKeyPath: "bounds").start { [weak self](rect) in
            print(self?.view ?? "")
            print(rect)
        }
        
    }
    
    //MARK:按钮点击
    private func btnWithRAC() {
        
        //1.点击
        btn.tag = 10
        btn.isEnabled = true
        btn.reactive.controlEvents(.touchUpInside).observeValues { (btn) in
            print("点击了按钮,颜色\(btn.tag)")
        }
    }
    
    // MARK: - 0.创建信号的方法
    func createSignalMehods() {
        // 1.通过信号发生器创建(冷信号)
        let producer = SignalProducer<String, NoError>.init { (observer, _) in
            print("新的订阅，启动操作")
            observer.send(value: "Hello")
            observer.send(value: "World")
        }
        
        let subscriber1 = Observer<String, NoError>(value: { print("观察者1接收到值 \($0)") })
        let subscriber2 = Observer<String, NoError>(value: { print("观察者2接收到值 \($0)") })
        
        print("观察者1订阅信号发生器")
        producer.start(subscriber1)
        print("观察者2订阅信号发生器")
        producer.start(subscriber2)
        //注意：发生器将再次启动工作
        
        // 2.通过管道创建（热信号）
        let (signalA, observerA) = Signal<String, NoError>.pipe()
        let (signalB, observerB) = Signal<String, NoError>.pipe()
        Signal.combineLatest(signalA, signalB).observeValues { (value) in
            print( "收到的值\(value.0) + \(value.1)")
        }
        observerA.send(value: "1")
        //注意:如果加这个就是，发了一次信号就不能再发了
        observerA.sendCompleted()
        observerB.send(value: "2")
        observerB.sendCompleted()
    }
    
    // MARK: - 5.信号联合
    func testZip() {
        let (signalA, observerA) = Signal<Any, NoError>.pipe()
        let (signalB, observerB) = Signal<String, NoError>.pipe()
        
        Signal.zip(signalA, signalB).observeValues { (value) in
            print(value)
        }
        
        signalA.zip(with: signalB).observeValues { (value) in
            
        }
        observerA.send(value: "1")
        observerA.sendCompleted()
        observerB.send(value: "2")
        observerB.sendCompleted()
    }
    
    // MARK: - 10.迭代器
    func testIterator() {
        
        // 数组的迭代器
        let array:[String] = ["name","name2"]
        var arrayIterator =  array.makeIterator()
        while let temp = arrayIterator.next() {
            print(temp)
        }
        
        // swift 系统自带的遍历
        array.forEach { (value) in
            print(value)
        }
        
        // 字典的迭代器
        let dict:[String: String] = ["key":"name", "key1":"name1"]
        var dictIterator =  dict.makeIterator()
        while let temp = dictIterator.next() {
            print(temp)
        }
        
        // swift 系统自带的遍历
        dict.forEach { (key, value) in
            print("\(key) + \(value)")
        }

    }
    
    // MARK: - 6.Scheduler(调度器)延时加载
    func testScheduler() {
        
        // 主线程上延时0.3秒调用
        QueueScheduler.main.schedule(after: Date.init(timeIntervalSinceNow: 0.3)) {
            print("主线程调用")
        }
        
        QueueScheduler.init().schedule(after: Date.init(timeIntervalSinceNow: 0.3)){
            print("子线程调用")
        }
        
    }
    
    func textFieldWithRAC() {
        //1.时时输出text
        textField.reactive.continuousTextValues.observe({
            text in
            print(text)
        })
        
        //kvo
        textField.reactive.values(forKeyPath: "text").start { (text) in
            print(text)
        }
        
        //2.filter作用:过滤   当text>5才会输出
        textField.reactive.continuousTextValues.filter { (text) -> Bool in
            
            return (text?.characters.count)! > 5
            }.observe({
                text in
                print(text)
            })
        
        //3.输出text的长度
        //每一次map接收到的Value事件，它就会运行closure，以closure的返回值作为Value事件发送出去。上面的代码中，我们的text的值映射成text的字符数
        textField.reactive.continuousTextValues.map { (text) -> Int in
            return (text?.characters.count)!
            }.filter { (length) -> Bool in
                return length > 5
            }.observe { (length) in
                print(length)
        }
        
        //4.1(改变属性)使用map与observeValues结合改变属性
        textField.reactive.continuousTextValues
            .map { (text) -> Int in
                return (text?.characters.count)!
            }
            .map { (length) -> UIColor in
                return length > 5 ? UIColor.red : UIColor.yellow
            }
            .observeValues { (backgroundColor) in
                self.textField.backgroundColor = backgroundColor
        }
        
        //4.2
        let sign = textField.reactive.continuousTextValues
            .map { (text) -> Int in
                return (text?.characters.count)!
        }
        
        sign.map { (length) -> UIColor in
            return length > 5 ? UIColor.red : UIColor.yellow
            }.observeValues { (backgroundColor) in
                self.textField.backgroundColor = backgroundColor
        }
        
        //MARK:5.两个信号结合使用
        let nameSign = textField.reactive.continuousTextValues.map { (text) -> Int in
            return (text?.characters.count)!
        }
        let passSign = passwordtextField.reactive.continuousTextValues.map { (text) -> Int in
            return (text?.characters.count)!
        }
        btn.reactive.isEnabled <~ Signal.combineLatest(nameSign, passSign).map({(namelength : Int, passlength : Int) -> Bool in
            
            return namelength >= 1 && passlength > 6
        })
    }
    
    private lazy var btn : UIButton = {
        
        let btn = UIButton()
        btn.setBackgroundImage(LyClassTool.creatImageWithColor(color: UIColor.lightGray), for: .disabled)
        btn.setBackgroundImage(LyClassTool.creatImageWithColor(color: UIColor.blue), for: .normal)
        btn.isEnabled = false
        return btn
    }()

    private lazy var textField : UITextField = {
       
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textColor = UIColor.lightGray
        textField.placeholder = "请输入"
        return textField
    }()
    
    private lazy var passwordtextField : UITextField = {
        
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textColor = UIColor.lightGray
        textField.placeholder = "密码"
        return textField
    }()
    
    private lazy var footView : MyMainFootView = {
        let footView = MyMainFootView()
        footView.frame = CGRect(x: 0, y: 150, width: 200, height: 50)
        return footView
    }()
}
