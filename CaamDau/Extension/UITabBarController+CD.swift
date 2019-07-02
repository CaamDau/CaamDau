//Created  on 2019/7/1 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation
import UIKit


public extension CaamDau where Base: UITabBarController {
    @discardableResult
    func add(_ vc:UIViewController) -> CaamDau {
        base.addChild(vc)
        
        return self
    }
    
    @discardableResult
    func viewControllers(_ vc:[UIViewController]) -> CaamDau {
        base.viewControllers = vc
        return self
    }
}


public extension CaamDau where Base: UITabBar {
    
    /// 去掉tabBar顶部线条
    @discardableResult
    func hideLine() -> CaamDau {
       
        let rect = CGRect(x: 0, y: 0, width: base.bounds.size.width, height: 0.5)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(UIColor.clear.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        base.backgroundImage = image
        base.shadowImage = image
        return self
    }
    
    /// 简单添加顶部阴影  background 默认使用 barTintColor，如果 barTintColor 为clear 的话，不会显示阴影，需要设置一个background
    @discardableResult
    func addShadowLine(_ color:UIColor = UIColor.gray, backgroundColor bgColor:UIColor? = nil, layout:((UIView)->Void)? = nil) -> CaamDau {
        self.hideLine()
        let view = UIView(frame: CGRect(x: 0, y: 0, w: base.frame.size.width, h: 0.5)).cd
            .background(bgColor ?? base.barTintColor)
            .shadow(color)
            .shadow(CGSize(w: 0, h: -2))
            .shadow(CGFloat(2.0))
            .shadow(Float(0.8))
            .clips(false)
            .build
        base.cd
            .add(view)
            .clips(false)
        layout?(view)
        return self
    }
    
    
    @discardableResult
    func isTranslucent(_ b:Bool) -> CaamDau {
        base.isTranslucent = b
        return self
    }
    
    @discardableResult
    func barTintColor(_ b:UIColor) -> CaamDau {
        base.barTintColor = b
        return self
    }
    
    
    @discardableResult
    func addTabBarItem(_ item:UITabBarItem) -> CaamDau {
        base.items?.append(item)
        return self
    }
    
    @discardableResult
    func tabBarItems(_ items:[UITabBarItem]) -> CaamDau {
        base.items = items
        return self
    }

    @discardableResult
    func imageInsets(_ t:[UIEdgeInsets]) -> CaamDau {
        base.cd_imageInsets = t
        return self
    }
    
    @discardableResult
    func imageNormals(_ t:[UIImage?]) -> CaamDau {
        base.cd_imageNormals = t
        return self
    }
    
    @discardableResult
    func imageSelects(_ t:[UIImage?]) -> CaamDau {
        base.cd_imageSelects = t
        return self
    }
    @discardableResult
    func titles(_ t:[String?]) -> CaamDau {
        base.cd_titles = t
        return self
    }
    @discardableResult
    func badges(_ t:[String?]) -> CaamDau {
        base.cd_badges = t
        return self
    }
    
    @discardableResult @available(iOS 10.0, *)
    func badgeColors(_ t:[UIColor?]) -> CaamDau {
        base.cd_badgeColors = t
        return self
    }
    
    @discardableResult
    func colorNormals(_ t:[UIColor?]) -> CaamDau {
        base.cd_colorNormals = t
        return self
    }
    @discardableResult
    func colorSelecteds(_ t:[UIColor?]) -> CaamDau {
        base.cd_colorSelecteds = t
        return self
    }
    
    
    @discardableResult
    func colorHighlighteds(_ t:[UIColor?]) -> CaamDau {
        base.cd_colorHighlighteds = t
        return self
    }
    @discardableResult
    func fontNormals(_ t:[UIFont?]) -> CaamDau {
        base.cd_fontNormals = t
        return self
    }
    @discardableResult
    func fontSelecteds(_ t:[UIFont?]) -> CaamDau {
        base.cd_fontSelecteds = t
        return self
    }
    
    @discardableResult
    func fontHighlighteds(_ t:[UIFont?]) -> CaamDau {
        base.cd_fontHighlighteds = t
        return self
    }
    @discardableResult @available(iOS 10.0, *)
    func badgeColorNormals(_ t:[UIColor?]) -> CaamDau {
        base.cd_badgeColorNormals = t
        return self
    }
    @discardableResult @available(iOS 10.0, *)
    func badgeColorSelecteds(_ t:[UIColor?]) -> CaamDau {
        base.cd_badgeColorSelecteds = t
        return self
    }
    @discardableResult @available(iOS 10.0, *)
    func badgeColorHighlighteds(_ t:[UIColor?]) -> CaamDau {
        base.cd_badgeColorHighlighteds = t
        return self
    }
    
    @discardableResult @available(iOS 10.0, *)
    func badgeFontNormals(_ t:[UIFont?]) -> CaamDau {
        base.cd_badgeFontNormals = t
        return self
    }
    
    
    @discardableResult @available(iOS 10.0, *)
    func badgeFontSelecteds(_ t:[UIFont?]) -> CaamDau {
        base.cd_badgeFontSelecteds = t
        return self
    }
    
    
    @discardableResult @available(iOS 10.0, *)
    func badgeFontHighlighteds(_ t:[UIFont?]) -> CaamDau {
        base.cd_badgeFontHighlighteds = t
        return self
    }
    
    @discardableResult
    func color(_ normals:[UIColor?] = [], selecteds:[UIColor?] = [], highlighteds:[UIColor?] = []) -> CaamDau {
        base.cd_colorNormals = normals
        base.cd_colorSelecteds = selecteds
        base.cd_colorHighlighteds = highlighteds
        if #available(iOS 10.0, *) {
            base.cd_badgeColorNormals = normals
            base.cd_badgeColorSelecteds = selecteds
            base.cd_badgeColorHighlighteds = highlighteds
        } else {
            
        }
        return self
    }
    
