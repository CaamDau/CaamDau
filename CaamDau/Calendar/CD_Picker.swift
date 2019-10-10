//Created  on 2019/10/8 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit





open class CD_Picker: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
    }
    lazy var picker: UIPickerView = {
        let vv = UIPickerView(frame: self.bounds)
        vv.delegate = self
        vv.dataSource = self
        return vv
    }()
    
    open var font:UIFont = .systemFont(ofSize: 16)
    open var color:UIColor = .darkText
    
    open var rows:[[String]] = [] {
        didSet {
            picker.reloadAllComponents()
            
        }
    }
    var _selects:[Int:String] = [:]
    open var completionHandler:((_ component:Int, _ row:Int, _ selects:[Int:String])->Void)?
    
    func select(_ res:[Int:String], animated:Bool) {
        _selects = res
        for item in res where rows.count > item.key && !rows[item.key].isEmpty  {
            picker.selectRow(rows[item.key].firstIndex(of: item.value) ?? 0, inComponent: item.key, animated: animated)
        }
    }
    
    func makeUI(){
        self.addSubview(picker)
        picker.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        picker.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        picker.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
extension CD_Picker: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return rows.count
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rows[component].count
    }
    /*
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rows[component][row]
    }*/
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        
        let lab = UILabel()
        lab.text = rows[component][row]
        lab.textColor = color
        lab.font = font
        lab.textAlignment = .center
        return lab
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard row < rows[component].count else { return }
        _selects[component] = rows[component][row]
        completionHandler?(component, row, _selects)
    }
}
