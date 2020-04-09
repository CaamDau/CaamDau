//Created  on 2019/12/19 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * CD_FormViewController 包含两类
 * 1、普通MVVM模式
 * 2、MVC模式
 */




import UIKit

//@IBDesignable
/// ViewController 组装基类，里面包含一个 StackView
open class CD_FormViewController: UIViewController {
    public lazy var stackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        return v
    }()
    /// 头部安全区约束
    open var safeAreaTop:Bool = true
    /// 尾部安全区约束
    open var safeAreaBottom:Bool = true
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cd_hex("f", dark: "0")
        makeStackView()
    }
}

extension CD_FormViewController {
    @objc func makeStackView() {
        self.view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        } else {
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        }
        
        if !safeAreaTop {
            
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        }else if #available(iOS 11.0, *) {
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            stackView.topAnchor.constraint(equalTo: self.topLayoutGuide.topAnchor).isActive = true
        }
        
        if !safeAreaBottom {
            stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        }else if #available(iOS 11.0, *) {
            stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            stackView.topAnchor.constraint(equalTo: self.bottomLayoutGuide.bottomAnchor).isActive = true
        }
    }
}




//@IBDesignable
/// TableViewController 组装基类，Form 协议 下的普通 MVVM 模式
/// 继承自CD_FormViewController，StackView内包含一个 TableView
open class CD_FormTableViewController: CD_FormViewController {
    open lazy var tableView: UITableView = {
        return UITableView(frame: CGRect.zero, style: style)
    }()
    open var style:UITableView.Style = .grouped
    /// 数据源遵循 CD_FormProtocol 协议
    open var _form:CD_FormProtocol?
    /// tableView Delegate DataSource 代理类
    open lazy var _delegateData:CD_FormTableViewDelegateDataSource? = {
        return CD_FormTableViewDelegateDataSource(_form)
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        makeTableView()
    }
}

extension CD_FormTableViewController {
    @objc open func makeTableView() {
        stackView.addArrangedSubview(tableView)
        if _form == nil {
            assertionFailure("👉👉👉 - form 未初始化,可重写 makeTableView 初始化在此之前  👻")
        }
        tableView.delegate = _delegateData
        tableView.dataSource = _delegateData
        _delegateData?.makeReloadData(tableView)
    }
}


//@IBDesignable
/// CollectionViewController 组装基类，Form 协议 下的普通 MVVM 模式
/// 继承自CD_FormViewController，StackView内包含一个 CollectionView
open class CD_FormCollectionViewController: CD_FormViewController {
    
    open lazy var flowLayout: UICollectionViewLayout = {
        return UICollectionViewFlowLayout()
    }()
    
    open lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    }()
    /// 数据源遵循 CD_FormProtocol 协议
    open var _form:CD_FormProtocol?
    /// CollectionView Delegate DataSource DelegateFlowLayout  代理类
    open lazy var _delegateData:CD_FormCollectionViewDelegateDataSource? = {
        return CD_FormCollectionViewDelegateDataSource(_form)
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        makeCollectionView()
    }
}

extension CD_FormCollectionViewController {
    @objc open func makeCollectionView() {
        stackView.addArrangedSubview(collectionView)
        if _form == nil {
            assertionFailure("👉👉👉 - form 未初始化,可重写 makeCollectionView 初始化在此之前  👻")
        }
        collectionView.delegate = _delegateData
        collectionView.dataSource = _delegateData
        _delegateData?.makeReloadData(collectionView)
    }
}






