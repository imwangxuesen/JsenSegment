//
//  JsenSegmentItem.swift
//  UFangSwift
//
//  Created by WangXuesen on 2017/12/8.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

import UIKit

/// 默认的item icon normal 状态下的图片
public let JsenDefaultImageName:String = "jsen_segment_car_nor.png"

/// 默认的item icon 选中状态下的图片
public let JsenDefaultSelectedImageName:String = "jsen_segment_car_sel.png"

/// item属性
public struct JsenSegmentItemAttribute {
    var title: NSAttributedString?
    var backgroundColor: UIColor
    var type: JsenSegmentItemType
    var imageName: String?
    
    var selectedTitle: NSAttributedString?
    var selectedBackgroundColor: UIColor
    var selectedType: JsenSegmentItemType
    var selectedImageName: String?
    
    
    public static func config(title: NSAttributedString? ,
          backgroundColor: UIColor = UIColor.white ,
          selectedTitle: NSAttributedString? ,
          selectedBackgroundColor: UIColor = UIColor.groupTableViewBackground) -> JsenSegmentItemAttribute {
        
        return self.init(title: title, backgroundColor: backgroundColor, type: JsenSegmentItemType.text, imageName: nil, selectedTitle: selectedTitle, selectedBackgroundColor: selectedBackgroundColor, selectedType: JsenSegmentItemType.text, selectedImageName: nil)
    }
    
    public static func config(backgroundColor: UIColor = UIColor.white ,
         imageName: String? = JsenDefaultImageName ,
         selectedBackgroundColor: UIColor = UIColor.groupTableViewBackground ,
         selectedImageName: String? = JsenDefaultSelectedImageName) -> JsenSegmentItemAttribute{

        return self.init(title: nil, backgroundColor: backgroundColor, type: JsenSegmentItemType.image, imageName: imageName, selectedTitle: nil, selectedBackgroundColor: selectedBackgroundColor, selectedType: JsenSegmentItemType.image, selectedImageName: selectedImageName)
        
    }
    
    public init(title: NSAttributedString? ,
         backgroundColor: UIColor = UIColor.white ,
         type: JsenSegmentItemType = JsenSegmentItemType.text ,
         imageName: String? = JsenDefaultImageName ,
         selectedTitle: NSAttributedString? ,
         selectedBackgroundColor: UIColor = UIColor.groupTableViewBackground ,
         selectedType: JsenSegmentItemType = JsenSegmentItemType.text ,
         selectedImageName: String? = JsenDefaultSelectedImageName) {
        
        if let ltitle = title {
            self.title = ltitle
        }
        self.backgroundColor = backgroundColor
        self.type = type
        
        if let limageName = imageName {
            self.imageName = limageName
        }
        
        if let lselectedTitle = selectedTitle {
            self.selectedTitle = lselectedTitle
        }
        self.selectedBackgroundColor = selectedBackgroundColor
        self.selectedType = selectedType
        
        if let lselectedImageName = selectedImageName {
            self.selectedImageName = lselectedImageName
        }
        
    }
}


/// item 类型
///
/// - text: 展示文字
/// - image: 展示图片
public enum JsenSegmentItemType {
    case text
    case image
}

public class JsenSegmentItem: UICollectionViewCell {
    
    /// icon 正方形，根据当前item 的最短边设置边长
    fileprivate var imageView: UIImageView?
    
    /// 文字label
    fileprivate var titleLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubviews()

    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    func configSubviews() {
        let width = self.bounds.width
        let height = self.bounds.height
        let centerX = width/2.0
        let centerY = height/2.0
        
        let imageW = width > height ? height : width
        
        self.imageView = UIImageView.init(frame: CGRect.init(x: centerX - imageW/2.0, y: centerY - imageW/2.0, width: imageW, height: imageW))
        self.titleLabel = UILabel.init(frame: self.bounds)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.textAlignment = .center
        self.contentView.addSubview(self.imageView!)
        self.contentView.addSubview(self.titleLabel!)
        
    }
    
    
    /// 更新item展示
    ///
    /// - Parameters:
    ///   - attribute: item 属性
    ///   - selected: 是否选中
    public func update(with attribute:JsenSegmentItemAttribute ,selected: Bool) {
        switch attribute.type {
        case .image: /// 图片
            self.imageView?.isHidden = false
            self.titleLabel?.isHidden = true
            let path = Bundle.main.path(forResource: "JsenSegment", ofType: "bundle")
            
            if selected { ///图片选中状态
                if let selectedImageName = attribute.selectedImageName {
                    if selectedImageName == JsenDefaultSelectedImageName {
                        self.imageView?.image = UIImage.init(named: JsenDefaultSelectedImageName, in: Bundle.init(path: path!), compatibleWith: nil)
                    }else {
                        self.imageView?.image = UIImage.init(named: selectedImageName)
                    }
                }else {
                    fatalError("JsenSegment::no select image")
                }
                
            } else { ///图片非选中状态
                if let imageName = attribute.imageName {
                    if imageName == JsenDefaultImageName {
                        self.imageView?.image = UIImage.init(named: JsenDefaultImageName, in: Bundle.init(path: path!), compatibleWith: nil)
                    }else {
                        self.imageView?.image = UIImage.init(named: imageName)
                    }
                }else {
                    fatalError("JsenSegment::no image")
                }
            }
            
        case .text: /// 文字
            self.titleLabel?.isHidden = false
            self.imageView?.isHidden = true
            if selected { /// 文字选中状态
                if let selectedTitle = attribute.selectedTitle {
                    self.titleLabel?.attributedText = selectedTitle
                }else {
                    fatalError("JsenSegment::no select title")
                }
                
            } else { /// 文字非选中状态
                if let title = attribute.title {
                    self.titleLabel?.attributedText = title
                }else {
                    fatalError("JsenSegment::no title")
                }
            }

        }
        
        UIView.animate(withDuration: 0.3) {
            if selected { /// 背景颜色选中状态
                self.contentView.backgroundColor = attribute.selectedBackgroundColor
            }else { /// 背景颜色非选中状态
                self.contentView.backgroundColor = attribute.backgroundColor
            }
        }
    }
    
}
