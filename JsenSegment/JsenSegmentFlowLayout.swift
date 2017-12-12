//
//  JsenSegmentFlowLayout.swift
//  UFangSwift
//
//  Created by WangXuesen on 2017/12/8.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

import UIKit

 public class JsenSegmentFlowLayout: UICollectionViewFlowLayout {
    
    func config(itemSize: CGSize) {
        self.itemSize = itemSize
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = 0.0
        self.minimumInteritemSpacing = 0.0
    }
    
}