    @discardableResult
    func font(_ normals:[UIFont?] = [], selecteds:[UIFont?] = [], highlighteds:[UIFont?] = []) -> CaamDau {
        base.cd_fontNormals = normals
        base.cd_fontSelecteds = selecteds
        base.cd_fontHighlighteds = highlighteds
        if #available(iOS 10.0, *) {
            base.cd_badgeFontNormals = normals
            base.cd_badgeFontSelecteds = selecteds
            base.cd_badgeFontHighlighteds = highlighteds
        } else {
            
        }
        return self
    }
    
    //MARK:--- badge ----------
    @discardableResult
    func setTitle<T>(_ value:[T?], key:NSAttributedString.Key, for state: UIControl.State) -> CaamDau {
        guard let items = base.items else { return self}
        for (i, item) in items.enumerated() where i < value.count && value[i] != nil {
            if var attributes = item.titleTextAttributes(for: state) {
                attributes[key] = value[i]
                item.setTitleTextAttributes(attributes, for:state)
            }else{
                item.setTitleTextAttributes([key:value[i]], for:state)
            }
        }
        return self
    }
    
    func getTitle<T>(_ key:NSAttributedString.Key, for state: UIControl.State) -> [T?] {
        let fonts = base.items?.map({ (item) -> T? in
            guard var attributes = item.titleTextAttributes(for: state) else { return nil }
            guard let font = attributes[key] as? T else{ return nil }
            return font
        })
        return fonts ?? []
    }
    
    
    @discardableResult @available(iOS 10.0, *)
    func setBadge<T>(_ value:[T?], key:NSAttributedString.Key, for state: UIControl.State) -> CaamDau {
        guard let items = base.items else { return self}
        for (i, item) in items.enumerated() where i < value.count && value[i] != nil {
            if var attributes = item.badgeTextAttributes(for: state) {
                attributes[key] = value[i]
                item.setBadgeTextAttributes(attributes, for:state)
            }else{
                item.setBadgeTextAttributes([key:value[i]], for:state)
            }
        }
        return self
    }
    
    @available(iOS 10.0, *)
    func getBadge<T>(_ key:NSAttributedString.Key, for state: UIControl.State) -> [T?] {
        let fonts = base.items?.map({ (item) -> T? in
            guard var attributes = item.badgeTextAttributes(for: state) else { return nil }
            guard let font = attributes[key] as? T else{ return nil }
            return font
        })
        return fonts ?? []
    }
}

public extension UITabBar {
    var cd_imageNormals:[UIImage?] {
        set{
            guard let items = self.items else { return }
            for (i, item) in items.enumerated() where i < newValue.count {
                if let img = newValue[i] {
                    item.image = img.withRenderingMode(.alwaysOriginal)
                }
            }
        }
        get{
            return self.items?.map{$0.image} ?? []
        }
    }
    
    var cd_imageSelects:[UIImage?] {
        set{
            guard let items = self.items else { return }
            for (i, item) in items.enumerated() where i < newValue.count {
                if let img = newValue[i] {
                    item.selectedImage = img.withRenderingMode(.alwaysOriginal)
                }
            }
        }
        get{
            return self.items?.map{$0.selectedImage} ?? []
        }
    }
    
