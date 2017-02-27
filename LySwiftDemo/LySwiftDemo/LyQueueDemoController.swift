//
//  LyQueueDemoController.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/24.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class LyQueueDemoController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let manager = LyURLSessionManager()
        manager.post(urlString: "", heard: ["" : "" as AnyObject], success: {(dict) -> () in
            
        }, failure: {(error) -> () in
            
        })
        
        let task = LyNetRequstTask()
        task.postRequest(urlString: "", headers: ["" : ""], success: {(dict) -> () in
        }, failure: {(error) -> () in
            
        })
    }

    private func test1() {
    
        //串行
        let serial = DispatchQueue(label: "serialQueue")
        //并行
        let comQueue = DispatchQueue(label: "comQueue", attributes: DispatchQueue.Attributes.concurrent)
        //系统的线程
        let queue = DispatchQueue.global(qos: .default)
        
        serial.async {
            
        }
        
        //主线
        DispatchQueue.main.async {
            
        }
    }
    
    //group，用于多任务请求
    private func test2() {
        
        let queue = DispatchQueue.global(qos: .default)
        let group = DispatchGroup()
        
        group.enter()
        queue.async(group: group, execute: {
            
            //网络请求
            //注意：不过成功还是失败，读需要调用
            group.leave()
        })
        
        group.enter()
        queue.async(group: group, execute: {
            
            //网络请求
            //注意：不过成功还是失败，读需要调用
            group.leave()
        })
        
        group.enter()
        queue.async(group: group, execute: {
            
            //网络请求
            //注意：不过成功还是失败，读需要调用
            group.leave()
        })
        
        //最后结束的地方
        group.notify(queue: DispatchQueue.main, execute: {
            //刷新UI
        })
    }
    
    //信号
    private func test3() {
        
        //获取系统存在的全局队列
        let queue = DispatchQueue.global(qos: .default)
        //创建信号
        let sem = DispatchSemaphore(value: 0)
        
        //请求1
        queue.async {
            //网络请求
            //注意：不过成功还是失败，读需要调用
            sem.signal()
        }
        sem.wait()
        
        //请求2
        queue.async {
            //网络请求
            //注意：不过成功还是失败，读需要调用
            sem.signal()
        }
        sem.wait()
        
        //请求3
        queue.async {
            //网络请求
            //注意：不过成功还是失败，读需要调用
            sem.signal()
        }
        sem.wait()
        
        //最后结束的地方
        DispatchQueue.main.async {
            //刷新UI
        }
    }

}
