//
//  JsenSegment.swift
//  UFangSwift
//
//  Created by WangXuesen on 2017/12/8.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

import UIKit

public struct JsenSegmentIndicatorAttribute {
    var color: UIColor = UIColor.green
    var type: JsenSegmentIndicatorType = .none
    var height: CGFloat = 3.0
    var position: JsenSegmentIndicatorPosition = .bottom
}

public enum JsenSegmentIndicatorType {
    case none
    case slider
}

public enum JsenSegmentIndicatorPosition {
    case top
    case bottom
}

public class JsenSegment: UIView {
    
    typealias JsenSegmentSelectedBlock = (Int) -> Void

    fileprivate var collectionView: UICollectionView?
    
    /// segment内容（标题，图片，颜色等）
    fileprivate var dataSource: [JsenSegmentItemAttribute]?
    
    /// 指示器属性
    fileprivate var indicatorAttribute: JsenSegmentIndicatorAttribute = JsenSegmentIndicatorAttribute()
    
    /// 当前选中的idex
    fileprivate var selectedIndex: Int = 0
    
    /// 选中回调
    fileprivate var selectedBlock: JsenSegmentSelectedBlock?
    
    /// 指示器
    fileprivate var indicator: UIView?
    
    /// 默认item的宽
    fileprivate var itemW: CGFloat = 0.0
    
    /// 是否支持滑动手势
    fileprivate var panAble: Bool = true {
        didSet {
            if panAble {
                if let collectionView = self.collectionView {
                    self.panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(JsenSegment.paned(pan:)))
                    self.panGesture!.delegate = self
                    collectionView.addGestureRecognizer(self.panGesture!)
                }
            }
        }
    }
    
    /// 滑动手势
    fileprivate var panGesture: UIPanGestureRecognizer?
    
    /// 初始指示器的frame
    fileprivate var initialIndicatorFrame: CGRect?
    
    /// pan 手势方向 是否是向右
    fileprivate var directionRight:Bool?
    
    
    /// 配置
    ///
    /// - Parameters:
    ///   - indicatorAttribute: 指示器的属性
    ///   - dataSource: 内容
    ///   - selectedIndex: 默认选中的index 默认为 0
    ///   - selectedBlock: 选中回调
    func config(with indicatorAttribute: JsenSegmentIndicatorAttribute?, dataSource: [JsenSegmentItemAttribute]?, selectedIndex: Int = 0, panAble: Bool = false,selectedBlock: @escaping JsenSegmentSelectedBlock) {
        if let tempIndicatorAttribute = indicatorAttribute {
            self.indicatorAttribute = tempIndicatorAttribute
        }
        self.selectedIndex = selectedIndex
        
        self.dataSource = dataSource
        self.selectedBlock = selectedBlock
        
        let layout = JsenSegmentFlowLayout()
        
        let collectionViewWidth = self.bounds.width
        let collectionViewHeight = self.bounds.height - self.indicatorAttribute.height
        var collectionViewY = CGFloat(0.0)
        
        itemW = collectionViewWidth
        if let dataSource = self.dataSource {
            if dataSource.count != 0 {
                itemW = itemW / CGFloat(dataSource.count)
            }
        }
        
        /// 是否有 indicator
        if  self.indicatorAble() {
            self.indicator = UIView.init()
            let indicatorX = CGFloat(self.selectedIndex) * itemW
            var indicatorY = collectionViewHeight
            
            if self.indicatorAttribute.position == .top {
                indicatorY = 0.0
                collectionViewY = self.indicatorAttribute.height
            }
            
            self.indicator?.frame = CGRect.init(x: indicatorX, y: indicatorY, width: itemW, height: self.indicatorAttribute.height)
            self.indicator?.backgroundColor = self.indicatorAttribute.color
            self.addSubview(self.indicator!)
            self.initialIndicatorFrame = self.indicator!.frame
        }
        
        layout.config(itemSize: CGSize.init(width: itemW , height: collectionViewHeight))
        
        let collectionViewFrame = CGRect.init(x: 0, y: collectionViewY, width: collectionViewWidth, height: collectionViewHeight)
        self.collectionView = UICollectionView.init(frame: collectionViewFrame, collectionViewLayout: layout)
        self.collectionView!.delegate = self
        self.collectionView!.dataSource = self
        self.collectionView?.register(JsenSegmentItem.self, forCellWithReuseIdentifier: "JsenSegmentItem")
        self.collectionView?.isScrollEnabled = false
        self.addSubview(self.collectionView!)
        self.collectionView?.reloadData()
        
        /// 是否支持滑动手势
        self.panAble = panAble
        
    }
    
    /// 选中某一个segment
    ///
    /// - Parameter to: 目标index
    func move(to: Int) {
        self.collectionView(self.collectionView!, didSelectItemAt: IndexPath.init(row: to, section: 0))

        /// 更新indicator 的位置
        if let indicator = self.indicator {
            self.initialIndicatorFrame = indicator.frame
        }
    }
    
    /// indicator 是否可用
    private func indicatorAble() -> Bool {
        if self.indicatorAttribute.type != .none && self.indicatorAttribute.height > 0.0 {
            return true
        }
        return false
    }
    
    /// 计算点距离哪一个item index 比较近
    fileprivate func nearestIndex(point: CGPoint, directionRight:Bool) -> Int {
        guard itemW > 0.0 && point.x > 0.0 else {
            return self.selectedIndex
        }
        
        guard let directionRight = self.directionRight else {
            return self.selectedIndex
        }
        
        if directionRight { // 向右滑动
            return min(Int((point.x/itemW).rounded()), max(self.dataSource!.count - 1, 0))
        } else {// 向左滑动
            return min(Int((point.x/itemW).rounded(.down)), max(self.dataSource!.count - 1, 0))
        }
        
    }
    
    /// pan 手势事件
    @objc private func paned(pan: UIPanGestureRecognizer) {
        guard panAble else {
            return
        }
        
        guard self.indicator != nil else {
            return
        }
        
        /// 是否 向右滑动
        switch pan.state {
        case .began:
            break
        case .changed:
            
            var frame = self.initialIndicatorFrame!
            var transferX = pan.translation(in: self.collectionView).x
            if fabsf(Float(transferX)) > Float(itemW) {//滑动距离超出了一个itemW 这时候做限制，不能超出
                if transferX < 0 {
                    transferX = -(itemW)
                }else {
                    transferX = itemW
                }
            }
            frame.origin.x += transferX
            self.indicator?.frame = frame
            self.directionRight = (transferX > CGFloat(0.0))
            
        case .ended, .failed, .cancelled:
            self.move(to: self.nearestIndex(point: (self.indicator?.center)!, directionRight: self.directionRight!))
            
        default: break
        }
    }
}

