import UIKit
import Foundation


let timeNow = Date()
print(timeNow)
let timestamp = 1551931160.807485
let time = Date(timeIntervalSince1970: timestamp)
print(time)

extension TimeInterval {
    /// 转时间
    func cd_date(_ since:Date.TimeSince = .s1970) -> Date {
        switch since {
        case .s1970:
            return Date(timeIntervalSince1970: self)
        case .s2001:
            return Date(timeIntervalSinceReferenceDate: self)
        case .s(let d):
            return Date(timeInterval: self, since: d)
        case .sNow:
            return Date(timeIntervalSinceNow: self)
        }
    }
}


extension Date {
    enum TimeSince {
        case s1970
        case s2001
        case sNow
        case s(_ date:Date)
    }
    ///时间戳 | 时间间隔
    func cd_timestamp(_ since:TimeSince = .s1970) -> TimeInterval {
        switch since {
        case .s1970:
            return self.timeIntervalSince1970
        case .s2001:
            return self.timeIntervalSinceReferenceDate
        case .s(let d):
            return self.timeIntervalSince(d)
        case .sNow:
            return self.timeIntervalSinceNow
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
    
    /// 转日历
    func cd_calendar(_ components: Set<Calendar.Component> = [.year, .month, .weekday, .day, .hour, .minute, .second]) -> DateComponents{
        let calendar = Calendar.current
        return calendar.dateComponents(components, from: self)
    }
}

extension String {
    func cd_date(_ format:String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}




timeNow.cd_time()
timeNow.cd_time("MM-dd HH:mm")

110.cd_date(.s2001)
110.cd_date(.s2001).cd_time()

"2019/01/01 12:34:56".cd_date()?.cd_time()

timeNow.cd_calendar()
timeNow.cd_calendar().year
timeNow.cd_calendar().month
timeNow.cd_calendar().weekday
//timeNow.cd_calendar().weekOfYear
//timeNow.cd_calendar().weekOfMonth

