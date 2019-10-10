//Created  on 2019/10/10 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit

extension CD_DatePicker {
    public enum Style {
        case yyyy
        case MM
        case yyyyMM
        case MMdd
        case yyyyMMdd
    }
}
open class CD_DatePicker:UIView {
    convenience public init() {
        self.init(frame:.zero)
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
    }
    
    lazy var picker: CD_Picker = {
        let vv = CD_Picker(frame: self.bounds)
        return vv
    }()
    
    var style:Style = .yyyyMMdd {
        didSet{
            makeData(date, animated: true)
        }
    }
    var completionHandler:((Date)->Void)?
    
    open var minYear: Int? {
        didSet{
            makeData(date, animated: true)
        }
    }

    open var maxYear: Int? {
        didSet {
            makeData(date, animated: true)
        }
    }
    
    open var date:Date = Date() {
        didSet{
            makeData(date, animated: true)
        }
    }
    
    func makeUI() {
        self.addSubview(picker)
        picker.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        picker.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        picker.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        makeData(date, animated: true)
    }
    func makeData(_ date: Date, animated:Bool){
        let now = Date().cd_component(.year)
        let years = ((minYear ?? (now-100))...(maxYear ?? (now+100))).map{ "\($0)" }
        let months = (1...12).map{$0.stringValue}
        let days = (1...date.cd_count(of: .day, in: .month)!).map{ $0.stringValue }
        switch style {
        case .yyyy:
            picker.rows = [years]
            picker.select([0:"\(date.cd_component(.year))"], animated: animated)
        case .MM:
            picker.rows = [months]
            picker.select([0:date.cd_component(.month).stringValue], animated: animated)
        case .yyyyMM:
            picker.rows = [years, months]
            picker.select([0:date.cd_component(.year).stringValue,
                1:date.cd_component(.month).stringValue], animated: animated)
        case .MMdd:
            picker.rows = [months, days]
            picker.select([0:date.cd_component(.month).stringValue,
            1:date.cd_component(.day).stringValue], animated: animated)
        case .yyyyMMdd:
            picker.rows = [years, months, days]
            picker.select([0:date.cd_component(.year).stringValue,
            1:date.cd_component(.month).stringValue,
            2:date.cd_component(.day).stringValue], animated: animated)
        }
        picker.completionHandler = { [weak self](component, row, res) in
            self?.makeCompletionHandler(component, row, res)
        }
    }
    
    func makeCompletionHandler(_ component:Int, _ row:Int, _ res:[Int:String]) {
        var res = res
        var format = ""
        switch style {
        case .yyyy:
            format = "yyyy"
        case .MM:
            format = "MM"
        case .yyyyMM:
            format = "yyyy-MM"
        case .MMdd where component == 0:
            let days = (1...date.cd_count(of: .day, in: .month)!).map{ $0.stringValue }
            picker.rows[1] = days
            if !days.contains(res[1] ?? "1") {
                res[1] = days.last!
                picker.select(res, animated: false)
            }
            format = "MM-dd"
        case .MMdd:
            format = "MM-dd"
        case .yyyyMMdd where component == 0 || component == 1:
            let date = (res[0]! + "-" + res[1]!).cd_date("yyyy-MM")
            let days = (1...date!.cd_count(of: .day, in: .month)!).map{ $0.stringValue }
            picker.rows[2] = days
            if !days.contains(res[2] ?? "1") {
                res[2] = days.last!
                picker.select(res, animated: false)
            }
            format = "yyyy-MM-dd"
        case .yyyyMMdd:
            format = "yyyy-MM-dd"
        }
        let keys = res.keys.sorted()
        let values = keys.compactMap{res[$0]}.joined(separator: "-")
        completionHandler?(values.cd_date(format)!)
    }
}
