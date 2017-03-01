//
//  MyHelpViewController.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/28.
//  Copyright © 2017年 张杰. All rights reserved.
//  客服 MMVM + RAC

import UIKit

class MyHelpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initData()
    }
    
    deinit {
        print("销毁了\(self)")
    }
    
    private func initView() {
        title = "客服"
        navigationController?.delegate = self
        view.backgroundColor = define.ColorGray
        view.addSubview(tableView)
        view.addSubview(footView)
        
        //tap底部的view
        footView.signalTap.observe { [weak self](value) in
            print("点击了底部的view")
            
            //告诉dataSource点击了按钮，需要请求服务器
            self?.dataSource.observeTap.send(value: "")
        }
    }
    
    private func initData() {
        
        //通过RAC订阅信号，得到数据，不使用dataSource中的数据源，那样会耦合性高
        dataSource.dataSourceSignal.observeValues { [weak self](value) in
            
            let key = value as? [MyHelpViewModel]
            if key != nil {
                self?.arrayViewModel = key!
                
                self?.tableView.reloadData()
                
                //底部的view
                self?.footView.title = self?.arrayViewModel[0].time!
                let h = MyHelpFootView.getHeight(title: (self?.arrayViewModel[0].time!)!)
                self?.footView.frame = CGRect(x: 0, y: (self?.define.screenH)! -  CGFloat((self?.define.NavBarHeight)!) - h, width: (self?.define.screenW)!, height: h)
            }
            else
            {
                print(value)
            }
        }
//        dataSource.dataSourceSignal.observe { [weak self](event) in
//            
//            if let error = event.error {
//                print(error)
//            }
//            else if let value = event.value {
//                
//                self?.arrayViewModel = value as! [MyHelpViewModel]
//                
//                self?.tableView.reloadData()
//                
//                //底部的view
//                self?.footView.title = self?.arrayViewModel[0].time!
//                let h = MyHelpFootView.getHeight(title: (self?.arrayViewModel[0].time!)!)
//                self?.footView.frame = CGRect(x: 0, y: (self?.define.screenH)! -  CGFloat((self?.define.NavBarHeight)!) - h, width: (self?.define.screenW)!, height: h)
//            }
//        }
    }
    
    lazy var dataSource : MyHelpDataSource = {
        let dataSource = MyHelpDataSource()
        return dataSource
    }()

    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.frame = CGRect(x: 0, y: 0, width: self.define.screenW, height: CGFloat(self.define.screenH) - CGFloat(self.define.NavBarHeight))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = self.define.ColorGray
        tableView.rowHeight = 90
        return tableView
    }()
    
    private lazy var footView : MyHelpFootView = {
        let footView = MyHelpFootView()
        return footView
    }()
    
    private let define = LyUserDefault()
    
    var arrayViewModel = [MyHelpViewModel]()
}

extension MyHelpViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyHelpCell.cellWithTableView(tableView)
        cell.viewModel = arrayViewModel[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MyHelpViewController : UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController == self {
            navigationController.isNavigationBarHidden = false
        } else {
            navigationController.isNavigationBarHidden = true
        }
    }
}
