//
//  LyPhotoPlayView.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/23.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class LyPhotoPlayView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        addSubview(pageControl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var array_icon : Array<String>? {
        didSet {
            pageControl.numberOfPages = (array_icon?.count)!
            collectionView.reloadData()
            
            DispatchQueue.main.async {
                
                //1.默认滑到第二组
                let index = IndexPath(row: (self.array_icon?.count)! * 50, section: 0)
                self.collectionView.scrollToItem(at: index, at: UICollectionViewScrollPosition.right, animated: false)
                //2.添加定时器
                self.addTimer()
            }
        }
    }
    
    var timers : Timer?
    
    //添加定时器
    func addTimer() {
        let timer = Timer(timeInterval: 3.0, target: self, selector: #selector(nextImage), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoopMode.defaultRunLoopMode)
        self.timers = timer
    }
    
    //移除定时器
    func removeTimer() {
        timers?.invalidate()
        timers = nil
    }
    
    @objc private func nextImage() {
        
        //1.获得当前页数
        let num = Int(collectionView.contentOffset.x / collectionView.frame.size.width)
        
        //2.如果滑到到了最后一张
        if num == (array_icon?.count)! * 1000 - 1 {
            
            collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .right, animated: true)
            pageControl.currentPage = 0
        } else {
            collectionView.scrollToItem(at: IndexPath(row: num + 1, section: 0), at: .right, animated: true)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = self.bounds
        
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-10)
            make.size.equalTo(CGSize(width: 150, height: 20))
        }
    }
    
    //MARK:懒加载
    private lazy var flayLayOut : LyPhotoFlowLayout = {
       
        let flayLayOut = LyPhotoFlowLayout()
        return flayLayOut
    }()

    lazy var collectionView : UICollectionView = {
       
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: self.flayLayOut)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = true
        return collectionView
    }()
    
    lazy var pageControl : UIPageControl = {
       
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = self.define.ColorBlue
        pageControl.pageIndicatorTintColor = self.define.ColorLightGray
        return pageControl
    }()
    
    private let define = LyUserDefault()
}

extension LyPhotoPlayView : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = array_icon?.count {
            return count * 1000
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = LyCollectionCell.cellWithCollectionViewCell(collectionView, indexPath: indexPath)
        cell.str_icon = array_icon?[indexPath.row % (array_icon?.count)!]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let i = scrollView.contentOffset.x / scrollView.frame.size.width
        
        let num = Int(i + 0.5) % (array_icon?.count)!
        
        pageControl.currentPage = num
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let w = scrollView.frame.size.width
        let num = Int(scrollView.contentOffset.x / w)
        
        //1.如果滑到第0张，让他到第array_icon.count张
        if num == 0 {
            let index = IndexPath(row: (array_icon?.count)!, section: 0)
            collectionView.scrollToItem(at: index, at: .right, animated: false)
            
//            collectionView.setContentOffset(CGPoint(x: CGFloat((array_icon?.count)! * Int(w)), y: 0), animated: false)
        }
        
        //2.在最后1张得时候，让它滑动到第array.count - 1张
        if num == (array_icon?.count)! * 1000 - 1
        {
            let index = IndexPath(row: (array_icon?.count)! - 1, section: 0)
            collectionView.scrollToItem(at: index, at: .right, animated: false)
//            collectionView.setContentOffset(CGPoint(x: CGFloat(((array_icon?.count)! - 1) * Int(w)), y: 0), animated: false)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
}