extension JsenSegment: UIGestureRecognizerDelegate {
    override public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == panGesture {
            if self.indicatorAble() {
                self.indicator?.frame.contains(gestureRecognizer.location(in: self))
            }
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
}

extension JsenSegment: UICollectionViewDelegate,UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let dataSource = self.dataSource {
            return dataSource.count
        }
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "JsenSegmentItem", for: indexPath) as! JsenSegmentItem
        item.update(with: self.dataSource![indexPath.item] ,selected: self.selectedIndex == indexPath.item)
        return item
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        if let block = self.selectedBlock {
            /// 将当前被选中的item 置为非选中
            let selectedIndexPath = IndexPath.init(row: selectedIndex, section: 0)
            let selectedItem = collectionView.cellForItem(at: selectedIndexPath) as! JsenSegmentItem
            selectedItem.update(with: self.dataSource![selectedIndexPath.item], selected: false)
            
            /// 当前用户点击的item
            let currentSelectedItem = collectionView.cellForItem(at: indexPath) as! JsenSegmentItem
            currentSelectedItem.update(with: self.dataSource![indexPath.item], selected: true)
            
            /// indicator 滑动动画
            if self.indicatorAble() {
                let defaultDuration = CGFloat(0.3)
                /// 目标frame x
                let indicatorX = CGFloat(indexPath.item) * self.itemW
                /// 计算剩余的动画时间
                let duration = CGFloat(fabsf(Float(indicatorX) - Float((self.indicator?.frame.origin.x)!))) / itemW * 0.3
                /// 实际动画时间，最长0.3s
                let resultDuration = min(defaultDuration, duration)
                
                UIView.animate(withDuration: TimeInterval(resultDuration), delay: 0.0, options: .curveEaseIn, animations: {
                    
                    self.indicator?.frame = CGRect.init(x: indicatorX,
                                                        y: (self.indicator?.frame.origin.y)!,
                                                        width: (self.indicator?.frame.size.width)!,
                                                        height: (self.indicator?.frame.size.height)!)
                }, completion: nil)
                
            }
            
            
            if self.selectedIndex != indexPath.item { /// 如果当前item 不是 向前被选中的selected item
                block(indexPath.item)
                self.selectedIndex = indexPath.item
            }

        }
    }
}
