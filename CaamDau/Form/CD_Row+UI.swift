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
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension CD_TableViewCellBase: CD_RowCellUpdateProtocol {
    public typealias ConfigModel = Any
    public typealias DataSource = CD_TableViewCellBase.Model
    open func row_update(config data: ConfigModel) {
        
    }
    open func row_update(dataSource data: DataSource) {
        self.accessoryType = data.accType
        self.textLabel?.text = data.title ?? ""
        self.textLabel?.textColor = data.titleColor ?? UIColor.cd_hex("3", dark: "f")
        self.textLabel?.font = data.titleFont ?? UIFont.systemFont(ofSize: 15)
        
        self.detailTextLabel?.text = data.detail ?? ""
        self.detailTextLabel?.textColor = data.detailColor ?? UIColor.cd_hex("9", dark:"f0")
        self.detailTextLabel?.font = data.detailFont ?? UIFont.systemFont(ofSize: 13)
        
        if let img = data.icon {
            self.imageView?.image = img
        }
        if let vv = data.accView {
            self.accessoryView = vv
        }
    }
    open func row_update(callBack block: CD_RowCallBack?) {
        
    }
}




//MARK:--- 默认的空 UICollectionViewCell CD_CollectionReusableView ----------
public class CD_CollectionViewCellNone: UICollectionViewCell{
    public static let id:String = "CD_CollectionViewCellNone"
    public static let bundle:String = "CaamDau"
}

extension CD_CollectionViewCellNone: CD_RowCellUpdateProtocol {
    public typealias ConfigModel = Any
    public typealias DataSource = Any
    open func row_update(config data: ConfigModel) {
    }
    open func row_update(dataSource data: DataSource) {
    }
    open func row_update(callBack block: CD_RowCallBack?) {
    }
}



public class CD_CollectionReusableViewNone: UICollectionReusableView {
    public static let id:String = "CD_CollectionReusableViewNone"
    public static let bundle:String = "CaamDau"
}

extension CD_CollectionReusableViewNone: CD_RowCellUpdateProtocol {
    public typealias ConfigModel = Any
    public typealias DataSource = Any
    open func row_update(config data: ConfigModel) {
        
    }
    open func row_update(dataSource data: DataSource) {
        
    }
    open func row_update(callBack block: CD_RowCallBack?) {
        
    }
}
