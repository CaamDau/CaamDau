//Created  on 2019/3/7 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 * 时间处理 工具箱
 */




import Foundation

public extension Date {
    enum CD_TimeSince {
        case s1970
        case s2001
        case sNow
        case s(_ date:Date)
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
    
    /// 转日历
    func cd_calendar(_ components: Set<Calendar.Component> = [.year, .month, .weekday, .day, .hour, .minute, .second]) -> DateComponents {
        let calendar = Calendar.current
        return calendar.dateComponents(components, from: self)
    }
    
    /// 时间 间隔
    func cd_interval(_ components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second], to:Date) -> DateComponents {
        let calendar = Calendar.current
        return calendar.dateComponents(components, from: self, to: to)
    }
}

public extension String {
    func cd_date(_ format:String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}