//MARK:--- 如果你依然钟情于MVC模式，那么这个基类将适用 ----------
/// ViewController 组装基类，普通 MVC 模式
/// 内含两个排版 Form 数据源，
/// 已实现基本 TableViewDelegate/DataSource、CollectionViewDelegate/DataSource/DelegateFlowLayout
/// 继承 CD_FormBaseViewController 的基础上课重写，并可实现剩余协议，获得剩余功能
extension CD_FormBaseViewController {
    public struct DataModel {
        /// 单元格数据组配置
        public var _forms:CD_Forms = []
        /// 页首数据组配置
        public var _formHeaders:CD_Form = []
        /// 页尾数据组配置
        public var _formFooters:CD_Form = []
    }
}
open class CD_FormBaseViewController: UIViewController {
    /// TableView 排版组装数据源
    public var tableDatas:DataModel?
    /// CollectionView 排版组装数据源
    public var collectionDatas:DataModel?
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension CD_FormBaseViewController: UITableViewDelegate, UITableViewDataSource  {
    open func numberOfSections(in tableView: UITableView) -> Int {
        return tableDatas?._forms.count ?? 0
    }
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDatas?._forms[section].count ?? 0
    }
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = tableDatas?._forms[indexPath.section][indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.cd.cell(row.cellClass, id:row.cellId, bundleFrom:row.bundleFrom ?? "") ?? UITableViewCell()
        row.bind(cell)
        return cell
    }
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let row = tableDatas?._forms[indexPath.section][indexPath.row] else {
            return
        }
        row.tapBlock?()
    }
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let row = tableDatas?._forms[indexPath.section][indexPath.row] else {
            return 0
        }
        return row.h
    }
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < (tableDatas?._formHeaders.count ?? 0) {
            return tableDatas?._formHeaders[section].h ?? CD.sectionMinH
        }else{
            guard let count = tableDatas?._forms[section].count, count > 0, let top = tableDatas?._forms[section].first?.insets.top, top > 0 else {
                return CD.sectionMinH
            }
            return top
        }
    }
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section < (tableDatas?._formFooters.count ?? 0) {
            return tableDatas?._formFooters[section].h ?? CD.sectionMinH
        }else{
            guard let count = tableDatas?._forms[section].count, count > 0, let bottom = tableDatas?._forms[section].first?.insets.bottom, bottom > 0 else {
                return CD.sectionMinH
            }
            return bottom
        }
    }
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section < (tableDatas?._formHeaders.count ?? 0) else {
            return nil
        }
        guard let row = tableDatas?._formHeaders[section] else {
            return nil
        }
        guard let v = tableView.cd.view(row.cellClass, id:row.cellId, bundleFrom:row.bundleFrom ?? "") else {
            return nil
        }
        row.bind(v)
        return v
    }
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section < (tableDatas?._formFooters.count ?? 0) else {
            return nil
        }
        guard let row = tableDatas?._formFooters[section] else {
            return nil
        }
        guard let v = tableView.cd.view(row.cellClass, id:row.cellId, bundleFrom:row.bundleFrom ?? "") else {
            return nil
        }
        row.bind(v)
        return v
    }
}


extension CD_FormBaseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionDatas?._forms.count ?? 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionDatas?._forms[section].count ?? 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionDatas?._forms[indexPath.section][indexPath.row].size ?? .zero
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let row = collectionDatas?._forms[indexPath.section][indexPath.row] else {
            return collectionView.cd.cell(CD_CollectionViewCellNone.id, indexPath)
        }
        let cell = collectionView.cd.cell(row.cellId, indexPath)
        row.bind(cell)
        return cell
    }
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let row = collectionDatas?._forms[indexPath.section][indexPath.row] else {
            return
        }
        row.tapBlock?()
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if let count = collectionDatas?._formHeaders.count, count > section {
            return collectionDatas!._formHeaders[section].y
        }else{
            return collectionDatas?._forms[section].first?.y ?? 0
        }
        
    }
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if let count = collectionDatas?._formHeaders.count, count > section {
            return collectionDatas!._formHeaders[section].x
        }else{
            return collectionDatas?._forms[section].first?.x ?? 0
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if let count = collectionDatas?._formHeaders.count, count > section {
            return collectionDatas!._formHeaders[section].insets
        }else{
            return collectionDatas?._forms[section].first?.insets ?? .zero
        }
    }
    
    
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        if let count = collectionDatas?._formHeaders.count, count > section {
            return collectionDatas!._formHeaders[section].size
        }else{
            return .zero
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize{
        if let count = collectionDatas?._formFooters.count, count > section {
            return collectionDatas!._formFooters[section].size
        }else{
            return .zero
        }
    }
    
    
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case CaamDau<UICollectionView>.Kind.tHeader.stringValue:
            guard let count = collectionDatas?._formHeaders.count, count > indexPath.section, let row = collectionDatas?._formHeaders[indexPath.section] else {
                return collectionView.cd.view(CD_CollectionReusableViewNone.id, kind, indexPath)
            }
            let v = collectionView.cd.view(row.cellId, kind, indexPath)
            row.bind(v)
            return v
        default:
            guard let count = collectionDatas?._formFooters.count, count > indexPath.section, let row = collectionDatas?._formFooters[indexPath.section] else {
                return collectionView.cd.view(CD_CollectionReusableViewNone.id, kind, indexPath)
            }
            let v = collectionView.cd.view(row.cellId, kind, indexPath)
            row.bind(v)
            return v
        }
    }
}
