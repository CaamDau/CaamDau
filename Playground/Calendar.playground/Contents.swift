//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

public extension Date {
    enum CD_TimeSince {
        case s1970
        case s2001
        case sNow
        case s(_ date:Date)
        
        var rawValue:Int {
            switch self {
            case .s1970:
                return 1970
            case .s2001:
                return 2001
            case .sNow:
                return 1
            case .s(let date):
                return Int(date.cd_timestamp())
            
            }
        }
    }
}

public extension TimeInterval {
    /// 时间戳 转时间
    func cd_date(_ since:Date.CD_TimeSince = .s1970) -> Date {
        switch since {
        case .s1970:
            return Date(timeIntervalSince1970: self)
        case .s2001:
            return Date(timeIntervalSinceReferenceDate: self)
        case .sNow:
            return Date(timeIntervalSinceNow: self)
        case .s(let d):
            return Date(timeInterval: self, since: d)
        }
    }
    /// 时间戳 相对时间转换
    func cd_timestamp(_ from:Date.CD_TimeSince, _ to:Date.CD_TimeSince) -> TimeInterval {
        return self.cd_date(from).cd_timestamp(to)
    }
}

public extension Date {
    /// Returns the timestamp or time interval
    /// 时间戳 | 时间间隔  110.cd_date(.s2001).cd_timestamp(.sNow)
    func cd_timestamp(_ since:CD_TimeSince = .s1970) -> TimeInterval {
        switch since {
        case .s1970:
            return self.timeIntervalSince1970
        case .s2001:
            return self.timeIntervalSinceReferenceDate
        case .sNow:
            return self.timeIntervalSinceNow
        case .s(let d):
            return self.timeIntervalSince(d)
        }
    }
    
    /// 转时间字符串
    func cd_time(_ format:String = "yyyy-MM-dd HH:mm:ss:SSS") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    /// 转时间字符串
    func cd_time(forStyle date:DateFormatter.Style = .none, time:DateFormatter.Style = .none) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = date
        formatter.timeStyle = time
        return formatter.string(from: self)
    }
    
    /// 时间 间隔
    func cd_interval(_ to:Date, components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second], calendar:Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(components, from: self, to: to)
    }
    
    /// 单独取得时间中的单元，
    /// 注意！当 .weekday 的时候，返回的是第几天而非周几，周日是第一天
    /// calendar 默认 Calendar.current，可指定算法
    func cd_component(_ component:Calendar.Component, calendar:Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    /// 转日历 取得时间中的单元组，
    func cd_components(_ components:Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second], calendar:Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(components, from: self)
    }
    
    func cd_count(of smaller: Calendar.Component, in larger: Calendar.Component, calendar:Calendar = Calendar.current) -> Int? {
        return calendar.range(of: smaller, in: larger, for: self)?.count
    }
}

public extension String {
    func cd_date(_ format:String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}

do{
    let time = Date()
    time.cd_component(.era)
    time.cd_component(.year)
    time.cd_component(.month)
    time.cd_component(.day)
    time.cd_component(.hour)
    time.cd_component(.minute)
    time.cd_component(.second)
    time.cd_component(.nanosecond)
    time.cd_component(.timeZone)
    time.cd_component(.weekOfMonth)
    time.cd_component(.weekday, calendar: Calendar(identifier: .chinese))
    
    time.cd_count(of: .day, in: .month)
}


class CD_Picker: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(picker)
        picker.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        picker.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        picker.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    lazy var picker: UIPickerView = {
        let vv = UIPickerView(frame: self.bounds)
        vv.delegate = self
        vv.dataSource = self
        return vv
    }()
    
    var font:UIFont = .systemFont(ofSize: 16)
    var color:UIColor = .darkText
    
    var rows:[[String]] = [] {
        didSet {
            picker.reloadAllComponents()
            
        }
    }
    var _selects:[Int:String] = [:]
    
    func select(_ res:[Int:String], animated:Bool) {
        _selects = res
        for item in res where rows.count > item.key && !rows[item.key].isEmpty  {
            picker.selectRow(rows[item.key].firstIndex(of: item.value) ?? 0, inComponent: item.key, animated: animated)
        }
    }
    var completionHandler:((_ component:Int, _ row:Int, _ selects:[Int:String])->Void)?
}
extension CD_Picker: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return rows.count
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rows[component].count
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let lab = UILabel()
        lab.text = rows[component][row]
        lab.textColor = color
        lab.font = font
        lab.textAlignment = .center
        return lab
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard row < rows[component].count else { return }
        _selects[component] = rows[component][row]
        completionHandler?(component, row, _selects)
    }
}


extension CD_DatePicker {
    enum Style {
        case yyyy
        case MM
        case yyyyMM
        case MMdd
        case yyyyMMdd
    }
}
class CD_DatePicker:UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(picker)
        picker.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        picker.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        picker.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        makeData(date, animated: true)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
    
    func makeData(_ date: Date, animated:Bool){
        let now = Date().cd_component(.year)
        let years = ((minYear ?? (now-100))...(maxYear ?? (now+100))).map{"\($0)"}
        let months = (1...12).map{"\($0)"}
        let days = (1...date.cd_count(of: .day, in: .month)!).map{"\($0)"}
        switch style {
        case .yyyy:
            picker.rows = [years]
            picker.select([0:"\(date.cd_component(.year))"], animated: animated)
        case .MM:
            picker.rows = [months]
            picker.select([0:"\(date.cd_component(.month))"], animated: animated)
        case .yyyyMM:
            picker.rows = [years, months]
            picker.select([0:"\(date.cd_component(.year))",
                1:"\(date.cd_component(.month))"], animated: animated)
        case .MMdd:
            picker.rows = [months, days]
            picker.select([0:"\(date.cd_component(.month))",
            1:"\(date.cd_component(.day))"], animated: animated)
        case .yyyyMMdd:
            picker.rows = [years, months, days]
            picker.select([0:"\(date.cd_component(.year))",
            1:"\(date.cd_component(.month))",
            2:"\(date.cd_component(.day))"], animated: animated)
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
            let days = (1...date.cd_count(of: .day, in: .month)!).map{"\($0)"}
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
            let days = (1...date!.cd_count(of: .day, in: .month)!).map{"\($0)"}
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



class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 100, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        
        do{
            let picker = CD_DatePicker(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
            picker.backgroundColor = .red
            //view.addSubview(picker)
            view.insertSubview(picker, aboveSubview: label)
            picker.style = .yyyy
            picker.completionHandler = { date in
                print(date)
            }
        }
        
        do{
            let picker = UIDatePicker(frame: CGRect(x: 0, y: 300, width: 400, height: 200))
            picker.datePickerMode = .date
            view.addSubview(picker)
        }
        
        
        self.view = view
        
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
