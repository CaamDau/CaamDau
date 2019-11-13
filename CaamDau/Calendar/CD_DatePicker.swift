//Created  on 2019/10/10 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import UIKit
import CaamDau
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
    var callback:((Date)->Void)?
    
    open var minDate: Date? {
        didSet{
            makeData(date, animated: true)
        }
    }

    open var maxDate: Date? {
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
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        picker.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        picker.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        makeData(date, animated: true)
    }
    func makeData(_ date: Date, animated:Bool){
        if let min = minDate, date < min {
            self.date = min
            return
        }
        if let max = maxDate, date > max {
            self.date = max
            return
        }
        let now = Date().cd_component(.year)
        let years = ((minDate?.cd_component(.year) ?? (now-100))...(maxDate?.cd_component(.year) ?? (now+100))).map{ $0.stringValue }
        switch style {
        case .yyyy:
            picker.rows = [years.compactMap{ CD_Picker.Model(title: $0, isEnabled: true) }]
            picker.select([0:date.cd_component(.year).stringValue], animated: animated)
        case .MM:
            let y = date.cd_component(.year).stringValue
            picker.rows = [getMonths(y, firstYear: y, lastYear: y)]
            picker.select([0:date.cd_component(.month).stringValue], animated: animated)
        case .MMdd:
            let y = date.cd_component(.year).stringValue
            let m = getMonths(y, firstYear: y, lastYear: y)
            let d = getDays(y, firstYear: y, lastYear: y, month: date.cd_component(.month).stringValue)
            picker.rows = [m, d]
            picker.select([0:date.cd_component(.month).stringValue,
                           1:date.cd_component(.day).stringValue], animated: animated)
            
        case .yyyyMM:
            let y = years.compactMap{ CD_Picker.Model(title: $0, isEnabled: true) }
            let m = getMonths(date.cd_component(.year).stringValue, firstYear: years.first!, lastYear: years.last!)
            picker.rows = [y, m]
            var mm = date.cd_component(.month).stringValue
            let mmm = (m.first{$0.isEnabled}?.title.intValue ?? 1)
            mm = mmm > mm.intValue ? mmm.stringValue : mm
            picker.select([0:date.cd_component(.year).stringValue,
                           1: mm], animated: animated)
        case .yyyyMMdd:
            let y = years.compactMap{ CD_Picker.Model(title: $0, isEnabled: true) }
            let m = getMonths(date.cd_component(.year).stringValue, firstYear: years.first!, lastYear: years.last!)
            let d = getDays(date.cd_component(.year).stringValue, firstYear: years.first!, lastYear: years.last!, month: date.cd_component(.month).stringValue)
            picker.rows = [y, m, d]
            
            var mm = date.cd_component(.month).stringValue
            let mmm = (m.first{$0.isEnabled}?.title.intValue ?? 1)
            mm = mmm > mm.intValue ? mmm.stringValue : mm
            
            var dd = date.cd_component(.day).stringValue
            let ddd = (d.first{$0.isEnabled}?.title.intValue ?? 1)
            dd = ddd > dd.intValue ? ddd.stringValue : dd
            picker.select([0:date.cd_component(.year).stringValue, 1:mm, 2:dd], animated: animated)
        }
        picker.callback = { [weak self](component, row, res) in
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
            if let m = (picker.rows[0].first{ $0.isEnabled }), res[0]!.intValue < m.title.intValue  {
                res[0] = m.title
                picker.select(res, animated: true)
            }
            if let m = (picker.rows[0].last{ $0.isEnabled }), res[0]!.intValue > m.title.intValue  {
                res[0] = m.title
                picker.select(res, animated: true)
            }
        case .MMdd:// where component == 0
            format = "MM-dd"
            do{
                if let m = (picker.rows[0].first{ $0.isEnabled }), res[0]!.intValue < m.title.intValue  {
                    res[0] = m.title
                    picker.select(res, animated: true)
                }
                if let m = (picker.rows[0].last{ $0.isEnabled }), res[0]!.intValue > m.title.intValue  {
                    res[0] = m.title
                    picker.select(res, animated: true)
                }
            }
            do{
                let y = date.cd_component(.year).stringValue
                let days = getDays(res[0]!, firstYear: y, lastYear: y, month: res[0]!)
                picker.rows[1] = days
                
                if !(days.contains{ $0.title == (res[1] ?? "1")}) {
                    res[1] = days.last!.title
                    picker.select(res, animated: true)
                }
                if let d = (days.first{ $0.isEnabled }), res[1]!.intValue < d.title.intValue {
                    res[1] = d.title
                    picker.select(res, animated: true)
                }
                if let d = (days.last{ $0.isEnabled }), res[1]!.intValue > d.title.intValue {
                    res[1] = d.title
                    picker.select(res, animated: true)
                }
            }
        case .yyyyMM:// where component == 0
            format = "yyyy-MM"
            picker.rows[1] = getMonths(res[0]!, firstYear: picker.rows[0].first!.title, lastYear: picker.rows[0].last!.title)
            guard let date = (res[0]! + "-" + res[1]!).cd_date(format) else {
                break
            }
            if let min = minDate, date < min, let m = (picker.rows[1].first{ $0.isEnabled }) {
                res[1] = m.title
                picker.select(res, animated: true)
            }
            if let max = maxDate, date > max, let m = (picker.rows[1].last{ $0.isEnabled }) {
                res[1] = m.title
                picker.select(res, animated: true)
            }
        case .yyyyMMdd:// where component == 0 || component == 1:
            format = "yyyy-MM-dd"
            do{
                picker.rows[1] = getMonths(res[0]!, firstYear: picker.rows[0].first!.title, lastYear: picker.rows[0].last!.title)
                guard let date = (res[0]! + "-" + res[1]! + "-" + res[2]!).cd_date(format) else {
                    break
                }
                if let min = minDate, date < min, let m = (picker.rows[1].first{ $0.isEnabled }) {
                    res[1] = m.title
                    picker.select(res, animated: true)
                }
                if let max = maxDate, date > max, let m = (picker.rows[1].last{ $0.isEnabled }) {
                    res[1] = m.title
                    picker.select(res, animated: true)
                }
            }
            do{
                let days = getDays(res[0]!, firstYear: picker.rows[0].first!.title, lastYear: picker.rows[0].last!.title, month: res[1]!)
                picker.rows[2] = days
                
                if !(days.contains{ $0.title == (res[2] ?? "1")}) {
                    res[2] = days.last!.title
                    picker.select(res, animated: true)
                }
                
                guard let date = (res[0]! + "-" + res[1]! + "-" + res[2]!).cd_date(format) else {
                    break
                }
                if let min = minDate, date < min, let d = (picker.rows[2].first{ $0.isEnabled }) {
                    res[2] = d.title
                    picker.select(res, animated: true)
                }
                if let max = maxDate, date > max, let d = (picker.rows[2].last{ $0.isEnabled }) {
                    res[2] = d.title
                    picker.select(res, animated: true)
                }
            }
        }
        let keys = res.keys.sorted()
        let values = keys.compactMap{res[$0]}.joined(separator: "-")
        callback?(values.cd_date(format)!)
    }
}