    /// 矫正TabBar图片位置
    var cd_imageInsets:[UIEdgeInsets] {
        set{
            guard let items = self.items else { return }
            for (i, item) in items.enumerated() where i < newValue.count {
                item.imageInsets = newValue[i]
            }
        }
        get{
            return self.items?.map{$0.imageInsets} ?? []
        }
    }
    
    var cd_titles:[String?] {
        set{
            guard let items = self.items else { return }
            for (i, item) in items.enumerated() where i < newValue.count {
                item.title = newValue[i]
            }
        }
        get{
            return self.items?.map{$0.title} ?? []
        }
    }
    
    var cd_badges:[String?] {
        set{
            guard let items = self.items else { return }
            for (i, item) in items.enumerated() where i < newValue.count {
                item.badgeValue = newValue[i]
            }
        }
        get{
            return self.items?.map{$0.badgeValue} ?? []
        }
    }
    
    @available(iOS 10.0, *)
    var cd_badgeColors:[UIColor?] {
        set{
            guard let items = self.items else { return }
            for (i, item) in items.enumerated() where i < newValue.count {
                item.badgeColor = newValue[i]
            }
        }
        get{
            return self.items?.map{$0.badgeColor} ?? []
        }
    }
    
    
    
    var cd_colorNormals:[UIColor?] {
        set{
            self.cd.setTitle(newValue, key: .foregroundColor, for: .normal)
        }
        get{
            return self.cd.getTitle(.foregroundColor, for: .normal)
        }
    }
    
    
    var cd_colorSelecteds:[UIColor?] {
        set{
            self.cd.setTitle(newValue, key: .foregroundColor, for: .selected)
        }
        get{
            return self.cd.getTitle(.foregroundColor, for: .selected)
        }
    }
    
    
    var cd_colorHighlighteds:[UIColor?] {
        set{
            self.cd.setTitle(newValue, key: .foregroundColor, for: .highlighted)
        }
        get{
            return self.cd.getTitle(.foregroundColor, for: .highlighted)
        }
    }
    
    var cd_fontNormals:[UIFont?] {
        set{
            self.cd.setTitle(newValue, key: .font, for: .normal)
        }
        get{
            return self.cd.getTitle(.font, for: .normal)
        }
    }
    
    
    var cd_fontSelecteds:[UIFont?] {
        set{
            self.cd.setTitle(newValue, key: .font, for: .selected)
        }
        get{
            return self.cd.getTitle(.font, for: .selected)
        }
    }
    
    
    var cd_fontHighlighteds:[UIFont?] {
        set{
            self.cd.setTitle(newValue, key: .font, for: .highlighted)
        }
        get{
            return self.cd.getTitle(.font, for: .highlighted)
        }
    }
    
    //MARK:--- badge ----------
    
    @available(iOS 10.0, *)
    var cd_badgeColorNormals:[UIColor?] {
        set{
            self.cd.setBadge(newValue, key: .foregroundColor, for: .normal)
        }
        get{
            return self.cd.getBadge(.foregroundColor, for: .normal)
        }
    }
    
    @available(iOS 10.0, *)
    var cd_badgeColorSelecteds:[UIColor?] {
        set{
            self.cd.setBadge(newValue, key: .foregroundColor, for: .selected)
        }
        get{
            return self.cd.getBadge(.foregroundColor, for: .selected)
        }
    }
    
    @available(iOS 10.0, *)
    var cd_badgeColorHighlighteds:[UIColor?] {
        set{
            self.cd.setBadge(newValue, key: .foregroundColor, for: .highlighted)
        }
        get{
            return self.cd.getBadge(.foregroundColor, for: .highlighted)
        }
    }
    
    @available(iOS 10.0, *)
    var cd_badgeFontNormals:[UIFont?] {
        set{
            self.cd.setBadge(newValue, key: .font, for: .normal)
        }
        get{
            return self.cd.getBadge(.font, for: .normal)
        }
    }
    @available(iOS 10.0, *)
    var cd_badgeFontSelecteds:[UIFont?] {
        set{
            self.cd.setBadge(newValue, key: .font, for: .selected)
        }
        get{
            return self.cd.getBadge(.font, for: .selected)
        }
    }
    @available(iOS 10.0, *)
    var cd_badgeFontHighlighteds:[UIFont?] {
        set{
            self.cd.setBadge(newValue, key: .font, for: .highlighted)
        }
        get{
            return self.cd.getBadge(.font, for: .highlighted)
        }
    }
    
    
}
