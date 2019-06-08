//Created  on 2018/12/13  by LCD :https://github.com/liucaide .

import Foundation
import UIKit

public extension CD where Base: UITableView {
    func cell(_ cellClass:AnyClass, id:String = "", bundleFrom:String = "") -> UITableViewCell? {
        let identifier = id=="" ? String(describing: cellClass) : id
        var cell = base.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil  {
            if bundleFrom.isEmpty {
                let bundle = Bundle.main.path(forResource:identifier, ofType: "nib")
                if bundle == nil{
                    base.register(cellClass, forCellReuseIdentifier: identifier)
                }else{
                    let nib = UINib(nibName:identifier, bundle: nil)
                    base.register(nib, forCellReuseIdentifier: identifier)
                }
            }else{
                let nib = UINib(nibName:identifier, bundle: Bundle.cd_bundle(cellClass, bundleFrom))
                base.register(nib, forCellReuseIdentifier: identifier)
            }
            cell = base.dequeueReusableCell(withIdentifier: identifier)
        }
        guard let ce = cell else {
            assertionFailure("👉👉👉dequeueReusableCell 失败，请检查你的cell  👻")
            return nil
        }
        return ce
    }
    
    func view(_ viewClass:AnyClass, id:String = "", bundleFrom:String = "") -> UITableViewHeaderFooterView? {
        let identifier = id=="" ? String(describing: viewClass) : id
        var cell = base.dequeueReusableHeaderFooterView(withIdentifier: identifier)
        if cell == nil  {
            if bundleFrom.isEmpty {
                let bundle = Bundle.main.path(forResource:identifier, ofType: "nib")
                if bundle == nil{
                    base.register(viewClass, forHeaderFooterViewReuseIdentifier: identifier)
                }else{
                    let nib = UINib(nibName:identifier, bundle: nil)
                    base.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
                }
            }else{
                let nib = UINib(nibName:identifier, bundle: Bundle.cd_bundle(viewClass, bundleFrom))
                base.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
            }
            cell = base.dequeueReusableHeaderFooterView(withIdentifier: identifier)
        }
        guard let ce = cell else {
            assertionFailure("👉👉👉dequeueReusableHeaderFooterView 失败，请检查你的View  👻")
            return nil
        }
        return ce
    }
}


public extension UITableView {
    
}


public class CD_TableViewCellBase: UITableViewCell{
    public struct Model {
        let icon:UIImage?
        let title:String?
        let titleColor:UIColor?
        let titleFont:UIFont?
        
        let detail:String?
        let detailColor:UIColor?
        let detailFont:UIFont?
        let accType: UITableViewCell.AccessoryType
        let accView:UIView?
        public init(icon:UIImage? = nil,
                    title:String? = nil,
                    titleColor:UIColor? = nil,
                    titleFont:UIFont? = nil,
                    detail:String? = nil,
                    detailColor:UIColor? = nil,
                    detailFont:UIFont? = nil,
                    accType:UITableViewCell.AccessoryType = .disclosureIndicator,
                    accView:UIView? = nil) {
            self.icon = icon
            self.title = title
            self.titleColor = titleColor
            self.titleFont = titleFont
            
            self.detail = detail
            self.detailColor = detailColor
            self.detailFont = detailFont
            self.accType = accType
            self.accView = accView
        }
    }
    func update(_ data: CD_TableViewCellBase.Model, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        self.accessoryType = data.accType
        self.textLabel?.cd
            .text(data.title ?? "")
            .text(data.titleColor ?? UIColor.black)
            .text(data.titleFont ?? UIFont.systemFont(ofSize: 14))
        self.detailTextLabel?.cd
            .text(data.detail ?? "")
            .text(data.detailColor ?? UIColor.black)
            .text(data.detailFont ?? UIFont.systemFont(ofSize: 14))
        
        if let img = data.icon {
            self.imageView?.cd.image(img)
        }
        if let vv = data.accView {
            self.accessoryView = vv
        }
    }
}
extension CD_TableViewCellBase:CD_RowUpdateProtocol{
    public typealias DataSource = CD_TableViewCellBase.Model
    public func row_update(_ data: CD_TableViewCellBase.Model, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        self.update(data, id: id, tag: tag, frame: frame, callBack: callBack)
    }
}
