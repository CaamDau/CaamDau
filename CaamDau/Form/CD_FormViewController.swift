//Created  on 2019/12/19 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit




open class CD_FormViewController: UIViewController {
    lazy var stackView: UIStackView = {
        return UIStackView()
    }()
    
    open var safeAreaTop:Bool = false
    open var safeAreaBottom:Bool = true
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        makeStackView()
    }
}

extension CD_FormViewController {
    func makeStackView() {
        self.view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
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


open class CD_FormTableViewController: CD_FormViewController {
    open lazy var tableView: UITableView = {
        return UITableView(frame: CGRect.zero, style: style)
    }()
    open var style:UITableView.Style = .plain
    open var _form:CD_FormProtocol?
    open lazy var _delegateData:CD_FormTableViewDelegateDataSource? = {
        return CD_FormTableViewDelegateDataSource(_form)
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        makeTableView()
    }
}

extension CD_FormTableViewController {
    func makeTableView() {
        stackView.addArrangedSubview(tableView)
        if _form == nil {
            assertionFailure("👉👉👉 - form 未初始化  👻")
        }
        tableView.delegate = _delegateData
        tableView.dataSource = _delegateData
        _delegateData?.makeReloadData(tableView)
    }
}


class CD_FormTableViewControllerSS: CD_FormTableViewController {
    var form:CD_FormProtocol?
    override var _form: CD_FormProtocol? {
        set{
            
        }
        get{
            return _form
        }
    }
}


open class CD_FormCollectionViewController: CD_FormViewController {
    
    open lazy var flowLayout: UICollectionViewLayout = {
        return UICollectionViewFlowLayout()
    }()
    
    open lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    }()
    open var _form:CD_FormProtocol?
    open lazy var _delegateData:CD_FormCollectionViewDelegateDataSource? = {
        return CD_FormCollectionViewDelegateDataSource(_form)
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        makeCollectionView()
    }
}

extension CD_FormCollectionViewController {
    func makeCollectionView() {
        stackView.addArrangedSubview(collectionView)
        if _form == nil {
            assertionFailure("👉👉👉 - form 未初始化  👻")
        }
        collectionView.delegate = _delegateData
        collectionView.dataSource = _delegateData
        _delegateData?.makeReloadData(collectionView)
    }
}
