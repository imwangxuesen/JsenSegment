# JsenSegment
A custom segment that can custom normal &amp; selected text and image or backgroundColor.Support Swift4.0 and later

# GIF

![GIF](https://github.com/imwangxuesen/JsenSegment/blob/master/JsenSegment.gif)

# Requirements

* iOS 8.0+
* Swift 4.0+

# Communication

•	If you **found a bug**，open an issue.

•	If you **have a feature request**, open an issue.

•	If you **want to contribute**, submit a pull request.
# Installation
[CocoaPods](http://cocoapods.org/) is a dependency manager for Cocoa projects. You can install it with the following command:

```    
pod 'JsenSegment'
```

# Usage

```swift

/// initial
/// 初始化
let segment = JsenSegment.init(frame: CGRect.init(x: 0, y: 50, width: self.view.bounds.width, height: 50))
        
/// title
/// 正常状态时 title 文字
let title = NSAttributedString.init(string: "Click Me",
                                attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15) ,NSAttributedStringKey.foregroundColor : UIColor.blue])
        
/// selected title
/// 选中时 title 文字
let selectedTitle = NSAttributedString.init(string: "Selected Item",
										attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17) ,NSAttributedStringKey.foregroundColor : UIColor.red])
        
/// itemAttribute
/// item属性
let itemAttribute = JsenSegmentItemAttribute.init(title: title,
                                        backgroundColor: UIColor.yellow,
                                                   type: .text, imageName: nil,
                                          selectedTitle: selectedTitle,
                                selectedBackgroundColor: UIColor.groupTableViewBackground,
                                           selectedType: .text, selectedImageName: nil)
        
/// itemAttribute2
let itemAttribute2 = JsenSegmentItemAttribute(title: title,
                                    backgroundColor: UIColor.yellow,
                                      selectedTitle: selectedTitle,
                            selectedBackgroundColor: UIColor.groupTableViewBackground)
        
/// indicatorAttribute
/// 滑块指示器属性
let indicatorAttribute = JsenSegmentIndicatorAttribute.init(color: UIColor.green,
                                                             type: .slider,
                                                           height: 3.0,
                                                         position: .bottom)
        
/// config
/// 配置方法
segment.config(with: indicatorAttribute,
         dataSource: [itemAttribute,itemAttribute2,itemAttribute,itemAttribute2],
      selectedIndex: 0 ,
            panAble: true) { (index) in
    /// item index 变化回调
    print("segment current index:" + String(index))
}
        
self.view.addSubview(segment)
```

