//Created  on 2019/3/4 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */




import Foundation

public protocol CD_CountDownProtocol {
    func cd_countDown(withModel model:CD_CountDown.Model, id:String)
}

public class CD_CountDown {
    private init(){}
    public static let shared:CD_CountDown = CD_CountDown()
    ///时间倒计时标识存储 - 区别每个计时队列
    public var timers:[String:CD_CountDown.Timer] = [:]
    
    
}

public extension CD_CountDown {
    /// 计时器
    public class Timer {
        private init(){}
        private var timer:DispatchSourceTimer?
        /// 初始化一个计时器 handler: () -> Bool:是否停止  mainThread:主线程操作
        public init(id:String,
                    repeatSecond:Double,
                    handler:@escaping (() -> Bool),
                    mainThread:@escaping (() -> Void),
                    qos:DispatchQoS = .default) {
            let queue = DispatchQueue(label: id, qos:qos)
            self.timer = DispatchSource.makeTimerSource(queue:queue)
            self.timer?.schedule(wallDeadline:.now(), repeating: .milliseconds(Int(repeatSecond*1000)), leeway: .milliseconds(10))
            self.timer?.setEventHandler { [weak self] in
                //print(tv)
                if handler() {
                    self?.timer?.cancel()
                    self?.timer = nil
                }
                DispatchQueue.main.async(execute: mainThread)
            }
            self.timer?.resume()
        }
    }
    /// 回调类型
    public enum Style {
        case delegate(_ d:CD_CountDownProtocol, _ tag:String, _ remainTime:TimeInterval, _ repeatSecond:Double)
        case notification(_ tag:String, _ remainTime:TimeInterval, _ repeatSecond:Double)
        case callBack( _ tag:String, _ remainTime:TimeInterval, _ repeatSecond:Double, _ block:((CD_CountDown.Model)->Void))
    }
    
    /// 计时模型
    public class Model {
        public var year:Int = 0
        public var month:Int = 0
        public var day:Int = 0
        public var hour:Int = 0
        public var minute:Int = 0
        public var second:Int = 0
        public var millisecond:Int = 0
        
        /// 剩余时间
        public var remainTime:TimeInterval = 0
    }
}


public extension CD_CountDown {
    class func make(id:String,
                    remainTime:TimeInterval,
                    repeatSecond:Double,
                    mainThread block:@escaping ((CD_CountDown.Model) -> Void),
                    qos:DispatchQoS = .default){
        guard !CD_CountDown.shared.timers.keys.contains(id) else {return}
        // 监听用户手动改变系统时间 UIApplicationSignificantTimeChangeNotification
        /*
         NotificationCenter.default.addObserver(forName: UIApplication.Significant.timeChangeNotification, object: nil, queue: nil) { (n) in
         
         }*/
        /// 当前时间
        let endTime = Date().cd_timestamp()+remainTime
        let endDate = endTime.cd_date()
        let time = CD_CountDown.Model()
        time.remainTime = endTime
        CD_CountDown.shared.timers[id] = CD_CountDown.Timer(id: id, repeatSecond: repeatSecond, handler: { () -> Bool in
            /// 当前时间 与 结束时间间隔 即剩余时间
            let nowDate2 = Date()
            let nowTime2 = nowDate2.cd_timestamp()
            let interval = endTime - nowTime2
            let coms = nowDate2.cd_interval( to: endDate)
            if interval <= 0 {
                time.year = 0
                time.month = 0
                time.day = 0
                time.hour = 0
                time.minute = 0
                time.second = 0
                time.millisecond = 0
                time.remainTime = 0
                CD_CountDown.shared.timers.removeValue(forKey: id)
            }else{
                time.year = coms.year ?? 0
                time.month = coms.month ?? 0
                time.day = coms.day ?? 0
                time.hour = coms.hour ?? 0
                time.minute = coms.minute ?? 0
                time.second = coms.second ?? 0
                time.millisecond = Int((interval - TimeInterval(Int(endTime - nowTime2))) * 1000.0)
                time.remainTime = interval
            }
            return interval <= 0
        }, mainThread: {
            block(time)
        }, qos:qos)
    }
}
public extension CD_CountDown {
    class func make(_ style:CD_CountDown.Style, qos:DispatchQoS = .default) {
        switch style {
        case let .delegate(d, id, time, second):
            CD_CountDown.make(id: id, remainTime: time, repeatSecond: second, mainThread: { (model) in
                d.cd_countDown(withModel: model, id:id)
            }, qos: qos)
        case let .notification(id, time, second):
            CD_CountDown.make(id: id, remainTime: time, repeatSecond: second, mainThread: { (model) in
                NotificationCenter.default.post(name: NSNotification.Name(id), object: model)
            }, qos: qos)
        case let .callBack(id, time, second, block):
            CD_CountDown.make(id: id, remainTime: time, repeatSecond: second, mainThread: block, qos: qos)
        }
    }
}
public extension CD_CountDown {
    /// 剩余时间转换 - *提供一个参照样例*
    class func remainTime<T>(_ time:T) -> TimeInterval {
        switch time {
        case let t as String:
            guard let date = t.cd_date() else{
                return 0
            }
            return date.cd_timestamp() - Date().cd_timestamp()
        case let t as (String, String):
            guard let date = t.0.cd_date(t.1) else{
                return 0
            }
            return date.cd_timestamp() - Date().cd_timestamp()
        case let t as Date:
            return t.cd_timestamp() - Date().cd_timestamp()
        default:
            return 0
        }
    }
}

//MARK:--- 延时执行 ----------
public extension CD_CountDown {
    /// 如果时间大于 30 建议使用 CD_CountDown.make
    class func after(_ time:Double, _ block:@escaping (() -> Void)){
        DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: block)
        /*
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
            
        }*/
    }
}
