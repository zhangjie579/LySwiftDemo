//
//  LyPhotoFlowLayout.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/23.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class LyPhotoFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
        
        let w = collectionView?.frame.size.width
        let h = collectionView?.frame.size.height
        
        itemSize = CGSize(width: w!, height: h!)
        scrollDirection = .horizontal
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
    
}
