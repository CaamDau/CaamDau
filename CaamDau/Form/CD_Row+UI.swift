//Created  on 2018/12/13  by LCD :https://github.com/liucaide .

import Foundation

public class CD_TableViewCellBase: UITableViewCell{
    public static let id:String = "CD_CollectionViewCellNone"
    public static let bundle:String = "CaamDau"
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
    public func update(_ data: CD_TableViewCellBase.Model, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        update(dataSource:data)
    }
    public func update(config data: Any) {
        
    }
    public func update(dataSource data: CD_TableViewCellBase.Model) {
        self.accessoryType = data.accType
        self.textLabel?.text = data.title ?? ""
        self.textLabel?.textColor = data.titleColor ?? UIColor.black
        self.textLabel?.font = data.titleFont ?? UIFont.systemFont(ofSize: 14)
        
        self.detailTextLabel?.text = data.detail ?? ""
        self.detailTextLabel?.textColor = data.detailColor ?? UIColor.lightGray
        self.detailTextLabel?.font = data.detailFont ?? UIFont.systemFont(ofSize: 12)
        
        if let img = data.icon {
            self.imageView?.image = img
        }
        if let vv = data.accView {
            self.accessoryView = vv
        }
    }
    
    public func update(callBack block: CD_RowCallBack?) {
        
    }
}
extension CD_TableViewCellBase:CD_RowUpdateProtocol{
    public typealias DataSource = CD_TableViewCellBase.Model
    public func row_update(_ data: CD_TableViewCellBase.Model, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
        self.update(data, id: id, tag: tag, frame: frame, callBack: callBack)
    }
}
extension CD_TableViewCellBase: CD_RowCellUpdateProtocol {
    public typealias ConfigModel = Any
    public func row_update(config data: Any) {
        update(config: data)
    }
    public func row_update(dataSource data: CD_TableViewCellBase.Model) {
        update(dataSource: data)
    }
    public func row_update(callBack block: CD_RowCallBack?) {
        update(callBack: block)
    }
}


//MARK:--- 默认的空 UICollectionViewCell CD_CollectionReusableView ----------
public class CD_CollectionViewCellNone: UICollectionViewCell{
    public static let id:String = "CD_CollectionViewCellNone"
    public static let bundle:String = "CaamDau"
}
extension CD_CollectionViewCellNone:CD_RowUpdateProtocol{
    public typealias DataSource = Any
    public func row_update(_ data: Any, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
    }
}
extension CD_CollectionViewCellNone: CD_RowCellUpdateProtocol {
    public typealias ConfigModel = Any
    public func row_update(config data: Any) {
    }
    public func row_update(dataSource data: Any) {
    }
    public func row_update(callBack block: CD_RowCallBack?) {
    }
}



public class CD_CollectionReusableViewNone: UICollectionReusableView {
    public static let id:String = "CD_CollectionReusableViewNone"
    public static let bundle:String = "CaamDau"
}
extension CD_CollectionReusableViewNone:CD_RowUpdateProtocol{
    public typealias DataSource = Any
    public func row_update(_ data: Any, id: String, tag: Int, frame: CGRect, callBack: CD_RowCallBack?) {
    }
}
extension CD_CollectionReusableViewNone: CD_RowCellUpdateProtocol {
    public typealias ConfigModel = Any
    public func row_update(config data: Any) {
        
    }
    public func row_update(dataSource data: Any) {
        
    }
    public func row_update(callBack block: CD_RowCallBack?) {
        
    }
}