extension CD_DatePicker {
    fileprivate func getMonths(_ year:String, firstYear:String, lastYear:String) -> [CD_Picker.Model] {
        let months = (1...12).map{$0}
        let models = months.compactMap({ (m) -> CD_Picker.Model? in
            var e = true
            if year == firstYear {
                e = m >= (minDate?.cd_component(.month) ?? 1)
            }
            if year == lastYear {
                e = m <= (maxDate?.cd_component(.month) ?? 12)
            }
            if firstYear == lastYear {
                e = m >= (minDate?.cd_component(.month) ?? 1) && m <= (maxDate?.cd_component(.month) ?? 12)
            }
            let mm = CD_Picker.Model(title: m.stringValue, isEnabled: e)
            return mm
        })
        return models
    }
    
    fileprivate func getDays(_ year:String, firstYear:String, lastYear:String, month:String) -> [CD_Picker.Model] {
        let date = (year + "-" + month).cd_date("yyyy-MM")
        let days = (1...date!.cd_count(of: .day, in: .month)!).map{ $0 }
        let models = days.compactMap { (d) -> CD_Picker.Model? in
            var e = true
            if year == firstYear && month.intValue == (minDate?.cd_component(.month) ?? 1)
                || firstYear == lastYear && month.intValue == (minDate?.cd_component(.month) ?? 1)  {
                e = d >= (minDate?.cd_component(.day) ?? 1)
            }
            if year == lastYear && month.intValue == (maxDate?.cd_component(.month) ?? 12) ||
                firstYear == lastYear && month.intValue == (maxDate?.cd_component(.month) ?? 12) {
                e = d <= (maxDate?.cd_component(.day) ?? 31)
            }
            
            let mm = CD_Picker.Model(title: d.stringValue, isEnabled: e)
            return mm
        }
        return models
    }

}
